//
//  StartScreenController.swift
//  ForgottenTrail
//
//  Created by Matt on 7/12/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

class StartScreenController : UIViewController {
    
    @IBOutlet weak var bground: UIImageView!
    
    override func viewDidLoad() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        bground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
    }
    
    
}