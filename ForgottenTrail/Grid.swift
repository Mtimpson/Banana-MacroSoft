//
//  Grid.swift
//  ForgottenTrail
//
//  Created by Ben Brott on 7/24/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation


class Grid {
    
    var tiles: [[Int]]
    init(size: Int) {
        tiles = Array(count: size, repeatedValue:[Int](count: size, repeatedValue: 0))

        for row in 0 ..< size {
            for col in 0 ..< size {
                if arc4random_uniform(5) == 0 {
                    tiles[row][col] = 1
                }
                else {
                    tiles[row][col] =  0
                }
            }
        }
    }
}