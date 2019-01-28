//
//  Settings.swift
//  ColorSwitch
//
//  Created by Shubh Patel on 2019-01-27.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1  // =1  (01)
    static let switchCategory: UInt32 = 0x1 << 1 // =10 (10)
}

enum ZPositions {
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorswitch: CGFloat = 2
}
