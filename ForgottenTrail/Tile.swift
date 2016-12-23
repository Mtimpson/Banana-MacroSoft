//
//  Tile.swift
//  ForgottenTrail
//
//  Created by Ben Brott on 7/26/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import SpriteKit

class Tile: SKSpriteNode {
    var type: Int
    
    init(tileType: Int) {
        var image = ""
        switch tileType {
        case 0:
            image = "grass.png"
        case 1:
            image = "water.png"
        case 2:
            image = "stone.png"
        case 3:
            image = "lava.png"
        default:
            image = ""
        }
        type = tileType
        super.init(texture: SKTexture(imageNamed: image), color: UIColor.clear, size: CGSize(width: tileSize, height: tileSize))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
