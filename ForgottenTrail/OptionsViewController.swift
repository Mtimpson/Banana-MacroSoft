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
var optionsDefault = NSUserDefaults.standardUserDefaults()

class OptionsViewController : UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var musicSwitch: UISwitch!
    
    var transition = AnimationController()
    var musicBool = true 
    
    @IBAction func musicSwitchAct(sender: AnyObject) {
        if musicSwitch.on {
            music = true
            Music.sharedHelper.playMenuMusic()
        } else {
            music = false
            Music.sharedHelper.menuPlayer?.stop()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? StartScreenController {
            
            //set transition delegate and modal presentation style
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
        }
    }
    
    //called when dismissing a view controller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.myTransitionMode = .dismiss
        transition.portalFrame = portalFrame
        return transition
    }

    @IBAction func menuAct(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {})
    }
}
