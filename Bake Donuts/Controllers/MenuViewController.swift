//
//  MenuViewController.swift
//  Bake Donuts
//
//  Created by 陳佩琪 on 2023/7/31.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var soundUrl = Bundle.main.url(forResource: "tanoshiimugibatake", withExtension: "mp3")!
    
    var soundStatus = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
        } catch {
            print("播放音效檔案出現錯誤：\(error)")
        }
        audioPlayer.play()
        print(audioPlayer.isPlaying)
        
        
    }
    
    @IBSegueAction func easyMode(_ coder: NSCoder) -> PlayViewController? {
        let controller = PlayViewController(coder: coder)
        controller?.level = Level(doughSpeed: 0.8, glazeSpeed: 0.7, toppingSpeed: 0.6)
        controller?.soundStatus = soundStatus
        return controller
    }
    
    
    @IBSegueAction func mediumMode(_ coder: NSCoder) -> PlayViewController? {
        let controller = PlayViewController(coder: coder)
        controller?.level = Level(doughSpeed: 0.6, glazeSpeed: 0.5, toppingSpeed: 0.4)
        controller?.soundStatus = soundStatus
        return controller
    }

    
    @IBSegueAction func hardMode(_ coder: NSCoder) -> PlayViewController? {
        let controller =  PlayViewController(coder: coder)
        controller?.level = Level(doughSpeed: 0.4, glazeSpeed: 0.3, toppingSpeed: 0.2)
        controller?.soundStatus = soundStatus
        return controller
    }
    
    @IBAction func switchMusic(_ sender: UIButton) {
        if audioPlayer.isPlaying == true {
            audioPlayer.stop()
            sender.setImage(UIImage(named: "noMusic"), for: .normal)
        } else {
            audioPlayer.play()
            sender.setImage(UIImage(named: "music"), for: .normal)
        }
    }
    
    @IBAction func switchSoundEffect(_ sender: UIButton) {
        if soundStatus == true {
            soundStatus = false
            sender.setImage(UIImage(named: "noSound"), for: .normal)
        } else {
            soundStatus = true
            sender.setImage(UIImage(named: "sound"), for: .normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
