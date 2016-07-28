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
    "ice" : "Ice Princess", "gold" : "The Golden Knight", "orc" : "Orcs", "princess0" : "Princesses", "soldier0" : "Warriors", "darkElf0" : "Dark Elves", "pirate0" : "Pirates", "skeleton" : "Skeletons", "traveler0" : "Male Traveler", "traveler1" : "Female Nomad", "banker" : "The Banker"
]
let heroDescriptions: [String:String] = [
    "ice" : "Ben says shes too pretty to not have in the game", "gold" : "The only hero in the realm brave enought to kill those pesky Skeletons and Orcs.", "orc" : "Beasts so vile even the realm's great warriors cower in fear.", "princess0" : "They've stolen the prince's heart along with his keys to the realm.", "soldier0" : "Brave defenders of the realm. Not yet worthy of the title of knight.", "darkElf0" : "Shady beings capable of powers not yet determined.", "pirate0" : "Skilled marauders of the high seas.", "skeleton" : "The undead, capable of unspeakable atrocities.", "traveler0" : "Your basic traveler. Normally spends as much time outdoors as your average Pokémon Go trainer.", "traveler1" : "Enjoys the outdoors. Gravely unprepared to fend off the realms enemies.", "banker0]" : "Everyone knows bankers love currency. 'Put him anywhere on God's green Earth, he'll triple his worth' - Jay-Z"
]
let heroVariants: [String:Int] = [
    "ice" : 1, "gold" : 1, "orc" : 1, "princess0" : 3, "soldier0" : 3, "darkElf0" : 2, "pirate0" : 2, "skeleton" :1, "traveler0" : 1, "traveler1" : 1, "banker" : 1
]

let heroAbilities: [String:String] = [
    "ice" : "Something Icy"
]

let heroAilityUses: [String:Int] = [
    "ice" : 5
]

let heroStepCount : [String:Int] = [
    "ice" : 30
]

let scrollViewPosition : [Int:String] = [
    0 : "traveler0", 1 : "traveler1", 2 : "ice", 3 : "gold", 4 : "soldier0", 5 : "pirate0", 6 : "princess0", 7 : "darkelf0", 8 : "banker", 9 : "orc", 10 : "skeleton"
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




