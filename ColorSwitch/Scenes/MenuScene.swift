//
//  MenuScene.swift
//  ColorSwitch
//
//  Created by Shubh Patel on 2019-01-28.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func sceneDidLoad() {
        
    }

    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255 , green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "ColorSwitch1")
        logo.size = CGSize(width: frame.width/4, height: frame.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels(){
        let playLable =  SKLabelNode(text: "Tap to play!")
        playLable.fontName = "AvenirNext-Bold"
        playLable.fontSize = 50.0
        playLable.fontColor = UIColor.white
        playLable.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLable)
        
        let highScoreLabel = SKLabelNode(text: "High Score: \(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 40.0
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*4)
        addChild(highScoreLabel)
        
        let recentLabel = SKLabelNode(text: "Recent Score: \(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentLabel.fontName = "AvenirNext-Bold"
        recentLabel.fontSize = 40.0
        recentLabel.fontColor = UIColor.white
        recentLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - recentLabel.frame.size.height*2)
        addChild(recentLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view?.presentScene(gameScene)
    }
}
