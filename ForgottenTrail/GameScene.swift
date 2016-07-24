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
    var world : SKShapeNode?
    var overlay : SKNode?
    var sceneCamera : SKCameraNode?
    var heroWalkingFrames : [SKTexture]!
    var tempTexture : SKTexture!
    var move : SKAction!
    var moving = false
    
    override func didMoveToView(view: SKView) {
        
        
        // adds a 'world', 'camera' to that world and 'you' to that world
        if !isCreated {
            
            isCreated = true
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.world = SKShapeNode(rectOfSize: CGSizeMake(worldWidth, worldHeight))
            self.world?.name = "world"
            addChild(self.world!)
            
            self.sceneCamera = SKCameraNode()
            self.sceneCamera!.name = "sceneCamera"
            self.world?.addChild(self.sceneCamera!)

            self.overlay = SKNode()
            self.overlay?.zPosition = 10
            self.overlay!.name = "overlay"
            addChild(self.overlay!)
            
            
            let grass = SKSpriteNode(imageNamed: "grass.png")
            grass.size = CGSizeMake(tileSize, tileSize)
            grass.position = CGPointMake(tileSize, 0)
            grass.zPosition = -10
            self.world?.addChild(grass)
            let lava = SKSpriteNode(imageNamed: "lava.png")
            lava.size = CGSizeMake(tileSize, tileSize)
            lava.position = CGPointMake(0, tileSize)
            lava.zPosition = -10
            self.world?.addChild(lava)
            let water = SKSpriteNode(imageNamed: "water")
            water.size = CGSizeMake(tileSize, tileSize)
            water.position = CGPointMake(0, 0)
            water.zPosition = -10
            self.world?.addChild(water)
            let stone = SKSpriteNode(imageNamed: "stone")
            stone.size = CGSizeMake(tileSize, tileSize)
            stone.position = CGPointMake(tileSize, tileSize)
            stone.zPosition = -10
            self.world?.addChild(stone)

        }
        
        //creates your current heros animation
        
        self.you = Hero(type: heroChosen)
        updateTextureAtlas()
        //you.texture = heroWalkingFrames[0]
        you.anchorPoint = CGPointMake(0.5, 0.1)
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
        
        
        
        changeHeroPostion()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //moves camera around the scene
        //self.sceneCamera?.runAction(SKAction.moveTo(CGPointMake(you.position.x, you.position.y), duration: 0))

        if !moving {
            moving = true
            if you.heroDirection != you.upcomingDirection {
                you.removeFromParent()
                updateTextureAtlas()
                self.world!.addChild(you)
            }
            you.runAction(move) {
                self.moving = false
            }
        }
        
        if self.sceneCamera != nil {
            self.centerOnNode(self.you!)
        }
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if (you.turn(swipeGesture.direction.rawValue)) {
                changeHeroPostion()
            }
        }
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        
        node.parent!.position = CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y)
    }
    
    func updateTextureAtlas() {
        let atlasName = SKTextureAtlas(named: you.getAtlas())
        print(atlasName.textureNames[0])
        var walkFrames = [SKTexture]()
        let numImages = atlasName.textureNames.count
        
        for i in 1 ..< numImages {
            let textureName: String = you.getAtlas() + String(i)
            walkFrames.append(atlasName.textureNamed(textureName))
        }
        heroWalkingFrames = walkFrames
        walkHero()
        
    }
    
    func walkHero() {
        you.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroWalkingFrames, timePerFrame: 0.1)))
    }
    
    func changeHeroPostion() {
        
        //deterines which way to move the sprite depending on which way it is facing
        let moveDist = tileSize / 2.0
        let moveDur = Double(moveDist / 10.0)

        if you.upcomingDirection == "Right" {
            move = SKAction.moveByX(moveDist, y: 0, duration: moveDur)
        }
        if you.upcomingDirection == "Left" {
            move = SKAction.moveByX(-moveDist, y: 0, duration: moveDur)
        }
        if you.upcomingDirection == "Front" {
            move = SKAction.moveByX(0, y: -moveDist, duration: moveDur)
        }
        if you.upcomingDirection == "Back" {
            move = SKAction.moveByX(0, y: moveDist, duration: moveDur)
        }
        
    }

}
