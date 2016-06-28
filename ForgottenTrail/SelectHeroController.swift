//
//  SelectHero.swift
//  ForgottenTrail
//
//  Created by Matt on 6/27/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

class SelectHeroController : UIViewController {
    
    
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var charImage: UIImageView!
    
    var indx = 0

    
    
    
    override func viewDidLoad() {
        
        updateInfo()
        
    
    }
    
    @IBAction func nextAct(sender: UIButton) {
        if indx == HeroType.allHeros.count - 1 {
            indx = 0
        } else {
            indx += 1
        }
        updateInfo()
        
    }
    
    @IBAction func previousAct(sender: AnyObject) {
        if indx == 0 {
            indx = HeroType.allHeros.count - 1
        } else {
            indx -= 1
        }
        
        updateInfo()
        
    }
    
    func updateInfo() {
        var imageName = HeroType.allHeros[indx].rawValue
        
        imageName = imageName.stringByReplacingOccurrencesOfString(" ", withString: "")
        imageName += "Front-1"
        charImage.image = UIImage(named: imageName)

    }
    
    
}