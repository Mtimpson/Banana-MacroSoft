//
//  GameScene.swift
//  ForgottenTrail
//
//  Created by Michael Timpson on 6/20/16.
//  Copyright (c) 2016 newBorn Software Development Company. All rights reserved.
//

import SpriteKit

var you : SKSpriteNode!


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        you = SKSpriteNode(imageNamed: "pirateBack")
        self.addChild(you)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view!.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view!.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view!.addGestureRecognizer(swipeLeft)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view!.addGestureRecognizer(swipeUp)

    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                you.removeFromParent()
                you = SKSpriteNode(imageNamed: "pirateRight")
                self.addChild(you)
                
            case UISwipeGestureRecognizerDirection.Down:
                you.removeFromParent()
                you = SKSpriteNode(imageNamed: "pirateFront")
                self.addChild(you)
                
            case UISwipeGestureRecognizerDirection.Left:
                you.removeFromParent()
                you = SKSpriteNode(imageNamed: "pirateLeft")
                self.addChild(you)
                
            case UISwipeGestureRecognizerDirection.Up:
                you.removeFromParent()
                you = SKSpriteNode(imageNamed: "pirateBack")
                self.addChild(you)
                
            default:
                break
            }
        }
    }
}
