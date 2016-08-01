//
//  GameScene.swift
//  ForgottenTrail
//
//  Created by Michael Timpson on 6/20/16.
//  Copyright (c) 2016 newBorn Software Development Company. All rights reserved.
//

import SpriteKit
import UIKit

protocol GameSceneDelegate {
    func launchViewController(scene: SKScene)
}
class GameScene: SKScene {
    var gameOverDelegate : GameSceneDelegate?
    var you : Hero!
    var blur : UIView!
    var isCreated = false
    var world : SKShapeNode?
    var overlay : SKNode?
    var pauseBtn : UIButton!
    var mainMenuBtn : UIButton!
    var sceneCamera : SKCameraNode?
    var heroWalkingFrames : [SKTexture]!
    var tempTexture : SKTexture!
    var move : SKAction!
    var moving = false
    var grid : Grid!
    let pauseImage = UIImage(named: "pause")
    let playImage = UIImage(named: "play")
    var herosLeftLabel : UILabel!
    var stepsLeftLabel : UILabel!
    var usesLeftLabel : UILabel!
    var btnWillPause = true
    
    
       
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
            
            pauseBtn = UIButton(type: .Custom)
            pauseBtn.frame = CGRectMake(0, 0, 50, 50)
            pauseBtn.center = CGPointMake(self.frame.width / 2, self.frame.height - 30)
            pauseBtn.layer.cornerRadius = 0.5 * pauseBtn.bounds.size.width
            pauseBtn.setImage(pauseImage, forState: UIControlState.Normal)
            pauseBtn.imageEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
            pauseBtn.layer.borderWidth = 2
            pauseBtn.layer.borderColor = UIColor.whiteColor().CGColor
            pauseBtn.backgroundColor = UIColor.lightTextColor()
            pauseBtn.reversesTitleShadowWhenHighlighted = true
            pauseBtn.showsTouchWhenHighlighted = true
            pauseBtn.addTarget(self, action: #selector(GameScene.pausePressed), forControlEvents: UIControlEvents.TouchUpInside)
            self.view?.addSubview(pauseBtn)
            
            Music.sharedHelper.menuPlayer?.stop()
            if music {
                Music.sharedHelper.playBackgroundMusic()
            }

            
            let gridSize = 10
            grid = Grid(size: gridSize)
            for row in 0 ..< gridSize {
                for col in 0 ..< gridSize {
                    let tile : SKSpriteNode!
                    switch grid.tiles[row][col] {
                    case 0:
                        tile = SKSpriteNode(imageNamed: "stone.png")
                    case 1:
                        tile = SKSpriteNode(imageNamed: "lava.png")
                    default:
                        tile = SKSpriteNode(imageNamed: "grass.png")
                    }
                    tile.size = CGSizeMake(tileSize, tileSize)
                    tile.zPosition = -10
                    tile.position = CGPointMake(tileSize * CGFloat(col), tileSize * CGFloat(row))
                    tile.name = "" + String(row) + "," + String(col)
                    self.world?.addChild(tile)
                }
            }
        }
        
        //cvartes your current heros animation
        
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
        let moveDur = decisionTime

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
    
    func pausePressed(){
        if btnWillPause {
            paused = true
            
            blur = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            blur.center = CGPointMake(self.frame.width / 2, self.size.height / 2)
            blur.backgroundColor = UIColor.lightTextColor()
            blur.layer.zPosition = -10
            view?.addSubview(blur)
            
            pauseBtn.setImage(playImage, forState: UIControlState.Normal)
            pauseBtn.backgroundColor = UIColor.lightGrayColor()
            pauseBtn.removeFromSuperview()
            self.view?.addSubview(pauseBtn)
            mainMenuBtn = UIButton(type: .Custom)
            mainMenuBtn.frame = CGRectMake(0, 0, 120, 70)
            mainMenuBtn.center = CGPointMake(self.frame.width / 2, self.frame.height / 2 - 100)
            mainMenuBtn.layer.cornerRadius = 0.5 * pauseBtn.bounds.size.width
            mainMenuBtn.setTitle("Main Menu", forState: UIControlState.Normal)
            mainMenuBtn.layer.borderWidth = 2
            mainMenuBtn.layer.borderColor = UIColor.whiteColor().CGColor
            mainMenuBtn.backgroundColor = UIColor.lightGrayColor()
            mainMenuBtn.reversesTitleShadowWhenHighlighted = true
            mainMenuBtn.showsTouchWhenHighlighted = true
            mainMenuBtn.addTarget(self, action: #selector(GameScene.mainMenuPressed), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view?.addSubview(mainMenuBtn)
            
            Music.sharedHelper.gamePlayer?.pause()
            btnWillPause = false
        } else {
            paused = false
            blur.removeFromSuperview()
            mainMenuBtn.removeFromSuperview()
            pauseBtn.setImage(pauseImage, forState: UIControlState.Normal)
            pauseBtn.backgroundColor = UIColor.lightTextColor()
            Music.sharedHelper.gamePlayer?.play()
            btnWillPause = true

        }
    
        
    }
    
    func mainMenuPressed(){
        self.view?.presentScene(nil)
        Music.sharedHelper.gamePlayer?.stop()
        self.gameOverDelegate?.launchViewController(self)
    }
    
}
