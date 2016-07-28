//
//  File.swift
//  ForgottenTrail
//
//  Created by Matt on 7/28/16.
//  Copyright © 2016 newBorn Software Development Company. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Music : NSObject, AVAudioPlayerDelegate {
    static let sharedHelper = Music()
    var audioPlayer: AVAudioPlayer?
    var counter = 0
    var song = ["AchaidhCheide", "Angevin"]
    
    func playBackgroundMusic() {
        song.shuffleInPlace()
        print(song)
        let aSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("\(song[counter])", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL:aSound)
            audioPlayer?.delegate = self
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func audioPlayerDidFinishPlaying(audioPlayer: AVAudioPlayer, successfully flag: Bool) {
        
        print("Called")
        if flag {
            counter += 1
        }
        
        if ((counter) == song.count) {
            counter = 0
        }
        
        playBackgroundMusic()
    }

        
    
}