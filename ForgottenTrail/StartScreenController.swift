//
//  StartScreenController.swift
//  ForgottenTrail
//
//  Created by Matt on 7/12/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

var portalFrame : CGRect!

class StartScreenController : UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var portal: UIImageView!
    @IBOutlet weak var bground: UIImageView!
    @IBOutlet weak var traveler: UIImageView!
    var imageList = [UIImage]()
    
    //for transitions
    let transition = AnimationController()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController   
            transition.myTransitionMode = .present
        
            //set transition delegate and modal presentation style
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
        
    }
    
    override func viewDidLoad() {
        portalFrame = portal.frame
        
        
        if music {
            Music.sharedHelper.shuffleSongs()
            if Music.sharedHelper.menuPlayer == nil {
                Music.sharedHelper.playMenuMusic()
            } else if !(Music.sharedHelper.menuPlayer?.playing)! {
                Music.sharedHelper.playMenuMusic()
            }
        }
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bground.png")!)
        imageList.removeAll()
        let folderName = SKTextureAtlas(named: "traveler0Front")
        let numImages = folderName.textureNames.count
        //load each image for the new hero into the array
        for i in 1 ..< numImages {
            let imageName = "traveler0Front" + String(i)
            // grab the original image
            let originalImage = UIImage(named: imageName)
            // scaling set to 2.0 makes the image 1/2 the size.
            let scaledImage = UIImage(CGImage: (originalImage?.CGImage)!, scale: (originalImage?.scale)! * 0.5, orientation: (originalImage?.imageOrientation)!)
            imageList.append(scaledImage)
                    
        }
        
        
        // start the animation
        traveler.animationImages = imageList
        traveler.animationDuration = 1
        traveler.startAnimating()
        traveler.contentMode = .ScaleAspectFit

        
    }
    
    //called when presenting a view controller
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("present")
        transition.myTransitionMode = .present
        transition.origin = portal.center
        transition.portalFrame = portal.frame
        return transition
        
    }
    
    //called when dismissing a view controller 
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("diss")
        
        transition.myTransitionMode = .dismiss
        transition.origin = portal.center
        transition.portalFrame = portal.frame
        return transition
    }
    
}