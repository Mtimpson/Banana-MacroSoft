//
//  HeroInfoController.swift
//  ForgottenTrail
//
//  Created by Matt on 6/23/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

class HeroInfoController : UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    
    override func viewDidLoad() {
        scroller.contentSize.height = 1000
    }
    
    
}