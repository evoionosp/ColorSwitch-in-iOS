//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Shubh Patel on 2019-01-27.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    
    override func sceneDidLoad() {

    }
    
    override func didMove(to view: SKView) {
        setupPhysics() //Set physics environment like gravity etc.
        layoutScene()
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0) //default (dx: 0.0, dy: -9.8)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 39/255 , green: 39/255, blue: 39/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "ColorSwitch")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        
        //colorSwitch Physics
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false //disable gravity
        
        addChild(colorSwitch)
        spawnBall()
    }
    
    func spawnBall() {
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: 30.0, height: 30.0)
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height*2)
        
        //ball Physics
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        
        addChild(ball)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        //01 - Ball and 10 - ColorSwitch
        //Both Combine would be 11. THis way if we have multipal objects in the scene, we can generate unique contactMask.
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //Detect contact between ball and colorswitch
        if (contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory){
            print("C0ntact !")
        }
    }
}
    

