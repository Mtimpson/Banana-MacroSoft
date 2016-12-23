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
    var gamePlayer: AVAudioPlayer?
    var menuPlayer: AVAudioPlayer?
    var counter = 0
    var gameSongs = ["AchaidhCheide", "Angevin", "Errigal", "Celtic Impulse", "Folk Round"]
    var menuSongs = ["Hidden Past", "Skye Cuillin"]
    var menuCounter = 0
    
    func shuffleSongs(){
        gameSongs.shuffleInPlace()
        menuSongs.shuffleInPlace()
    }
    
    func playMenuMusic() {
        print(menuSongs[menuCounter])
        let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: "\(menuSongs[menuCounter])", ofType: "mp3")!)
        do {
            menuPlayer = try AVAudioPlayer(contentsOf:aSound)
            menuPlayer?.delegate = self
            menuPlayer!.prepareToPlay()
            menuPlayer!.play()
        } catch {
            print("Cannot play the file")
        }

    }
    
    func playBackgroundMusic() {
        print(gameSongs)
        let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: "\(gameSongs[counter])", ofType: "mp3")!)
        do {
            gamePlayer = try AVAudioPlayer(contentsOf:aSound)
            gamePlayer?.delegate = self
            gamePlayer!.prepareToPlay()
            gamePlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ audioPlayer: AVAudioPlayer, successfully flag: Bool) {
        if audioPlayer == menuPlayer {
            print("menu player recognized")
            if flag {
                menuCounter += 1
            }
            
            if ((menuCounter) == menuSongs.count) {
                print("menu count reset")
                menuCounter = 0
            }
            playMenuMusic()
        }
        
        if audioPlayer == gamePlayer {
            if flag {
                counter += 1
            }
            
            if ((counter) == gameSongs.count) {
                counter = 0
            }
            playBackgroundMusic()
        }
        
        
    }
    

        
    
}
