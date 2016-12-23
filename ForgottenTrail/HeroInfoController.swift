//
//  HeroInfoController.swift
//  ForgottenTrail
//
//  Created by Matt on 6/23/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

var heroClicked : HeroType!
class HeroInfoController : UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var pic0: UIImageView!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var pic7: UIImageView!
    @IBOutlet weak var pic8: UIImageView!
    @IBOutlet weak var pic9: UIImageView!
    @IBOutlet weak var pic10: UIImageView!
    @IBOutlet weak var pic11: UIImageView!
    @IBOutlet weak var pic12: UIImageView!
       
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    var eachHerosImages = [UIImage]()
    var currentType : HeroType!
    var currentHero : Hero!
    var currentImageView : UIImageView!

    @IBOutlet weak var scroller: UIScrollView!
    
    var transition = AnimationController()
        
    override func viewDidLoad() {
        
        btn0.tag = 0
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3
        btn4.tag = 4
        btn5.tag = 5
        btn6.tag = 6
        btn7.tag = 7
        btn8.tag = 8
        btn9.tag = 9
        btn10.tag = 10
        btn11.tag = 11
        btn12.tag = 12
        
        let allImageViews = [pic0, pic1, pic2, pic3, pic4, pic5, pic6, pic7, pic8, pic9, pic10, pic11, pic12]

        for i in 0..<allImageViews.count {
            currentType = HeroType.allHerosTypes[i]
            currentImageView = allImageViews[i]
            currentHero = Hero(type: currentType, direction: "Front", upcoming: "Front")
            
            eachHerosImages.removeAll()
            let folderName = SKTextureAtlas(named: currentHero.getAtlas())
            let numImages = folderName.textureNames.count
            //load each image for the new hero into the array
            for i in 1 ..< numImages {
                let imageName = currentHero.getAtlas() + String(i)
                // grab the original image
                let originalImage = UIImage(named: imageName)
                //print(originalImage?.scale)
                
                // scaling set to 2.0 makes the image 1/2 the size.
                //let scaledImage = UIImage(CGImage: (originalImage?.CGImage)!, scale: (originalImage?.scale)! * 2.0, orientation: (originalImage?.imageOrientation)!)

                eachHerosImages.append(originalImage!)
                
            }
            // start the animation
            currentImageView.animationImages = eachHerosImages
            currentImageView.animationDuration = 1
            currentImageView.startAnimating()
            currentImageView.contentMode = .scaleAspectFit

        }
        
    }
    
    @IBAction func allBtnFunc(_ sender: AnyObject) {
        heroClicked = HeroType.allHerosTypes[sender.tag]
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
