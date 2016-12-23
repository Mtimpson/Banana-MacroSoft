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
    case Ranger = "ranger"
    case IcePrincess = "ice"
    case GoldKnight = "gold"
    case Orc = "orc"
    case Soldier0 = "soldier0"
    case Princess0 = "princess0"
    case DarkElf0 = "darkelf0"
    case DarkElf1 = "darkelf1"
    case DarkElf2 = "darkelf2"
    case Pirate0 = "pirate0"
    case Pirate1 = "pirate1"
    case Pirate2 = "pirate2"
    case Princess1 = "princess1"
    case Princess2 = "princess2"
    case Skeleton = "skeleton"
    case FallenRanger = "fallenRanger"
    case Soldier1 = "soldier1"
    case Soldier2 = "soldier2"
    case Traveler0 = "traveler0"
    case Traveler1 = "traveler1"
    case SilverSci = "silverSci"
    case Banker = "banker"
    
    
    static let startingHeros = [Traveler0, Traveler1, IcePrincess, Ranger, GoldKnight]
    static let villains = [Orc, Skeleton, FallenRanger]
    static let commonHeros = [Soldier0, Soldier1, Soldier2, Princess0, Princess1, Princess2, DarkElf0, DarkElf1, DarkElf2, Pirate0, Pirate1, Pirate2, Banker]
    //use this one for allHerosScreen
    static let allHerosTypes = [Traveler0, Traveler1, IcePrincess, Ranger, Soldier0, Pirate0, Princess0, DarkElf0, Banker, Orc, Skeleton, GoldKnight, FallenRanger]
    
}


class Hero: SKSpriteNode {
    
    var heroType : HeroType!
    var heroDirection : String!
    var upcomingDirection: String!
    var actionsLeft : Int!
    var steps : Int = 0
    
    init(type: HeroType, direction: String = "", upcoming: String = "") {
        
        heroType = type
        let imageName = ""
        heroDirection = direction
        upcomingDirection = upcoming
        if heroActions[heroType] == nil {
            actionsLeft = 0
        } else {
            actionsLeft = heroActions[heroType]
        }
        if heroSteps[heroType] == nil {
            steps = 0
        } else {
            steps = heroSteps[heroType]!
        }
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clear, size: heroSize)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveDown(_ starSpeed: CGFloat) {
        let moveDown = SKAction.moveBy(x: 0, y: starSpeed, duration: 1)
        run(SKAction.repeatForever(moveDown))
    }
    
    func turn(_ direction: UInt) -> Bool {
        if ((direction == 8 && heroDirection == "Back") ||
            (direction == 8 && upcomingDirection == "Front") ||
            (direction == 4 && heroDirection == "Front") ||
            (direction == 4 && upcomingDirection == "Back") ||
            (direction == 2 && heroDirection == "Right") ||
            (direction == 2 && upcomingDirection == "Left") ||
            (direction == 1 && heroDirection == "Left") ||
            (direction == 1 && upcomingDirection == "Right"))
        {
            // Don't allow turning 180 degrees
            return false
        }
        
        switch direction {
        case 1:
            upcomingDirection = "Right"
        case 2:
            upcomingDirection = "Left"
        case 4:
            upcomingDirection = "Back"
        case 8:
            upcomingDirection = "Front"
        default:
            upcomingDirection = "Front"
        }
        return true

    }
    
    func step() {
        steps -= 1
    }
    
    func getName() -> String {
        return heroNames[heroType]!
    }
    
    func getDescription () -> String {
        return heroDescriptions[heroType]!
    }
    
    func getAtlas() -> String {
        heroDirection = upcomingDirection
        return heroType.rawValue + heroDirection
    }
}
