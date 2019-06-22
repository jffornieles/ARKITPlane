//
//  Collision.swift
//  PlaneDetection
//
//  Created by Jose Francisco Fornieles on 22/06/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

struct Collision: OptionSet {
    let rawValue: Int
    
    static let plane = Collision(rawValue: 1 << 0)
    static let bullet = Collision(rawValue: 1 << 1)
    
    static let all: [Collision] = [.plane, .bullet]
    
}
