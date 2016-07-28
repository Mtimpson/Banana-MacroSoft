//
//  OptionsViewController.swift
//  ForgottenTrail
//
//  Created by Matt on 7/28/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import SpriteKit

var music = true

class OptionsViewController : UIViewController {
    @IBOutlet weak var musicSwitch: UISwitch!
    
    @IBAction func musicSwitchAct(sender: AnyObject) {
        if musicSwitch.on {
            music = true
        } else {
            music = false
        }
    }
}
