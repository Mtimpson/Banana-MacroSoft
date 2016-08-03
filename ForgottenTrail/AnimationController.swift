//
//  AnimationController.swift
//  ForgottenTrail
//
//  Created by Matt on 8/2/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

class AnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    
    enum transitionMode: Int {
        case present
        case dismiss
    }
    
    var myTransitionMode : transitionMode!
    
    //view of portal being presented
    var portal : UIImageView!
    var portalFrame : CGRect!
    
    //starting point of transition
    var origin = CGPointZero
    
    //durations
    var presentDuration = 1.0
    var dismissDuration = 1.0
    
    var presentedView : UIView!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        //sets duration based on if it's presenting or dismissing
        if myTransitionMode == .present {
            return presentDuration
        } else {
            return dismissDuration
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        if myTransitionMode == .present {
            // get view of view controller bring presented
            presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)
            let originalCenter = presentedView?.center
            
            //get frame of portal
            portal = UIImageView(frame: portalFrame)
            portal.image = UIImage(named: "stonePortal")
            portal.center = origin
            
            //add portal to container view so it can be animated later
            containerView?.addSubview(portal)
            
            //make presented view very small and transparent
            presentedView?.center = origin
            presentedView?.transform = CGAffineTransformMakeScale(0.001, 0.001)
            presentedView?.backgroundColor = UIColor.clearColor()
            
            //add presented view to container view
            containerView?.addSubview(presentedView!)
            
            
            //animate both views
            UIView.animateWithDuration(presentDuration, animations: {
                self.portal.transform = CGAffineTransformMakeScale(200, 200)
                self.presentedView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.presentedView?.center = originalCenter!
            }) { (_) -> Void in
                //on completion, fade the purple background to black
                UIView.animateWithDuration(0.5, animations: {
                    self.presentedView?.backgroundColor = UIColor.blackColor()
                }) { (_) -> Void in
                    //nothing
                }
                //on completion, complete transition
                transitionContext.completeTransition(true)
            }
        } else {
            let returningView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            self.presentedView.removeFromSuperview()
            
            //get frame of portal
            portal = UIImageView(frame: portalFrame)
            portal.image = UIImage(named: "stonePortal")
            portal.center = origin
            self.portal.transform = CGAffineTransformMakeScale(200, 200)
            //add portal to container view so it can be animated later
            containerView?.addSubview(portal)
            containerView?.addSubview(presentedView)
            
            UIView.animateWithDuration(0.5, animations: {
                self.presentedView!.backgroundColor = UIColor.clearColor()
            }) { (_) -> Void in
                UIView.animateWithDuration(self.dismissDuration, animations: {
                    self.portal.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    returningView?.transform = CGAffineTransformMakeScale(0.001, 0.001)
                    returningView?.center = self.origin
                    returningView?.alpha = 0
                }) { (_) -> Void in
                    returningView?.removeFromSuperview()
                    self.portal.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    
                }
            }


        }
    }
}