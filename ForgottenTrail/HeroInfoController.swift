//
//  HeroInfoController.swift
//  ForgottenTrail
//
//  Created by Matt on 6/23/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit

var scrollPosition : Int!

class HeroInfoController : UIViewController {
    
    
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

    @IBOutlet weak var scroller: UIScrollView!
        
    override func viewDidLoad() {
        
        scroller.contentSize.height = 2000
        
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
        
        
    }
    
    @IBAction func allBtnFunc(sender: AnyObject) {
        scrollPosition = sender.tag
    }
    
    
    
}