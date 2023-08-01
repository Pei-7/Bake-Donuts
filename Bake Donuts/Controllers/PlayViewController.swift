//
//  PlayViewController.swift
//  Bake Donuts
//
//  Created by 陳佩琪 on 2023/7/31.
//

import UIKit
import FoodTruckKit
import AVFoundation

class PlayViewController: UIViewController {

    
    @IBOutlet var resultFace: UIImageView!
    @IBOutlet var orderDough: UIImageView!
    @IBOutlet var orderGlaze: UIImageView!
    @IBOutlet var orderTopping: UIImageView!
    @IBOutlet var resultString: UILabel!
    @IBOutlet var resultView: UIView!
    
    @IBOutlet var instructionLabel: UILabel!
    
    @IBOutlet var doughImageView: UIImageView!
    @IBOutlet var glazeImageView: UIImageView!
    @IBOutlet var toppingImageView: UIImageView!
    
    @IBOutlet var doughButton: UIButton!
    @IBOutlet var glazeButton: UIButton!
    @IBOutlet var toppingButton: UIButton!
    @IBOutlet var againButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var tempIimageArray: [UIImage] = []
    var doughImages:[UIImage] = []
    var glazeImages:[UIImage] = []
    var toppingImages:[UIImage] = []
    
    var doughIndex = 0
    var glazeIndex = 0
    var toppingIndex = 0
    var pauseIndex = 0
    
    var orderDoughIndex = 0
    var orderGlazeIndex = 0
    var orderToppingIndex = 0
    var correctness = 0
    
    var level: Level!
    
    var audioPlayer = AVAudioPlayer()
    var soundStatus: Bool!
    
    fileprivate func playSound(resourceName: String) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("播放音效檔案出現錯誤：\(error)")
        }
        if soundStatus == true {
            audioPlayer.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        for i in 0 ... Donut.Dough.all.count-1 {
            if let image = Donut.Dough.all[i].uiImage(thumbnail: false) {
                doughImages.append(image)
            }
        }
        
        for i in 0 ... Donut.Glaze.all.count-1 {
            if let image = Donut.Glaze.all[i].uiImage(thumbnail: false) {
                glazeImages.append(image)
            }
        }
        
        for i in 0 ... Donut.Topping.all.count-1 {
            if let image = Donut.Topping.all[i].uiImage(thumbnail: false) {
                toppingImages.append(image)
            }
        }
        
        updateOrder()
        initialUI()
        
    }
    
    
    func updateOrder() {
        orderDoughIndex = Int.random(in: 1...doughImages.count-1)
        orderGlazeIndex = Int.random(in: 1...glazeImages.count-1)
        orderToppingIndex = Int.random(in: 1...toppingImages.count-1)
        orderDough.image = doughImages[orderDoughIndex]
        orderGlaze.image = glazeImages[orderGlazeIndex]
        orderTopping.image = toppingImages[orderToppingIndex]
        print("0. dough",orderDoughIndex, "dlaze", orderGlazeIndex, "topping", orderToppingIndex )
        
        resultFace.image = UIImage(named: "girl _ normal")
    }
    
    fileprivate func initialUI() {
        buttonsHidden(dough: false, glaze: true, topping: true,next: true, again: true)
        instructionLabel.isHidden = false
        resultView.isHidden = true
        instructionLabel.text = "Tap the donut to select the dough."
        
        doughImageView.image = doughImages[doughIndex]
        Timer.scheduledTimer(withTimeInterval: level.doughSpeed, repeats: true) { [self] timer in
            if pauseIndex > 0 {
                timer.invalidate()
            } else {
                doughIndex = (doughIndex + 1) % doughImages.count
                doughImageView.image = doughImages[doughIndex]
            }
        }

    }

    
    func buttonsHidden(dough: Bool, glaze: Bool, topping: Bool, next: Bool, again:Bool) {
        doughButton.isHidden = dough
        glazeButton.isHidden = glaze
        toppingButton.isHidden = topping
        nextButton.isHidden = next
        againButton.isHidden = again
    }

    @IBAction func selectDough(_ sender: Any) {
        pauseIndex += 1
        buttonsHidden(dough: true, glaze: false, topping: true,next: true, again: true)
        instructionLabel.text = "Tap the donut to select the glaze."
        
        doughImageView.image = doughImages[doughIndex]
        if doughIndex == orderDoughIndex {
            correctness += 1
        }
        print("1.dough",doughIndex,"glaze",glazeIndex,"topping",toppingIndex, "correctness",correctness)
        
        glazeImageView.image = glazeImages[glazeIndex]
        Timer.scheduledTimer(withTimeInterval: level.glazeSpeed, repeats: true) { [self] timer in
            if pauseIndex > 1 {
                timer.invalidate()
            } else {
                glazeIndex = (glazeIndex + 1) % glazeImages.count
                glazeImageView.image = glazeImages[glazeIndex]
            }
        }
    }
    
    
    @IBAction func selectGlaze(_ sender: Any) {
        pauseIndex += 1
        buttonsHidden(dough: true, glaze: true, topping: false,next:true, again: true)
        instructionLabel.text = "Tap the donut to select the topping."
        
        glazeImageView.image = glazeImages[glazeIndex]
        if glazeIndex == orderGlazeIndex {
            correctness += 1
        }
        print("2.dough",doughIndex,"glaze",glazeIndex,"topping",toppingIndex,"correctness",correctness)
        
        toppingImageView.image = toppingImages[toppingIndex]
        Timer.scheduledTimer(withTimeInterval: level.toppingSpeed, repeats: true) { [self] timer in
            if pauseIndex > 2 {
                timer.invalidate()
            } else {
                toppingIndex = (toppingIndex + 1) % toppingImages.count
                toppingImageView.image = toppingImages[toppingIndex]   
            }
        }
    }
    
    @IBAction func selectTopping(_ sender: Any) {
        pauseIndex += 1
        buttonsHidden(dough: true, glaze: true, topping: true, next: false, again: false)
        instructionLabel.isHidden = true
        resultView.isHidden = false
        
        toppingImageView.image = toppingImages[toppingIndex]
        if toppingIndex == orderToppingIndex {
            correctness += 1
        }
        print("3.dough",doughIndex,"glaze",glazeIndex,"topping",toppingIndex,"correctness",correctness)
        
        
        switch correctness {
        case 3:
            resultString.text = Result.allCorrect.string
            resultFace.image = UIImage(named: "girl _ \(Result.allCorrect.imageName)")
            playSound(resourceName: "javapimp__kara-yippee")
        case 2:
            resultString.text = Result.twoCorrect.string
            resultFace.image = UIImage(named: "girl _ \(Result.twoCorrect.imageName)")
            playSound(resourceName: "javapimp__kara-ok")
        case 1:
            resultString.text = Result.oneCorrect.string
            resultFace.image = UIImage(named: "girl _ \(Result.oneCorrect.imageName)")
            playSound(resourceName: "javapimp__kara-o")
        default:
            resultString.text = Result.noneCorrect.string
            resultFace.image = UIImage(named: "girl _ \(Result.noneCorrect.imageName)")
            playSound(resourceName: "javapimp__kara-nope")
        }
    }
    
    func replay() {
        pauseIndex = 0
        correctness = 0
        glazeImageView.image = nil
        toppingImageView.image = nil
        
        initialUI()
    }
    
    @IBAction func again(_ sender: Any) {
        replay()
    }
    
    @IBAction func next(_ sender: Any) {
        doughIndex = 0
        glazeIndex = 0
        toppingIndex = 0
        
        updateOrder()
        replay()
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
