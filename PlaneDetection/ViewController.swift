//
//  ViewController.swift
//  PlaneDetection
//
//  Created by Jose Francisco Fornieles on 22/06/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    var planes = [Plane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard ARWorldTrackingConfiguration.isSupported else {
            return
        }
        
        startTracking()
        
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        
        addNewPlane()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.shootBullet))
        self.sceneView.addGestureRecognizer(tap)
        
        UIApplication.shared.isIdleTimerDisabled = true

    }
    
    func addNewPlane() {
        let plane = Plane()
        self.planes.append(plane)
        self.sceneView.scene.rootNode.addChildNode(plane)
    }
    
    private func startTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @objc func shootBullet() {
        guard let camera = self.sceneView.session.currentFrame?.camera else { return }
        let bullet = Bullet(camera)
        self.sceneView.scene.rootNode.addChildNode(bullet)
    }

}

extension ViewController: ARSCNViewDelegate {

    
}

extension ViewController: ARSessionDelegate {
    
    func sessionInterruptionEnded(_ session: ARSession) {
        startTracking()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        startTracking()
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let cameraOrientation = session.currentFrame?.camera.transform else { return }
        self.planes.forEach { $0.face(to: cameraOrientation) }
    }
    
}

extension ViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let n1 = contact.nodeA
        let n2 = contact.nodeB
        
        print("Collision")
        
        let plane: Plane = (n1 is Plane ? n1 : n2) as! Plane
        
        self.sceneView.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        Explosion.show(with: plane, in: self.sceneView.scene)
        
        self.addNewPlane()
        
    }
}

