//
//  Bullet.swift
//  PlaneDetection
//
//  Created by Jose Francisco Fornieles on 22/06/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import ARKit

class Bullet: SCNNode {
    
    let speed: Float = 9
    
    init(_ camera: ARCamera) {
        super.init()
        
        let bullet = SCNSphere(radius: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        bullet.materials = [material]
        self.geometry = bullet
        
        let shape = SCNPhysicsShape(geometry: bullet, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        self.physicsBody?.categoryBitMask = Collision.bullet.rawValue
        self.physicsBody?.contactTestBitMask = Collision.plane.rawValue
        
        let matrix = SCNMatrix4(camera.transform)
        let v = -self.speed
        let dir = SCNVector3(v * matrix.m31, v * matrix.m32, v * matrix.m33)
        let pos = SCNVector3(matrix.m41, matrix.m42, matrix.m43)
        
        self.physicsBody?.applyForce(dir, asImpulse: true)
        self.position = pos
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
