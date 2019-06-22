//
//  Explossion.swift
//  PlaneDetection
//
//  Created by Jose Francisco Fornieles on 22/06/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import ARKit

class Explosion: SCNNode {
    
    static func show(with node: SCNNode, in scene: SCNScene) {
        guard let explossion = SCNParticleSystem(named: "Explosion", inDirectory: nil) else { return }
        let p = node.position
        let translationMatrix = SCNMatrix4MakeTranslation(p.x, p.y, p.z)
        let r = node.rotation
        let rotationMatrix = SCNMatrix4MakeRotation(r.w, r.x, r.y, r.z)
        let transformMatrix = SCNMatrix4Mult(translationMatrix, rotationMatrix)
        explossion.emitterShape = node.geometry
        // explossion.particleSize = 0.1
        scene.addParticleSystem(explossion, transform: transformMatrix)
    }
    
}
