//
//  Hero.swift
//  ForgottenTrail
//
//  Created by Ben Brott & Michael Timpson on 6/20/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import SpriteKit

enum HeroType: String {
    case IcePrincess = "ice"
    case GoldKnight = "gold"
    
    static let allHeros = [GoldKnight, IcePrincess]
}


class Hero: SKSpriteNode {
    
    var heroType : HeroType!
    var heroDirection : String!
    var actionsLeft : UInt!
    
    init(type: HeroType, direction: String = "Back") {
        
        heroType = type
        let imageName = ""
        heroDirection = direction
        actionsLeft = 3
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
    
    func turn(direction: UInt) -> Bool {
        if ((direction == 8 && heroDirection == "Back") ||
            (direction == 8 && heroDirection == "Front") ||
            (direction == 4 && heroDirection == "Back") ||
            (direction == 4 && heroDirection == "Front") ||
            (direction == 2 && heroDirection == "Right") ||
            (direction == 2 && heroDirection == "Left") ||
            (direction == 1 && heroDirection == "Right") ||
            (direction == 1 && heroDirection == "Left"))
        {
            // Don't allow turning 180 degrees
            return false
        }
        
        switch direction {
        case 1:
            heroDirection = "Right"
        case 2:
            heroDirection = "Left"
        case 4:
            heroDirection = "Back"
        case 8:
            heroDirection = "Front"
        default:
            heroDirection = "Front"
        }
        return true

    }
    
    func getName() -> String {
        return heroNames[heroType.rawValue]!
    }
    
    func getAtlas() -> String {
        return heroType.rawValue + heroDirection
    }
}