//
//  Grid.swift
//  ForgottenTrail
//
//  Created by Ben Brott on 7/24/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit


class Grid {

    var tiles: [Tile]
    
    init(size: Int) {
        
        tiles = [Tile]()
        for row in 0 ..< size {
            for col in 0 ..< size {
                var tile = Tile(tileType: Int(arc4random_uniform(2)))
                tile.zPosition = -10
                tile.position = CGPointMake(tileSize * CGFloat(col), tileSize * CGFloat(row))
                tile.name = "" + String(row) + "," + String(col)
                tiles.append(tile)
            }
        }
    }
}