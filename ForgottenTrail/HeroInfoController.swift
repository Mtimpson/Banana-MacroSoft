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

var heroClicked : String!

class HeroInfoController : UIViewController {
    
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
    
    var eachHerosImages = [UIImage]()
    var currentType : HeroType!
    var currentHero : Hero!
    var currentImageView : UIImageView!

    @IBOutlet weak var scroller: UIScrollView!
        
    override func viewDidLoad() {
        
        //scroller.contentSize = preferredContentSize
        
        let allImageViews = [pic0, pic1, pic2, pic3, pic4, pic5, pic6, pic7, pic8, pic9, pic10, pic11, pic12]

        for i in 0..<allImageViews.count {
            currentType = HeroType.allHerosTypes[i]
            currentImageView = allImageViews[i]
            currentHero = Hero(type: currentType, direction: "Front")
            
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
            currentImageView.contentMode = .ScaleAspectFit

        }
        
    }
    
    @IBAction func allBtnFunc(sender: AnyObject) {
        let allBtns = [btn0, btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn10]
        for i in 0..<allBtns.count {
            if allBtns[i] == sender as! NSObject {
                heroClicked = HeroType.allHerosTypes[i].rawValue
            }
        }
    }
    
    
    
}