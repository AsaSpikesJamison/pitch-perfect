//
//  PlaySoundViewController.swift
//  Pitch-Perfect
//
//  Created by Asa Spikes Jamison on 3/14/15.
//  Copyright (c) 2015 Asa Spikes Jamison. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
   
    //common function for playing audio from the beginning
    func audioPlayCurrent (){
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func playAudioWithVariableRate(rate: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = rate
        //audioPlayer.currentTime = 0.0
        //audioPlayer.play()

        }

   
    @IBAction func playSlowAudio(sender: UIButton) {
        //play audio slowly
        playAudioWithVariableRate(0.5)
        audioPlayCurrent()
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        //play audio quickly
        playAudioWithVariableRate(2.0)
        audioPlayCurrent()
    }
  
    
    func playAudioWithVariablePitch(pitch: Float){
    
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        //DarthVader filter on audio
        playAudioWithVariablePitch(-1000)
       
        
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //chipmunk filter on audio
        playAudioWithVariablePitch(1000)
        
        
        
    }

    
    @IBAction func audioStopButton(sender: UIButton) {
        //stop all audio playing
        audioPlayer.stop()
        audioEngine.stop()
    }
}