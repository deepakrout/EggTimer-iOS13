//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let SOFT_TIME = 5
    let MEDIUM_TIME = 7
    let HARD_TIME = 12
    
    @IBOutlet weak var selectedSetting: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var doneMessage: UILabel!
    var player: AVAudioPlayer!
    
    let eggTime: [String: Int] = ["Soft": 1, "Medium": 2, "Hard": 3]
    var selectedTime: Double = 0.0
    var timeRemaining: Double = 0.0
    var progressMade: Float = 0.0
    var timer = Timer()
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        doneMessage.isHidden = true
        selectedSetting.text = sender.currentTitle!
       
        selectedTime =  Double(eggTime[sender.currentTitle!]!) * 60
        timeRemaining = selectedTime
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateCounter() {
        progressMade = Float(1.0 - (timeRemaining / selectedTime))
        if timeRemaining > 0 {
            progressBar.progress = progressMade
  
            timeRemaining -= 1
        }
        else {
            progressBar.progress = progressMade
            doneMessage.isHidden = false
            playSound(soundType: "alarm_sound")
            timer.invalidate()
        }
    }
    
    func playSound(soundType: String) {
        let url = Bundle.main.url(forResource: soundType, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}
