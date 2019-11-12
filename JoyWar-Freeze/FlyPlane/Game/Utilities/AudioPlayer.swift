//
//  AudioPlayer.swift
//  FlyPlane
//
//  Created by Dexter on 04/07/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import AVFoundation

@objc class AudioPlayer: NSObject {
    
    static let shared = AudioPlayer()
    
    private override init(){}
    
    var isMuted: Bool = false
    
    enum BackgroundTracks {
        case frontScene
        case gameScene
    }
    var backgroundMusicPlayer: AVAudioPlayer? {
        didSet{
            backgroundMusicPlayer?.volume = 0.5
        }
    }
    var currentBackgroundTrack: BackgroundTracks = .frontScene
    
    var audioPlayer: AVAudioPlayer?
    var coinsPlayer: AVAudioPlayer?
    
    var frontScene = URL(fileURLWithPath: Bundle.main.path(forResource: "FrontScene", ofType: ".mp3")!)
    var frontSceneLoop = URL(fileURLWithPath: Bundle.main.path(forResource: "FrontSceneLoop", ofType: ".mp3")!)
    var gameScene = URL(fileURLWithPath: Bundle.main.path(forResource: "GameScene", ofType: ".mp3")!)
    var gameSceneLoop = URL(fileURLWithPath: Bundle.main.path(forResource: "GameSceneLoop", ofType: ".mp3")!)
    
     func startFrontSceneBackgroundMusic() {
        guard !isMuted else { return }
        stop()
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: frontScene)
            currentBackgroundTrack = .frontScene
            backgroundMusicPlayer?.delegate = self
            backgroundMusicPlayer?.numberOfLoops = 0
            backgroundMusicPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }

     func startGameSceneBackgroundMusic() {
        guard !isMuted else { return }
        stop()
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: gameScene)
            currentBackgroundTrack = .gameScene
            backgroundMusicPlayer?.delegate = self
            backgroundMusicPlayer?.numberOfLoops = 0
            backgroundMusicPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }
    
     func stop() {
        if audioPlayer != nil {
            if  audioPlayer!.isPlaying {
                audioPlayer!.stop()
                audioPlayer = nil
            }
        }
        if backgroundMusicPlayer != nil {
            if  backgroundMusicPlayer!.isPlaying {
                backgroundMusicPlayer!.stop()
                backgroundMusicPlayer = nil
            }
        }
    }
}

extension AudioPlayer: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        var requiredLoopTrack: URL
        
        switch currentBackgroundTrack {
        case .frontScene:
            requiredLoopTrack = frontSceneLoop
        case .gameScene:
            requiredLoopTrack = gameSceneLoop
        }
        
        guard !isMuted else { return }
        stop()
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: requiredLoopTrack)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.play()
        } catch {
            //  Silently fails if audio can't be open
        }
    }
}
