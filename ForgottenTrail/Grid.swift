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
    
    // type = 0 for grass/water,1 for stone/lava
    init(size: Int, type: Int) {
        
        tiles = [Tile]()
        var addition = 0
        if (type == 1) { addition = 2 }
        for row in 0 ..< size {
            for col in 0 ..< size {
                let tile = Tile(tileType: Int(arc4random_uniform(2)) + addition)
                tile.zPosition = -10
                tile.position = CGPoint(x: tileSize * CGFloat(col), y: tileSize * CGFloat(row))
                tile.name = "" + String(row) + "," + String(col)
                tiles.append(tile)
            }
        }
    }
}
