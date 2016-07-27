//
//  InfoController.swift
//  ForgottenTrail
//
//  Created by Matt on 7/26/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class InfoController : UIViewController {
    
    @IBOutlet weak var bground: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var abilityUsesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var leftChar: UIImageView!
    @IBOutlet weak var midChar: UIImageView!
    @IBOutlet weak var rightChar: UIImageView!
    
    @IBOutlet weak var leftCharLeading: NSLayoutConstraint!
    
    @IBOutlet weak var rightCharTrailing: NSLayoutConstraint!
    
    var variant1 : String!
    var variant2 : String!
    var variant3 : String!
    
    //var heroRawValue : String!
    var name : String!
    var descrip : String!
    var numVariants : Int!
    var abil : String!
    var abilUses : Int!
    var stepCount : Int!
    
    var var2str : String!
    var var3str : String!
    
    var heroRawValue : String!
    
    var indx = 0
    //array to store the images used to animate each hero
    var imageList = [UIImage]()
    
    
    override func viewDidLoad() {
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bground.png")!)
        heroRawValue = scrollViewPosition[scrollPosition]
        name = heroNames[heroRawValue]
        descrip = heroDescriptions[heroRawValue]
        numVariants = heroVariants[heroRawValue]
        abil = heroAbilities[heroRawValue]
        abilUses = heroAilityUses[heroRawValue]
        stepCount = heroStepCount[heroRawValue]
        
        
        nameLabel.text = name
        stepLabel.text = "Steps: \(stepCount)"
        abilityUsesLabel.text = "Uses: \(abilUses)"
        descriptionLabel.text = descrip
        abilityLabel.text = "Ability: \(abil)"
        
        
       
        
        if numVariants == 1 {
            variant1 = "\(heroRawValue)Front"
            //midChar.image = UIImage(named: variant1)
            getAnimation(midChar, variant: variant1)
            midChar.contentMode = .ScaleAspectFit
            
        } else if numVariants == 3 {
            var2str = heroRawValue.stringByReplacingOccurrencesOfString("0", withString: "1")
            var3str = heroRawValue.stringByReplacingOccurrencesOfString("0", withString: "2")
            variant1 = "\(heroRawValue)Front"
            variant2 = "\(var2str)Front"
            variant3 = "\(var3str)Front"
            //leftChar.image = UIImage(named: variant1)
            //midChar.image = UIImage(named: variant2)
            //rightChar.image = UIImage(named: variant3)
            
            getAnimation(leftChar, variant: variant1)
            getAnimation(midChar, variant: variant2)
            getAnimation(rightChar, variant: variant3)
            
            leftChar.contentMode = .ScaleAspectFit
            midChar.contentMode = .ScaleAspectFit
            rightChar.contentMode = .ScaleAspectFit
        }
    }
    
    func getAnimation(charImage : UIImageView, variant : String) {
        
        //clear array of images
        imageList.removeAll()
        let folderName = SKTextureAtlas(named: variant)
        let numImages = folderName.textureNames.count
        //load each image for the new hero into the array
        for i in 1 ..< numImages {
            let imageName = variant + String(i)
            imageList.append(UIImage(named: imageName)!)
            
        }
        // start the animation
        charImage.animationImages = imageList
        charImage.animationDuration = 1
        charImage.startAnimating()

    }
    
    
    
    
}
