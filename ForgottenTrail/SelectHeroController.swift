//
//  SelectHero.swift
//  ForgottenTrail
//
//  Created by Matt on 6/27/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

// Add imports for SK Sprites (Animations)
import SpriteKit

var heroChosen : HeroType!


class SelectHeroController : UIViewController {
    
    @IBOutlet weak var bground: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    ///buttons to cycle thru statring heros
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    //view that shows the currently selected heros animation
    @IBOutlet weak var charImage: UIImageView!
    
    var indx = 0
    //array to store the images used to animate each hero
    var imageList = [UIImage]()

    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bground.png")!)
        updateInfo()
        
        
    
    }
    
    //called when 'nextBtn' pressed, moves array to the right
    @IBAction func nextAct(sender: UIButton) {
        if indx == HeroType.startingHeros.count - 1 {
            indx = 0
        } else {
            indx += 1
        }
        //print(indx)
        updateInfo()
        
    }
    
    //called when 'previousBtn' pressed, moves array to the left. code is different becasue pressing the prevBtn calls both this function AND the one above
    @IBAction func previousAct(sender: UIButton) {
        if indx == 0  {
            indx = HeroType.startingHeros.count - 1
        } else {
            indx -= 1
        }
        //print(indx)
        updateInfo()
        
    }
   
    
    //called to update the current heros animation
    func updateInfo() {
        
        nameLabel.text = heroNames[HeroType.startingHeros[indx].rawValue]
        descriptionLabel.text = heroDescriptions[HeroType.startingHeros[indx].rawValue]

        
        //clear array of images
        imageList.removeAll()
        //load each image for the new hero into the array
        for i in 1...8 {
            let imageName = HeroType.startingHeros[indx].rawValue + "Front\(i)"
            imageList.append(UIImage(named: imageName)!)
            
        }
        heroChosen = HeroType.startingHeros[indx]
        // start the animation
        charImage.animationImages = imageList
        charImage.animationDuration = 1
        charImage.startAnimating()
        
    }
    
    
}