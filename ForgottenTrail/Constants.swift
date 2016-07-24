//
//  Constants.swift
//  ForgottenTrail
//
//  Created by Ben Brott on 6/20/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

let heroSize: CGSize = CGSizeMake(CGFloat(64), CGFloat(64))

let heroNames: [String:String] = [
    "ice" : "Ice Princess", "gold" : "The Golden Knight", "orc" : "Orcs", "princess0" : "Princesses", "soldier0" : "Warriors", "darkElf0" : "Dark Elves", "pirate0" : "Pirates", "skeleton" : "Skeletons", "traveler0" : "Male Traveler", "traveler1" : "Female Nomad", "banker0" : "The Banker"
]
let heroDescriptions: [String:String] = [
    "ice" : "Ben says shes too pretty to not have in the game", "gold" : "The only hero in the realm brave enought to kill those pesky Skeletons and Orcs.", "orc" : "Beasts so vile even the realm's great warriors cower in fear.", "princess0" : "They've stolen the prince's heart along with his key to each levels' exit.", "soldier0" : "Brave defenders of the realm. Not yet worthy of the title of knight.", "darkElf0" : "Shady beings capable of powers not yet determined.", "pirate0" : "Skilled marauders of the high seas.", "skeleton" : "The undead, capable of unspeakable atrocities.", "traveler0" : "Your basic traveler. Normally spends as much time outdoors as your average Pokémon Go trainer.", "traveler1" : "Enjoys the outdoors. Gravely unprepared to fend off the realms enemies.", "banker0" : "Everyone knows bankers love currency. This one hordes coins in his vault."
]
let heroVariants: [String:Int] = [
    "ice" : 1, "gold" : 1, "orc" : 1, "soldier0" : 3, "princess0" : 3, "soldier0" : 3, "darkElf0" : 2, "pirate0" : 2, "skeleton" :1, "traveler0" : 1, "traveler1" : 1, "banker0" : 1
]

let worldWidth: CGFloat = 1000
let worldHeight: CGFloat = 2000
let tileSize: CGFloat = 200
let decisionTime = 1.0



