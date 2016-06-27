//
//  Hero.swift
//  ForgottenTrail
//
//  Created by Ben Brott & Michael Timpson on 6/20/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import SpriteKit

var heroWalkingFrames: [SKTexture]!

enum HeroType {
    case Pirate
    case ArabianGirl
    case Death
    case Drow
    case PurpleGuy
    case German
    case Hooded
}

enum HeroDirection {
    case Up, Down, Left, Right
}

class Hero: SKSpriteNode {
    
    var heroDirection: HeroDirection = .Down
    var actionsLeft: UInt32 = 3
    
    init(type: HeroType) {
        
        let imageName = ""
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clearColor(), size: heroSize)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveDown(starSpeed: CGFloat) {
        let moveDown = SKAction.moveByX(0, y: starSpeed, duration: 1)
        runAction(SKAction.repeatActionForever(moveDown))
    }
    
    //func walkHero() {
        // General runAction method to make the chopper blades spin.
      //  HeroType.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)))
    //}
    
    func turn(direction: HeroDirection) {
        if (heroDirection == direction) ||
            (direction == HeroDirection.Down && heroDirection == HeroDirection.Up) ||
            (direction == HeroDirection.Up && heroDirection == HeroDirection.Down) ||
            (direction == HeroDirection.Left && heroDirection == HeroDirection.Right) ||
            (direction == HeroDirection.Right && heroDirection == HeroDirection.Left)
        {
            return
        }
        
        heroDirection = direction
    }
}