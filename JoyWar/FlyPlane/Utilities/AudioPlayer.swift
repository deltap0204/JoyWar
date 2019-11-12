//
//  AudioPlayer.swift
//  FlyPlane
//
//  Created by Dexter on 04/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    static var coinsPlayer: AVAudioPlayer?
    static var planeJumpMusicFX = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Bubble", ofType: ".wav")!)
    static var coinCollectionMusicFX = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Pulsing Laser", ofType: ".wav")!)
    static var dollarWalletCoinsMusicFX = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("coin collect", ofType: ".wav")!)
    static var gameOverMusicFX = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Game Over fx", ofType: ".wav")!)
    
    static func playJumpOrButtonMusicFX() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: planeJumpMusicFX)
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }

    static func playCoinCollectionMusicFX() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: coinCollectionMusicFX)
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }
    
    static func playCoinsAddedToWalletMusicFX() {
        do {
            coinsPlayer = try AVAudioPlayer(contentsOfURL: dollarWalletCoinsMusicFX)
            coinsPlayer?.numberOfLoops = 0
            coinsPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }
    
    static func playGameOverMusicFX() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: gameOverMusicFX)
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }
    
    static func stop() {
        if audioPlayer != nil {
            if  audioPlayer!.playing {
                audioPlayer!.stop()
                audioPlayer = nil
            }
        }
    }
}