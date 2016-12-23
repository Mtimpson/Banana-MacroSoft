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

class OptionsViewController : UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var musicSwitch: UISwitch!
    
    var transition = AnimationController()
    
    @IBAction func musicSwitchAct(_ sender: AnyObject) {
        if musicSwitch.isOn {
            music = true
            Music.sharedHelper.playMenuMusic()
        } else {
            music = false
            Music.sharedHelper.menuPlayer?.stop()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? StartScreenController {
            
            //set transition delegate and modal presentation style
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
        }
    }
    
    //called when dismissing a view controller
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.myTransitionMode = .dismiss
        transition.portalFrame = portalFrame
        return transition
    }

    @IBAction func menuAct(_ sender: AnyObject) {
        dismiss(animated: true, completion: {})
    }
}
