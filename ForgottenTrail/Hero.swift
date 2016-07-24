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
    case Orc = "orc"
    case Soldier0 = "soldier0"
    case Princess0 = "princess0"
    case DarkElf0 = "darkelf0"
    case DarkElf1 = "darkelf1"
    case Pirate0 = "pirate0"
    case Pirate1 = "pirate1"
    case Princess1 = "princess1"
    case Princess2 = "princess2"
    case Skeleton = "skeleton"
    case Soldier1 = "soldier1"
    case Soldier2 = "soldier2"
    case Traveler0 = "traveler0"
    case Traveler1 = "traveler1"
    
    static let startingHeros = [GoldKnight, IcePrincess]
    static let villans = [Orc]
    static let genericHeros = [Soldier0, Princess0]
    
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
    
    func getDescription () -> String {
        return heroDescriptions[heroType.rawValue]!
    }
    
    func getAtlas() -> String {
        return heroType.rawValue + heroDirection
    }
}