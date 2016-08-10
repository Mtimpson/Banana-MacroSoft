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


class SelectHeroController : UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var bground: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var abilityUseLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    var heroUses : Int!
    var steps : Int!
    var heroAbility : String!
    var descrip : String!
    
    ///buttons to cycle thru statring heros
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    //view that shows the currently selected heros animation
    @IBOutlet weak var charImage: UIImageView!
    
    var indx = 0
    //array to store the images used to animate each hero
    var imageList = [UIImage]()

    
    var transition = AnimationController()
    
    override func viewDidLoad() {
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bground.png")!)
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
        
        heroAbility = heroAbilities[HeroType.startingHeros[indx]]
        heroUses = heroActions[HeroType.startingHeros[indx]]
        steps = heroSteps[HeroType.startingHeros[indx]]
        descrip = heroDescriptions[HeroType.startingHeros[indx]]
        
        nameLabel.text = heroNames[HeroType.startingHeros[indx]]
        descriptionLabel.text = descrip
        abilityLabel.text = "Ability: \(heroAbility)"
        if steps != nil {
            stepsLabel.text = "Steps: \(steps)"
        } else {
            stepsLabel.text = "Steps: ∞"
        }
        if heroUses != nil {
            abilityUseLabel.text = "Uses: \(heroUses)"
        } else {
            abilityUseLabel.text = "Uses: ∞"
        }

        
        //clear array of images
        imageList.removeAll()
        let folderName = SKTextureAtlas(named: HeroType.startingHeros[indx].rawValue + "Front")
        let numImages = folderName.textureNames.count
        //load each image for the new hero into the array
        for i in 1 ..< numImages {
            let imageName = HeroType.startingHeros[indx].rawValue + "Front\(i)"
            let originalImage = UIImage(named: imageName)
            // scaling set to 2.0 makes the image 1/2 the size.
            let scaledImage = UIImage(CGImage: (originalImage?.CGImage)!, scale: (originalImage?.scale)! * 0.5, orientation: (originalImage?.imageOrientation)!)
            imageList.append(scaledImage)

            
        }
        heroChosen = HeroType.startingHeros[indx]
        // start the animation
        charImage.animationImages = imageList
        charImage.animationDuration = 1
        charImage.startAnimating()
        
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