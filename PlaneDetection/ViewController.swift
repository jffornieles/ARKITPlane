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
    
    var plane: Plane!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard ARWorldTrackingConfiguration.isSupported else {
            return
        }
        
        startTracking()
        
        sceneView.session.delegate = self
        sceneView.delegate = self
        
        self.plane = Plane()
        self.sceneView.scene.rootNode.addChildNode(self.plane)
        
        sceneView.showsStatistics = true

    }
    
    private func startTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

}

extension ViewController: ARSCNViewDelegate {
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as? ARPlaneAnchor, let device = sceneView.device else {
//            return
//        }
//
//        let plane = Plane(anchor: planeAnchor, in: device)
//
//        node.addChildNode(plane)
//    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as? ARPlaneAnchor, let plane = node.childNodes.first as? Plane else {
//            return
//        }
//
//        if let planeGeometry = plane.mesh.geometry as? ARSCNPlaneGeometry {
//            planeGeometry.update(from: planeAnchor.geometry)
//        }
//    }
    
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
        self.plane.face(to: cameraOrientation)
    }
    
}

