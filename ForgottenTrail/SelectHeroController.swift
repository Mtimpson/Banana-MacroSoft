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


class SelectHeroController : UIViewController {
    
    @IBOutlet weak var bground: UIImageView!
    
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var charImage: UIImageView!
    
    var indx = 0
    var imageList = [UIImage]()

    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bground.png")!)        
        updateInfo()
        
        
    
    }
    
    @IBAction func nextAct(sender: UIButton) {
        if indx == HeroType.allHeros.count - 1 {
            indx = 0
        } else {
            indx += 1
        }
        print(indx)
        updateInfo()
        
    }
    
    @IBAction func previousAct(sender: UIButton) {
        if indx == 0 {
            indx = HeroType.allHeros.count - 2
        } else if indx - 2 < 0 {
            indx = HeroType.allHeros.count - 1
        } else {
            indx -= 2
        }
        print(indx)
        updateInfo()
        
    }
   
    
    func updateInfo() {
        imageList.removeAll()
        for i in 1...8 {
            let imageName = HeroType.allHeros[indx].rawValue + "Front\(i)"
            imageList.append(UIImage(named: imageName)!)
            
        }
        
        charImage.animationImages = imageList
        charImage.animationDuration = 1
        charImage.startAnimating()
        
    }
    
    
}