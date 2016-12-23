//
//  GameViewController.swift
//  ForgottenTrail
//
//  Created by Michael Timpson on 6/20/16.
//  Copyright (c) 2016 newBorn Software Development Company. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate {
    
    func launchViewController(_ scene: SKScene) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "start")
        
        present(vc, animated: true, completion: nil)
        // note that you don't need to go through a bunch of optionals to call presentViewController
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as! SKView
        if skView.scene == nil {
            let scene = GameScene(size: skView.bounds.size)

            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
        
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
        
            skView.isMultipleTouchEnabled = false
        
            scene.gameOverDelegate = self

            skView.presentScene(scene)
        }
        
    }

    override var shouldAutorotate : Bool {
        return false
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
