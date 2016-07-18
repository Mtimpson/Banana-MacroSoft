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



var heroWalking : SKSpriteNode!

var heroWalkingFrames : [SKTexture]!



class SelectHeroController : UIViewController {
    
    @IBOutlet weak var bground: UIImageView!
    
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var charImage: UIImageView!
    
    var indx = 0
    var hero = SKSpriteNode()

    
    
    
    override func viewDidLoad() {
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        bground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        updateInfo()
        walkHeroForward()
        
    
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
    
    func walkHeroForward() {
        let heroWalking : SKTextureAtlas = SKTextureAtlas(named: "Sprites")
        
        var walkFrames = [SKTexture]();
        let numImages : Int = heroWalking.textureNames.count
        
        for var i = 1; i <= numImages; i += 1 {
            let heroTextureName = "purpleGuy\(i)"
            walkFrames.append(heroWalking.textureNamed(heroTextureName))
            
        }
        
        heroWalkingFrames = walkFrames
        
        // Create Hero Sprite, Setup Position in middle of the screen
        //let temp : SKTexture = heroWalkingFrames[0]
        //hero = SKSpriteNode(texture: temp)
        //hero.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidX(self.frame))
        
        walkHero()
        
        
    }
    
    //Function to Animate the hero walking
    func walkHero() {
        // Run Action method to make the hero animate in one place on the screen.
        hero.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(heroWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)))
}
    
    func updateInfo() {
        var imageName = HeroType.allHeros[indx].rawValue
        
        imageName = imageName.stringByReplacingOccurrencesOfString(" ", withString: "")
        imageName += "Front-1"
        charImage.image = UIImage(named: imageName)

    }
    
    
}