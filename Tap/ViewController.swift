//
//  ViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var timeRemain: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoreDisplay: UILabel!

    @IBOutlet weak var tapBTN: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var hs: UILabel!
    
    @IBOutlet weak var countdown: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var timeSwitch: UISwitch!
    @IBOutlet weak var hsSwitch: UISwitch!
    @IBOutlet weak var highscoreDisplay: UILabel!
    
    @IBOutlet weak var tmLooks: UILabel!
    @IBOutlet weak var tapLooks: UILabel!
    @IBOutlet weak var valueLooks: UILabel!
    @IBOutlet weak var secLooks: UILabel!
    
    @IBOutlet weak var hsLooks: UILabel!
    @IBOutlet weak var beatLooks: UILabel!
    @IBOutlet weak var highLooks: UILabel!
    @IBOutlet weak var inLooks: UILabel!
    
    @IBOutlet weak var backLooks: UIButton!
    @IBOutlet weak var startLooks: UIButton!
    
    @IBOutlet weak var countdownToEndStack: UIStackView!
    
    @IBOutlet var pickView: UIView!
    
    static var mode = 1
    
    @IBAction func timeUpdate(_ sender: Any) {
        timeTapped()
    }
    func timeTapped () {
        if timeSwitch.isOn {
            hsSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(timeSwitch.isOn, forKey: "timeSwitchState")
            UserDefaults.standard.set(hsSwitch.isOn, forKey: "hsSwitchState")
            ViewController.mode = 1
            hs.isHidden = true
            highscoreLabel.isHidden = true
            hsLooks.textColor = UIColor.lightText
            beatLooks.textColor = UIColor.lightText
            highLooks.textColor = UIColor.lightText
            inLooks.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = true
            tmLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            tapLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            valueLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        } else {
            hsSwitch.setOn(true, animated: true)
            UserDefaults.standard.set(timeSwitch.isOn, forKey: "timeSwitchState")
            UserDefaults.standard.set(hsSwitch.isOn, forKey: "hsSwitchState")
            ViewController.mode = 0
            hs.isHidden = false
            hs.alpha = 0.0
            highscoreLabel.isHidden = false
            highscoreLabel.alpha = 0.0
            tmLooks.textColor = UIColor.lightText
            hsLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            beatLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            highLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            inLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            slider.isUserInteractionEnabled = false
        }
    }
    @IBAction func hsUpdate(_ sender: Any) {
        hsTapped()
    }
    func hsTapped () {
        if hsSwitch.isOn {
            timeSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(timeSwitch.isOn, forKey: "timeSwitchState")
            UserDefaults.standard.set(hsSwitch.isOn, forKey: "hsSwitchState")
            ViewController.mode = 0
            hs.isHidden = false
            hs.alpha = 0.0
            highscoreLabel.isHidden = false
            highscoreLabel.alpha = 0.0
            hsLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            beatLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            highLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            inLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            tmLooks.textColor = UIColor.lightText
            tapLooks.textColor = UIColor.lightText
            valueLooks.textColor = UIColor.lightText
            secLooks.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = false
        } else {
            timeSwitch.setOn(true, animated: true)
            UserDefaults.standard.set(timeSwitch.isOn, forKey: "timeSwitchState")
            UserDefaults.standard.set(hsSwitch.isOn, forKey: "hsSwitchState")
            ViewController.mode = 1
            hs.isHidden = true
            highscoreLabel.isHidden = true
            hsLooks.textColor = UIColor.lightText
            beatLooks.textColor = UIColor.lightText
            highLooks.textColor = UIColor.lightText
            inLooks.textColor = UIColor.lightText
            tmLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            tapLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            valueLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            slider.isUserInteractionEnabled = true
        }
    }
    
    let step: Float = 10
    var time = 60
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let currentValue = round(sender.value / step) * step
        sender.value = currentValue
        value.text = "\(currentValue.cleanValue)"
        countdown.text = "\(currentValue.cleanValue) secs"
        
        UserDefaults.standard.set(slider.value, forKey: "sliderValue")
        UserDefaults.standard.set(value.text!, forKey: "valueTextValue")
        
        time = Int(sender.value)
        GameOverViewController.timePlayed = Double(Int(sender.value))
        countdown.text = "\(time) secs"
        
        if (slider.value <= 10) {
            countdown.textColor = UIColor.red
        } else if (slider.value >= 11) {
            countdown.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
    }

    
    @IBAction func backToHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
    }
    
    @IBAction func startGame(_ sender: Any) {

        animateOut()
        self.score.isHidden = false
        self.scoreDisplay.isHidden = false
        self.countdownToEndStack.isHidden = false
        if self.hsSwitch.isOn == true {
            self.hs.isHidden = false
            self.highscoreLabel.isHidden = false
        }
        
        if slider.value == 60 && UserDefaults.standard.value(forKey: "valueTextValue") == nil {
            print("Passed")
            slider.value = 60
            time = 60
            countdown.text = "60 secs"
        }
        countdown.text = "\(slider.value.cleanValue) secs"
        time = Int(slider.value)
        if (slider.value <= 10) {
            countdown.textColor = UIColor.red
        } else if (slider.value >= 11) {
            countdown.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
        
        _ = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        tapBTN.isUserInteractionEnabled = true
        timeRemain.text = "Time Remaining"
        
        if hsSwitch.isOn == true {
            ViewController.mode = 0
            time = 60
            countdown.text = "60 secs"
            countdown.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)

            
            hs.isHidden = false
            hs.alpha = 1.0
            highscoreLabel.isHidden = false
            highscoreLabel.alpha = 1.0
            
            let highscoreDefault = UserDefaults.standard
            if (highscoreDefault.value(forKey: "Highscore") != nil){
                ViewController.highscore = highscoreDefault.value(forKey: "Highscore") as! Double!
                highscoreLabel.text = "\(ViewController.highscore)"
            }
        }
        
    }
    
    var visualEffectView: UIVisualEffectView!
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.pickView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.pickView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.pickView.removeFromSuperview()
        }
    }
    
    static var score: Double = 0
    static var highscore: Double = 0
    
    @IBOutlet var playView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.pickView)
        pickView.center = self.view.center
 
        UIView.animate(withDuration: 2.0, animations: {
            self.pickView.alpha = 0
        }) { _ in
            self.pickView.alpha = 1
        } 
        
        if slider.value != 123 && UserDefaults.standard.value(forKey: "valueTextValue") == nil {
            slider.value = 60
            time = 60
        }
        
        slider.setValue(UserDefaults.standard.float(forKey: "sliderValue"), animated: false)
        if UserDefaults.standard.value(forKey: "sliderValue") == nil {
            slider.value = 60
            time = 60
            countdown.text = "60 secs"
        }
        
        UserDefaults.standard.set(slider.value, forKey: "valueTextValue")
        value.text = "\(UserDefaults.standard.integer(forKey: "valueTextValue"))"
        if UserDefaults.standard.value(forKey: "valueTextValue") == nil {
            print("valueTextValue is nil")
            slider.value = 60
            value.text! = "60"
            time = 60
            countdown.text = "60 secs"
        }
        
        GameOverViewController.timePlayed = Double(Int(slider.value))
        time = Int(slider.value)
        countdown.text = "\(UserDefaults.standard.integer(forKey: "valueTextValue")) secs"
        
        if (slider.value <= 10) {
            countdown.textColor = UIColor.red
        } else if (slider.value >= 11) {
            countdown.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
        
        pickView.layer.shadowColor = UIColor.black.cgColor
        pickView.layer.shadowOpacity = 1
        pickView.layer.shadowOffset = CGSize.zero
        pickView.layer.shadowRadius = 10
        pickView.layer.shadowPath = UIBezierPath(rect: pickView.bounds).cgPath
        
        pickView.layer.cornerRadius = 5.0
        
        score.isHidden = true
        scoreDisplay.isHidden = true
        countdownToEndStack.isHidden = true
        hs.isHidden = true
        highscoreLabel.isHidden = true
        
        hsSwitch.setOn(false, animated: false)
        hsLooks.textColor = UIColor.lightText
        beatLooks.textColor = UIColor.lightText
        highLooks.textColor = UIColor.lightText
        inLooks.textColor = UIColor.lightText
        
        let highscoreDefault = NSUbiquitousKeyValueStore.default()
        if (highscoreDefault.object(forKey: "Highscore") != nil){
            ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
            highscoreDisplay.text = "\((ViewController.highscore).cleanValue)"
        }
        
        hsSwitch.isOn = UserDefaults.standard.bool(forKey: "hsSwitchState")
        timeSwitch.isOn = UserDefaults.standard.bool(forKey: "timeSwitchState")
        
        if UserDefaults.standard.value(forKey: "hsSwitchState") == nil {
            (DispatchQueue.main).async{
                self.timeSwitch.setOn(true, animated: false)
                self.hsSwitch.setOn(false, animated: false)
            }
            UserDefaults.standard.set(timeSwitch.isOn, forKey: "timeSwitchState")
            UserDefaults.standard.set(hsSwitch.isOn, forKey: "hsSwitchState")
            ViewController.mode = 1
            hs.isHidden = true
            highscoreLabel.isHidden = true
            hsLooks.textColor = UIColor.lightText
            beatLooks.textColor = UIColor.lightText
            highLooks.textColor = UIColor.lightText
            inLooks.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = true
            tmLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            tapLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            valueLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secLooks.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
        
        if timeSwitch.isOn == true {
            time = UserDefaults.standard.integer(forKey: "valueTextValue")
            ViewController.mode = 1
            hs.isHidden = true
            highscoreLabel.isHidden = true
            hsLooks.textColor = UIColor.lightText
            beatLooks.textColor = UIColor.lightText
            highLooks.textColor = UIColor.lightText
            inLooks.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = true
            tmLooks.textColor = UIColor.white
            tapLooks.textColor = UIColor.white
            valueLooks.textColor = UIColor.white
            secLooks.textColor = UIColor.white

        } else if hsSwitch.isOn == true {
            ViewController.mode = 0
            hs.isHidden = false
            hs.alpha = 0.0
            highscoreLabel.isHidden = false
            highscoreLabel.alpha = 0.0
            hsLooks.textColor = UIColor.white
            beatLooks.textColor = UIColor.white
            highLooks.textColor = UIColor.white
            inLooks.textColor = UIColor.white
            tmLooks.textColor = UIColor.lightText
            tapLooks.textColor = UIColor.lightText
            valueLooks.textColor = UIColor.lightText
            secLooks.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = false
            time = 60
            hs.text = "Highscore"
            
            let highscoreDefault = NSUbiquitousKeyValueStore.default()
            if (highscoreDefault.object(forKey: "Highscore") != nil){
                ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                highscoreLabel.text = "\((ViewController.highscore).cleanValue)"
            }
        }
        
        ViewController.score = 0
        scoreLabel.text = "\(ViewController.score)"
        
        tapBTN.isUserInteractionEnabled = false
        
        interval = 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        pickView.layer.shadowColor = UIColor.black.cgColor
        pickView.layer.shadowOpacity = 1
        pickView.layer.shadowOffset = CGSize.zero
        pickView.layer.shadowRadius = 10
        pickView.layer.shadowPath = UIBezierPath(rect: pickView.bounds).cgPath
    }
    
    var interval = 1
    
    func update() {

        time -= 1
        countdown.text = "\(time) secs"
        
        if(time < 11) {
            countdown.textColor = UIColor.red
        }
        if(time <= 1) {
            countdown.text = "\(time) sec"
        }
        if time == 0 {
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
        }
    }
    
    @IBAction func tapped(_ sender: Any) {
        
        ViewController.score += 1
        scoreLabel.text = "\((ViewController.score).cleanValue)"
        
        if ViewController.mode == 0 {
            if ViewController.score >= ViewController.highscore {
                ViewController.highscore = ViewController.score
                highscoreLabel.text = "\((ViewController.highscore).cleanValue)"
                highscoreLabel.textColor = UIColor.green
                scoreLabel.textColor = UIColor.green
                
                let highscoreDefault = NSUbiquitousKeyValueStore.default()
                highscoreDefault.set(ViewController.highscore, forKey: "Highscore")
                highscoreDefault.synchronize()
                
            }
        }
        
    }
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    @IBAction func locationTapped(_ sender: Any, forEvent event: UIEvent) {
        
        guard let touch = event.allTouches?.first else { return }
        let point = touch.location(in: tapBTN)
        label.center = CGPoint(x: point.x, y: point.y - 30)
        label.alpha = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "+1"
        label.textColor = UIColor.green
        self.view.addSubview(label)
        
        label.tag = Int(ViewController.score + 1)
        print(label.tag)
        
        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) {
            UIView.animate(withDuration: 0.5, animations: {
                self.label.viewWithTag(Int(ViewController.score - 1))?.alpha = 0
                self.label.viewWithTag(Int(ViewController.score))?.alpha = 0
            }) { (success: Bool) in
                self.label.viewWithTag(Int(ViewController.score - 1))?.removeFromSuperview()
                self.label.viewWithTag(Int(ViewController.score))?.removeFromSuperview()
            }

        }
        
    }

}
