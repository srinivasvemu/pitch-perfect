//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Srinivas Vemu on 5/20/15.
//  Copyright (c) 2015 SV. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func playAudio(audioRate: Float) {
        
        // Stop the audio completely
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        // Play the audio at various speeds depending on the icon pressed
        audioPlayer.rate = audioRate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {

        // Slow Audio - Snail icon
        playAudio(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {

        // Fast Audio - Rabbit icon
        playAudio(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        // High Pitch Audio - Chipmunk icon
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        // Low Pitch Audio - Darthvader icon
        playAudioWithVariablePitch(-1000)
    }

    private func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        // Attach audioPlayerNode to audio engine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        // Attach changePitchEffect to audio engine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        // Connect audioPlayerNode to changePitchEffect
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)

        // Connect changePitchEffect to output
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        // Play the audio file
        audioPlayerNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
        // Stop audio player
        audioPlayer.stop()

        // Stop audio engine
        audioEngine.stop()
    }
}
