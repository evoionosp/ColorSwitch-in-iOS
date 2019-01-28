//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Shubh Patel on 2019-01-27.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PlayColors{
    static let colors = [
        UIColor(red: 255/255, green: 0/255, blue: 128/255, alpha: 1.0), //Pink
        UIColor(red: 53/255, green: 226/255, blue: 242/255, alpha: 1.0), //Blue
        UIColor(red: 245/255, green: 223/255, blue: 15/255, alpha: 1.0), //Yellow
        UIColor(red: 141/255, green: 19/255, blue: 252/255, alpha: 1.0) //Purple
        
        
       
    ]
}

enum SwitchState: Int {
    case pink,blue,yellow,purple
}

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.pink
    var currentColorIndex: Int?
    
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
        colorSwitch = SKSpriteNode(imageNamed: "ColorSwitch1")
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
        
       currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        ball.colorBlendFactor = 1.0 //It make sure color applied to the object
        ball.name="Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height*2)
        
        //ball Physics
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        
        addChild(ball)
    }
    
    func turnCircle() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState
        } else {
            switchState = .pink
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    
    func gameOver() {
        print("Game Over !")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnCircle()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        //01 - Ball and 10 - ColorSwitch
        //Both Combine would be 11. THis way if we have multipal objects in the scene, we can generate unique contactMask.
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //Detect contact between ball and colorswitch
        if (contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory){
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue{
                    print("Correct !")
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                } else {
                    gameOver()
                    self.spawnBall()
                }
            }
        }
    }
}
    

