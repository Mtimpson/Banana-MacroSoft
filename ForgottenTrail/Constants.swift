//
//  Constants.swift
//  ForgottenTrail
//
//  Created by Ben Brott on 6/20/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

let heroSize: CGSize = CGSizeMake(CGFloat(64), CGFloat(64))

let heroNames: [String:String] = [
    "ice" : "Rhoslyn the Ice Princess", "gold" : "Valter the Golden Knight", "orc" : "Orcs", "princess0" : "Princesses", "soldier0" : "Warriors", "darkelf0" : "Dark Elves", "pirate0" : "Pirates", "skeleton" : "Skeletons", "traveler0" : "Hutch the Traveler", "traveler1" : "Aveline the Nomad", "banker" : "The Banker", "ranger" : "Leoril the Ranger", "fallenRanger" : "Fallen Rangers"
]
let heroDescriptions: [String:String] = [
    "ice" : "Versatile, through many years of training in all skills and crafts. ", "gold" : "The only hero in the realm brave enought to kill all those pesky enemines you encounter.", "orc" : "Beasts so vile even the realm's great warriors cower in fear.", "princess0" : "They've stolen the prince's heart along with his keys to the portals.", "soldier0" : "Brave defenders of the realm. Not yet worthy of the title of knight.", "darkelf0" : "Shady beings capable of mysterious powers. Known to enter lava and emerge unscathed.", "pirate0" : "Skilled marauders of the high seas.", "skeleton" : "The undead, capable of unspeakable atrocities.", "traveler0" : "Your basic traveler. Normally spends as much time outdoors as your average Pokémon Go trainer.", "traveler1" : "Enjoys the outdoors. Gravely unprepared to fend off the realm's enemies.", "banker" : "Everyone knows bankers love currency. 'Put him anywhere on God's green Earth, he'll triple his worth' - Jay-Z", "ranger" : "Knows the wilderness like the back of his hand. Skilled in combat and trap making.", "fallenRanger" : "Former rangers, twisted by their death in the wild. Extremely formidable."
]
let heroVariants: [String:Int] = [
    "ice" : 1, "gold" : 1, "orc" : 1, "princess0" : 3, "soldier0" : 3, "darkelf0" : 3, "pirate0" : 3, "skeleton" :1, "traveler0" : 1, "traveler1" : 1, "banker" : 1, "fallenRanger" : 1, "ranger" : 1
]

let heroAbilities: [String:String] = [
    "ice" : "Retains the ability of the hero used before her.", "gold" : "Can rid the realm of Fallen Rangers, Skeletons and Orcs.", "orc" : "Can only be destroyed by Valter the Gold Knight, Leoril the Ranger, or Warriors.", "princess0" : "Able to close the portal without collecting its key.", "soldier0" : "Strong enough to kill the vile Orcs.", "darkelf0" : "May cross lava tiles uninjured.", "pirate0" : "Capable of moving through water tiles.", "skeleton" : "Only Valter the Gold Knight and Leoril the Ranger may kill them.", "traveler0" : "None. You think Pokémon Go players have powers?", "traveler1" : "None. Might be able to construct a campfire.", "banker" : "Doubles the worth of coins collected.", "ranger" : "Bests Orcs and Skeletons in combat.", "fallenRanger" : "Vurnerable only to Valter the Gold Knight"
]

let heroAilityUses: [String:Int] = [
    "traveler0" : 0, "traveler1" : 0, "ice" : 1, "ranger" : 5,  "soldier0" : 3, "pirate0" : 3, "princess0" : 1, "darkelf0" : 3
]

let heroStepCount : [String:Int] = [
    "traveler0" : 30, "traveler1" : 40, "ice" : 40, "ranger" : 55, "gold" : 45, "soldier0" : 35, "pirate0" : 30, "princess0" : 25, "darkelf0" : 30


]

let worldWidth: CGFloat = 1000
let worldHeight: CGFloat = 2000
let tileSize: CGFloat = 200
let decisionTime = 1.0

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}




