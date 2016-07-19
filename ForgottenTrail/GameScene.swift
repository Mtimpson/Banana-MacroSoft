//
//  GameScene.swift
//  ForgottenTrail
//
//  Created by Michael Timpson on 6/20/16.
//  Copyright (c) 2016 newBorn Software Development Company. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    var you : Hero!
    var isCreated = false
    var world : SKNode?
    var overlay : SKNode?
    var sceneCamera : SKNode?
    var heroWalkingFrames : [SKTexture]!
    var tempTexture : SKTexture!
    
    override func didMoveToView(view: SKView) {
        
        if !isCreated {
            isCreated = true
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKNode()
            self.world?.name = "world"
            addChild(self.world!)
            
            self.sceneCamera = SKNode()
            self.sceneCamera!.name = "sceneCamera"
            self.world?.addChild(self.sceneCamera!)

            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay!.name = "overlay"
            addChild(self.overlay!)
        }
        
        //moves camera around the scene
        self.sceneCamera?.runAction(SKAction.moveTo(CGPointMake(100, 50), duration: 0.5))
        
        
        self.you = Hero(type: HeroType.GoldKnight)
        updateTextureAtlas()
        you.texture = heroWalkingFrames[0]
        self.world!.addChild(self.you)
        
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
            
            if (you.turn(swipeGesture.direction.rawValue)) {
            
                you.removeFromParent()
                updateTextureAtlas()
                self.addChild(you)
            }
        }
    }
    
    override func didSimulatePhysics() {
        if self.sceneCamera != nil {
            self.centerOnNode(self.sceneCamera!)
        }
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        
        node.parent!.position = CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y)
    }
    
    func updateTextureAtlas() {
        let atlasName = SKTextureAtlas(named: you.getAtlas())
        var walkFrames = [SKTexture]()
        
        let numImages = atlasName.textureNames.count
        print(numImages)
        for var i = 1; i < numImages; i++ {
            let textureName : String = you.getAtlas() + String(i)
            walkFrames.append(atlasName.textureNamed(textureName))
            print(textureName)
        }
        heroWalkingFrames = walkFrames
        walkHero()
        
    }
    
    func walkHero() {
        you.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroWalkingFrames, timePerFrame: 0.1)))
    }

}
