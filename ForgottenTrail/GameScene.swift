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
    var world : SKNode?
    var overlay : SKNode?
    var pauseBtn : UIButton!
    var mainMenuBtn : UIButton!
    var sceneCamera : SKCameraNode?
    var heroWalkingFrames : [SKTexture]!
    var tempTexture : SKTexture!
    var move : SKAction!
    var moving = false
    var grid : Grid!
    var currentRow : Double!
    var currentColumn : Double!
    var btnWillPause = true
    var playImage = UIImage(named: "play")
    var pauseImage = UIImage(named: "pause")
    var stepLabel : UILabel!
    var usesLabel : UILabel!
    var stepsLeft = Int()
    var usesLeft = Int()
    var heroStack = Stack<HeroType>()
    
    override func didMoveToView(view: SKView) {
        
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
            
            let gridSize = 11
            grid = Grid(size: gridSize, type: Int(arc4random_uniform(2)))
            for tile in grid.tiles {
                self.world?.addChild(tile)
            }
            
            if music {
                Music.sharedHelper.menuPlayer?.stop()
                Music.sharedHelper.playBackgroundMusic()
            }
            
            addOverlayItems()
            
           NSTimer.scheduledTimerWithTimeInterval(frameTime * 4, target: self, selector: #selector(GameScene.updateStepLabel), userInfo: nil, repeats: true)
            
            heroStack.push(heroChosen)
            heroStack.push(HeroType.Soldier0)
            // creates your current heros animation
            self.you = Hero(type: heroChosen)
            you.anchorPoint = CGPointMake(0.5, 0.1)
            let startX = CGFloat(Int(gridSize / 2)) * tileSize
            let startY = CGFloat(0.0)
            you.position = CGPointMake(startX, startY)
            self.world!.addChild(self.you)
            you.turn(UISwipeGestureRecognizerDirection.Up.rawValue)
            changeHeroPostion()

        }
        
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
        //moves camera around the scene
        //self.sceneCamera?.runAction(SKAction.moveTo(CGPointMake(you.position.x, you.position.y), duration: 0))

        if you.heroDirection != you.upcomingDirection {
            you.removeAllActions()
            you.runAction(move)
            you.removeFromParent()
            updateTextureAtlas()
            self.world!.addChild(you)
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
        you.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroWalkingFrames, timePerFrame: frameTime)))
    }
    
    func changeHeroPostion() {
        
        //deterines which way to move the sprite depending on which way it is facing

        if you.upcomingDirection == "Right" {
            move = SKAction.moveByX(moveDist, y: 0, duration: moveDur)
        }
        else if you.upcomingDirection == "Left" {
            move = SKAction.moveByX(-moveDist, y: 0, duration: moveDur)
        }
        else if you.upcomingDirection == "Front" {
            move = SKAction.moveByX(0, y: -moveDist, duration: moveDur)
        }
        else if you.upcomingDirection == "Back" {
            move = SKAction.moveByX(0, y: moveDist, duration: moveDur)
        }
        move = SKAction.repeatActionForever(move)
        
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
            mainMenuBtn.frame = CGRectMake(0, 0, 100, 50)
            mainMenuBtn.center = CGPointMake(self.frame.width / 2, self.frame.height / 2 - 100)
            mainMenuBtn.layer.cornerRadius = 0.5 * pauseBtn.bounds.size.width
            mainMenuBtn.setTitle("Main Menu", forState: UIControlState.Normal)
            mainMenuBtn.layer.borderWidth = 2
            mainMenuBtn.layer.borderColor = UIColor.whiteColor().CGColor
            mainMenuBtn.backgroundColor = UIColor.lightGrayColor()
            mainMenuBtn.reversesTitleShadowWhenHighlighted = true
            mainMenuBtn.showsTouchWhenHighlighted = true
            mainMenuBtn.titleLabel?.font = UIFont(name: "PerfectDOSVGA437Win", size: 16.0)
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
        self.removeFromParent()
        self.view?.presentScene(nil)
        self.gameOverDelegate?.launchViewController(self)
    }
    
    func addOverlayItems(){
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
        
        stepsLeft = heroStepCount[heroChosen.rawValue]!
        stepLabel = UILabel(frame: CGRectMake(2, 2, 150, 20))
        stepLabel.font = UIFont(name: "PerfectDOSVGA437Win", size: 16.0)
        stepLabel.text = "Steps: \(stepsLeft)"
        stepLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(stepLabel)
        
        usesLeft = heroActions[heroChosen.rawValue]!
        usesLabel = UILabel(frame: CGRectMake(2, 2, 150, self.frame.size.width / 2))
        usesLabel.font = UIFont(name: "PerfectDOSVGA437Win", size: 16.0)
        usesLabel.text = "Actions: \(usesLeft)"
        usesLabel.textColor = UIColor.whiteColor()
        view?.addSubview(usesLabel)
        
        
    }
    
    func updateStepLabel(){
        if !paused {
            stepsLeft -= 1
            stepLabel.text = "Steps: \(stepsLeft)"
            if stepsLeft == 0 {
                heroChosen = heroStack.pop()
                you.removeFromParent()
                let direction = you.heroDirection
                let position = you.position
                self.you = Hero(type: heroChosen)
                you.position = position
                self.world?.addChild(self.you)
                centerOnNode(you)
                updateTextureAtlas()
                if direction == "Back" {
                    you.turn(UISwipeGestureRecognizerDirection.Up.rawValue)
                } else if direction == "Left" {
                    you.turn(UISwipeGestureRecognizerDirection.Left.rawValue)
                } else if direction == "Right" {
                    you.turn(UISwipeGestureRecognizerDirection.Right.rawValue)
                } else {
                    you.turn(UISwipeGestureRecognizerDirection.Down.rawValue)
                }
                //changeHeroPostion()
                stepsLeft = heroStepCount[heroChosen.rawValue]!
            }
        }
    }
    
    
}
