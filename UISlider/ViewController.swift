//
//  ViewController.swift
//  UISlider
//
//  Created by Nguyen Cong Toan on 3/22/17.
//  Copyright © 2017 mr.t. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    
    @IBOutlet weak var lbl_CurrentTime: UILabel!
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var sld_Duration: UISlider!
    var audio = AVAudioPlayer()
    
    @IBOutlet weak var sld_volume: UISlider!
    @IBAction func action_Play(_ sender: Any) {
        if audio.isPlaying
      {
            audio.stop()
            btn_Play.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
      }
        else
      {
        audio.play()
        btn_Play.setImage(UIImage(named: "pause.png"), for: UIControlState.normal)
        }
    }
    @IBAction func sld_Volume(_ sender: UISlider) {
        audio.volume = sender.value
    }
    @IBAction func sld_ActionTime(_ sender: UISlider) {
      audio.currentTime = TimeInterval(sld_Duration.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //tim file nhac
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!) as URL)
        sld_Duration.maximumValue = Float(audio.duration)
        sld_Duration.minimumValue = 0
        sld_Duration.value = 0
        audio.prepareToPlay()
        addThumbImgForSlider()
        setThump()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
    }
    func setThump()
    {
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), for: UIControlState.normal)
    }

    func updateTime()
    {
        
        sld_Duration.value = Float(audio.currentTime)
        self.lbl_CurrentTime.text = String(format: "%2.2f", audio.currentTime/60)
        self.lbl_TimeTotal.text = String(format: "%2.2f", audio.duration/60)
        if audio.currentTime == 0
        {
            btn_Play.setImage(UIImage(named: "play.png"), for: UIControlState.normal)        }
    }
    func addThumbImgForSlider()
    {
        sld_volume.setThumbImage(UIImage(named: "thumb.png"), for: UIControlState.normal)
        sld_volume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: UIControlState.highlighted)
    }
   
}

