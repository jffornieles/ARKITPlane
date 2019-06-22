//
//  Plane.swift
//  PlaneDetection
//
//  Created by Jose Francisco Fornieles on 22/06/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation
import ARKit

class Plane: SCNNode {
    
    override init() {
        super.init()
        let scene = SCNScene(named: "Plane.scn")!
        let plane = scene.rootNode.childNode(withName: "Thunder_R reference", recursively: true)
        self.addChildNode(plane!)
        
        self.transform.m43 -= 1.5
        
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        let sequence = SCNAction.sequence([hoverUp, hoverDown])
        let loop = SCNAction.repeatForever(sequence)
        self.runAction(loop)
        
        self.come()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func come() {
        // let pos = self.position
        let move = SCNAction.move(to: SCNVector3(0, 0, 0), duration: 3)
        self.runAction(move)
        self.runAction(move) {
            self.removeFromParentNode()
        }
    }
    
    func face(to cameraOrientation: simd_float4x4) {
        
        var transform = cameraOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }
}
