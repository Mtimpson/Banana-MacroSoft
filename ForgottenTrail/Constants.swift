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

let heroSize: CGSize = CGSize(width: CGFloat(64), height: CGFloat(64))

let heroNames: [HeroType:String] = [
    HeroType.IcePrincess : "Rhoslyn the Ice Princess", HeroType.GoldKnight : "Valter the Golden Knight", HeroType.Orc : "Orcs", HeroType.Princess0 : "Princesses", HeroType.Soldier0 : "Warriors", HeroType.DarkElf0 : "Dark Elves", HeroType.Pirate0 : "Pirates", HeroType.Skeleton : "Skeletons", HeroType.Traveler0 : "Hutch the Traveler", HeroType.Traveler1 : "Aveline the Nomad", HeroType.Banker : "The Banker", HeroType.Ranger : "Leoril the Ranger", HeroType.FallenRanger : "Fallen Rangers"
]
let heroDescriptions: [HeroType:String] = [
    HeroType.IcePrincess : "Versatile, through many years of training in all skills and crafts. ", HeroType.GoldKnight : "The only hero in the realm brave enought to kill all those pesky enemines you encounter.", HeroType.Orc : "Beasts so vile even the realm's great warriors cower in fear.", HeroType.Princess0 : "They've stolen the prince's heart along with his keys to the portals.", HeroType.Soldier0 : "Brave defenders of the realm. Not yet worthy of the title of knight.", HeroType.DarkElf0 : "Shady beings capable of mysterious powers. Known to enter lava and emerge unscathed.", HeroType.Pirate0 : "Skilled marauders of the high seas.", HeroType.Skeleton : "The undead, capable of unspeakable atrocities.", HeroType.Traveler0 : "Your basic traveler. Normally spends as much time outdoors as your average Pokémon Go trainer.", HeroType.Traveler1 : "Enjoys the outdoors. Gravely unprepared to fend off the realm's enemies.", HeroType.Banker : "Everyone knows bankers love currency. 'Put him anywhere on God's green Earth, he'll triple his worth' - Jay-Z", HeroType.Ranger : "Knows the wilderness like the back of his hand. Skilled in combat and trap making.", HeroType.FallenRanger : "Former rangers, twisted by their death in the wild. Extremely formidable."
]
let heroVariants: [HeroType:Int] = [
    HeroType.IcePrincess : 1, HeroType.GoldKnight : 1, HeroType.Orc : 1, HeroType.Princess0 : 3, HeroType.Soldier0 : 3, HeroType.DarkElf0 : 3, HeroType.Pirate0 : 3, HeroType.Skeleton :1, HeroType.Traveler0 : 1, HeroType.Traveler1 : 1, HeroType.Banker : 1, HeroType.FallenRanger : 1, HeroType.Ranger : 1
]

let heroAbilities: [HeroType:String] = [
    HeroType.IcePrincess : "Retains the ability of the hero used before her.", HeroType.GoldKnight : "Can rid the realm of Fallen Rangers, Skeletons and Orcs.", HeroType.Orc : "Can only be destroyed by Valter the Gold Knight, Leoril the Ranger, or Warriors.", HeroType.Princess0 : "Able to close the portal without collecting its key.", HeroType.Soldier0 : "Strong enough to kill the vile Orcs.", HeroType.DarkElf0 : "May cross lava tiles uninjured.", HeroType.Pirate0 : "Capable of moving through water tiles.", HeroType.Skeleton : "Only Valter the Gold Knight and Leoril the Ranger may kill them.", HeroType.Traveler0 : "None. You think Pokémon Go players have powers?", HeroType.Traveler1 : "None. Might be able to construct a campfire.", HeroType.Banker : "Doubles the worth of coins collected.", HeroType.Ranger : "Bests Orcs and Skeletons in combat.", HeroType.FallenRanger : "Vurnerable only to Valter the Gold Knight"
]

let heroActions: [HeroType:Int] = [
    HeroType.Traveler0 : 0, HeroType.Traveler1 : 0, HeroType.IcePrincess : 1, HeroType.Ranger : 5,  HeroType.Soldier0 : 3, HeroType.Pirate0 : 3, HeroType.Princess0 : 1, HeroType.DarkElf0 : 3
]

let heroSteps : [HeroType:Int] = [
    HeroType.Traveler0 : 10, HeroType.Traveler1 : 40, HeroType.IcePrincess : 40, HeroType.Ranger : 55, HeroType.GoldKnight : 45, HeroType.Soldier0 : 35, HeroType.Pirate0 : 30, HeroType.Princess0 : 25, HeroType.DarkElf0 : 30


]

let worldWidth: CGFloat = 1000
let worldHeight: CGFloat = 2000
let tileSize: CGFloat = 100
let moveDist = tileSize
let moveDur = 1.0
let frameTime = 0.1

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}



