//
//  GameoverScene.swift
//  ColorSwitch
//
//  Created by Shubh Patel on 2019-01-28.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import SpriteKit

class GameoverScene: SKScene {
    override func sceneDidLoad() {
        
        
        
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255 , green: 62/255, blue: 80/255, alpha: 1.0)
        addLabels()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let menuScene = MenuScene(size: view.bounds.size)
            view.presentScene(menuScene)
        }
    }
    
    
    func addLabels(){
        let mainLabel =  SKLabelNode(text: "Game Over !")
        mainLabel.fontName = "AvenirNext-Bold"
        mainLabel.fontSize = 50.0
        mainLabel.fontColor = UIColor.white
        mainLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(mainLabel)
        
        let ScoreLabel = SKLabelNode(text: "Score: \(UserDefaults.standard.integer(forKey: "RecentScore"))")
        ScoreLabel.fontName = "AvenirNext-Bold"
        ScoreLabel.fontSize = 40.0
        ScoreLabel.fontColor = UIColor.white
        ScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - ScoreLabel.frame.size.height*4)
        addChild(ScoreLabel)
        
    }
    
   
}

