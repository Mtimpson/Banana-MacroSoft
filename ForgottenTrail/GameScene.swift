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
    var sceneCamera : SKCameraNode?
    var heroWalkingFrames : [SKTexture]!
    var tempTexture : SKTexture!
    
    override func didMoveToView(view: SKView) {
        
        let bgImage = SKSpriteNode(imageNamed: "bground.png")
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        bgImage.zPosition = -111
        
        
        // adds a 'world', 'camera' to that world and 'you' to that world
        if !isCreated {

            isCreated = true
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKNode()
            self.world?.name = "world"
            addChild(self.world!)
            
            self.sceneCamera = SKCameraNode()
            self.sceneCamera!.name = "sceneCamera"
            self.world?.addChild(self.sceneCamera!)

            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay!.name = "overlay"
            addChild(self.overlay!)
            
            self.world?.addChild(bgImage)
        }
        
        //creates your current heros animation
        
        self.you = Hero(type: heroChosen)
        updateTextureAtlas()
        //you.texture = heroWalkingFrames[0]
        self.world!.addChild(self.you)
        
        //changes direction upon recognition of a swipe
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
        changeHeroPostion()
        //moves camera around the scene
        //self.sceneCamera?.runAction(SKAction.moveTo(CGPointMake(you.position.x, you.position.y), duration: 0))

       

        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            if (you.turn(swipeGesture.direction.rawValue)) {
            
                you.removeFromParent()
                updateTextureAtlas()
                self.world!.addChild(you)
            }
        }
    }
    
    override func didSimulatePhysics() {
        if self.sceneCamera != nil {
           self.centerOnNode(self.you!)
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
        
        for var i = 1; i < numImages; i++ {
            let textureName : String = you.getAtlas() + String(i)
            walkFrames.append(atlasName.textureNamed(textureName))
        }
        heroWalkingFrames = walkFrames
        walkHero()
        
    }
    
    func walkHero() {
        you.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroWalkingFrames, timePerFrame: 0.07)))
    }
    
    func changeHeroPostion() {
        var move : SKAction!
        
        //deterines which way to move the sprite depending on which way it is facing
        if you.heroDirection == "Right" {
            move = SKAction.moveByX(1, y: 0, duration: 0.1)
        }
        if you.heroDirection == "Left" {
            move = SKAction.moveByX(-1, y: 0, duration: 0.1)
        }
        if you.heroDirection == "Front" {
            move = SKAction.moveByX(0, y: -1, duration: 0.1)
        }
        if you.heroDirection == "Back" {
            move = SKAction.moveByX(0, y: 1, duration: 0.1)
        }
        you.runAction(move)

    }

}
