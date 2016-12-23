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
    var origin = CGPoint.zero
    
    //durations
    var presentDuration = 0.7
    var dismissDuration = 0.7
    
    var presentedView : UIView!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        //sets duration based on if it's presenting or dismissing
        if myTransitionMode == .present {
            return presentDuration
        } else {
            return dismissDuration
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if myTransitionMode == .present {
            // get view of view controller bring presented
            presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            let originalCenter = presentedView?.center
            
            //get frame of portal
            portal = UIImageView(frame: portalFrame)
            portal.image = UIImage(named: "stonePortal")
            portal.center = origin
            
            //add portal to container view so it can be animated later
            containerView.addSubview(portal)
            
            //make presented view very small and transparent
            presentedView?.center = origin
            presentedView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView?.backgroundColor = UIColor.clear
            
            //add presented view to container view
            containerView.addSubview(presentedView!)
            
            
            //animate both views
            UIView.animate(withDuration: presentDuration, animations: {
                self.portal.transform = CGAffineTransform(scaleX: 200, y: 200)
                self.presentedView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.presentedView?.center = originalCenter!
            }, completion: { (_) -> Void in
                //on completion, fade the purple background to black
                //UIView.animateWithDuration(0.5, animations: {
                  //  self.presentedView?.backgroundColor = UIColor.blackColor()
                //}) { (_) -> Void in
                    //nothing
                //}
                //on completion, complete transition
                transitionContext.completeTransition(true)
            }) 
        } else {
            let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            
            self.presentedView.removeFromSuperview()
            
            //get frame of portal
            portal = UIImageView(frame: portalFrame)
            portal.image = UIImage(named: "stonePortal")
            portal.center = origin
            self.portal.transform = CGAffineTransform(scaleX: 200, y: 200)
            //add portal to container view so it can be animated later
            containerView.addSubview(portal)
            containerView.addSubview(presentedView)
            
            //UIView.animateWithDuration(0.5, animations: {
                //self.presentedView!.backgroundColor = UIColor.clearColor()
            //}) { (_) -> Void in
                UIView.animate(withDuration: self.dismissDuration, animations: {
                    self.portal.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    returningView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView?.center = self.origin
                    returningView?.alpha = 0
                }, completion: { (_) -> Void in
                    returningView?.removeFromSuperview()
                    self.portal.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    
                }) 
            //}


        }
    }
}
