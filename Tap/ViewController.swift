//
//  ViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
//import WatchConnectivity

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}



class ViewController: UIViewController {
    
//    @available(iOS 9.3, *)
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//    
//    func sessionDidBecomeInactive(_ session: WCSession) {
//
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//
//    }
    
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
    
    @IBOutlet weak var tmStack: UIStackView!
    @IBOutlet weak var tmLooks: UILabel!
    @IBOutlet weak var tapLooks: UILabel!
    @IBOutlet weak var valueLooks: UILabel!
    @IBOutlet weak var secLooks: UILabel!
    
    @IBOutlet weak var hsStack: UIStackView!
    @IBOutlet weak var hsLooks: UILabel!
    @IBOutlet weak var beatLooks: UILabel!
    @IBOutlet weak var highLooks: UILabel!
    @IBOutlet weak var inLooks: UILabel!
    
    @IBOutlet weak var backLooks: UIButton!
    @IBOutlet weak var startLooks: UIButton!
    
    @IBOutlet weak var countdownToEndStack: UIStackView!
    @IBOutlet weak var highscoreStack: UIStackView!
    
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
            highscoreStack.isHidden = true
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
            highscoreStack.isHidden = false
            highscoreStack.alpha = 0
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
            highscoreStack.isHidden = false
            highscoreStack.alpha = 0
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
            highscoreStack.isHidden = true
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
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
        
    }
    
    var timer = Timer()
    var countdownLabel = UILabel()
    var countdownTime = 3
    
    @objc func updateCountdown() {
        
        countdownTime -= 1
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
        }
        countdownLabel.text = String(countdownTime)
        
        if countdownTime == 0 {
            timer.invalidate()
            UIView.animate(withDuration: 0.5, animations: {
                self.countdownLabel.alpha = 0
                self.score.alpha = 1
                self.scoreDisplay.alpha = 1
                self.countdownToEndStack.alpha = 1
                if Auth.auth().currentUser != nil && self.hsSwitch.isOn == true {
                    self.highscoreStack.alpha = 1
                }
            }, completion: { (success: Bool) in
                self.countdownLabel.removeFromSuperview()
                self.score.isHidden = false
                self.scoreDisplay.isHidden = false
                self.countdownToEndStack.isHidden = false
                if Auth.auth().currentUser != nil && self.hsSwitch.isOn == true {
                    self.highscoreStack.isHidden = false
                }
            })
            
            stackView.removeFromSuperview()
            
            if slider.value == 60 && UserDefaults.standard.value(forKey: "valueTextValue") == nil {
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
            
            if Auth.auth().currentUser == nil {
                ViewController.mode = 1
            } else {
                if hsSwitch.isOn == true {
                    ViewController.mode = 0
                    time = 60
                    countdown.text = "60 secs"
                    countdown.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)

                }
                
            }
            
        }
        
    }
    
    @IBAction func startGame(_ sender: Any) {

        animateOut()
        
        countdownLabel.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        countdownLabel.font = UIFont.systemFont(ofSize: 61, weight: .black)
        countdownLabel.center = self.view.center
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        countdownLabel.text = String(countdownTime)
        
        self.view.addSubview(countdownLabel)
        
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateCountdown), userInfo: nil, repeats: true)
        
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
    
    var stackView = UIStackView()
    
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
        
        pickView.layer.cornerRadius = 10.0
        
        score.isHidden = true
        scoreDisplay.isHidden = true
        countdownToEndStack.isHidden = true
        highscoreStack.isHidden = true
        
        ViewController.score = 0
        scoreLabel.text = "\(ViewController.score.cleanValue)"
        
        tapBTN.isUserInteractionEnabled = false
        
        interval = 1
        
        if Auth.auth().currentUser != nil {
        
            hsSwitch.setOn(false, animated: false)
            hsLooks.textColor = UIColor.lightText
            beatLooks.textColor = UIColor.lightText
            highLooks.textColor = UIColor.lightText
            inLooks.textColor = UIColor.lightText
            
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
                highscoreStack.isHidden = true
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
                highscoreStack.isHidden = true
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
                highscoreStack.isHidden = false
                highscoreStack.alpha = 0
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
            }
            
            let userID = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    
                    let Highscore = value["Highscore"] as? Int
                    NSUbiquitousKeyValueStore.default.set(Highscore, forKey: "Highscore")
                    
                    let timesPlayed = value["timesPlayed"] as! Int?
                    NSUbiquitousKeyValueStore.default.set(timesPlayed as Any, forKey: "timesPlayed")
                    
                    let timesPlayedTM = value["timesPlayedTM"] as! Int?
                    NSUbiquitousKeyValueStore.default.set(timesPlayedTM as Any, forKey: "timesPlayedTM")
                    
                    let timesPlayedHS = value["timesPlayedHS"] as! Int?
                    NSUbiquitousKeyValueStore.default.set(timesPlayedHS as Any, forKey: "timesPlayedHS")
                    
                    let timesPlayedAT = value["timesPlayedAT"] as! Int?
                    NSUbiquitousKeyValueStore.default.set(timesPlayedAT as Any, forKey: "timesPlayedAT")
                    
                    let timesPlayedTRLM = value["timesPlayedTRLM"] as! Int?
                    NSUbiquitousKeyValueStore.default.set(timesPlayedTRLM as Any, forKey: "timesPlayedTRLM")
                    
                    let highscoreDefault = NSUbiquitousKeyValueStore.default
                    if (highscoreDefault.object(forKey: "Highscore") != nil){
                        ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                        self.highscoreDisplay.text = "\(String(describing: Highscore!))"
                        self.highscoreLabel.text = "\(String(describing: Highscore!))"
                    }
                    
                    if self.hsSwitch.isOn == true {
                        
                        if (highscoreDefault.object(forKey: "Highscore") != nil){
                            ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                            self.highscoreLabel.text = "\(String(describing: Highscore!))"
                            self.highscoreDisplay.text = "\(String(describing: Highscore!))"
                        }
                        
                    }
                
                } else {
                    let highscoreDefault = NSUbiquitousKeyValueStore.default
                    if (highscoreDefault.object(forKey: "Highscore") != nil){
                        ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                        self.highscoreLabel.text = "\(ViewController.highscore.cleanValue)"
                        self.highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                    }
                    
                    if self.hsSwitch.isOn == true {
                        
                        if (highscoreDefault.object(forKey: "Highscore") != nil){
                            ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                            self.highscoreLabel.text = "\(ViewController.highscore.cleanValue)"
                            self.highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                        }
                        
                    }
                }
                
            }) { (error) in
                let highscoreDefault = NSUbiquitousKeyValueStore.default
                if (highscoreDefault.object(forKey: "Highscore") != nil){
                    ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                    self.highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                    self.highscoreLabel.text = "\(ViewController.highscore.cleanValue)"
                }
                
                if self.hsSwitch.isOn == true {
                    
                    if (highscoreDefault.object(forKey: "Highscore") != nil){
                        ViewController.highscore = highscoreDefault.object(forKey: "Highscore") as! Double!
                        self.highscoreLabel.text = "\(ViewController.highscore.cleanValue)"
                        self.highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                    }
                    
                }
            }
            
        } else {
            ViewController.mode = 1
            
            timeSwitch.isHidden = true
            hsSwitch.isHidden = true
            highLooks.isHidden = true
            inLooks.isHidden = true
            
            hsLooks.textColor = .lightText
            beatLooks.textColor = .lightText
            
            beatLooks.text = "Login to play"
            
            highscoreStack.isHidden = true
            
            let combinedHeight = tmLooks.frame.height + slider.frame.height + tmStack.frame.height + hsLooks.frame.height + beatLooks.frame.height + 20
            
            stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: pickView.frame.width, height: combinedHeight))
            
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 5.0
            
            stackView.addArrangedSubview(tmLooks)
            stackView.addArrangedSubview(slider)
            stackView.addArrangedSubview(tmStack)
            stackView.addArrangedSubview(hsLooks)
            stackView.addArrangedSubview(beatLooks)
            
            self.view.addSubview(stackView)
            
            stackView.center = pickView.center
            
            
            
        }
        //When Watch is Ready
        
//        processApplicationContext()
//
//        if WCSession.isSupported() {
//            session = WCSession.default
//            session?.delegate = self
//            session?.activate()
//        }
//
//        if let validSession = session {
//            let iPhoneAppContext = ["highscore": ViewController.highscore.cleanValue]
//
//            do {
//                try validSession.updateApplicationContext(iPhoneAppContext)
//            } catch {
//                print("error.")
//            }
//        }

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
    
    @objc func update() {

        time -= 1
        countdown.text = "\(time) secs"
        
        if(time < 11) {
            countdown.textColor = UIColor.red
        }
        if(time == 1) {
            countdown.text = "\(time) sec"
        }
        if time == 0 {
            countdown.text = "\(time) secs"
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
                
            }
        }
    }
//When watch is ready
//    var session: WCSession?
//    let session2 = WCSession.default
//
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        DispatchQueue.main.async() {
//            self.processApplicationContext()
//        }
//    }
//
//    func processApplicationContext() {
//        if let watchContext = session2.receivedApplicationContext as? [String : Double] {
//            if watchContext["highscore"] != nil {
//                highscoreLabel.text = (String(describing: watchContext["highscore"]!.cleanValue))
//                highscoreDisplay.text = (String(describing: watchContext["highscore"]!.cleanValue))
//
//                let storedHighscore = Int(watchContext["highscore"]!.cleanValue)!
//                ViewController.highscore = Double(storedHighscore)
//
//                let highscoreDefault = NSUbiquitousKeyValueStore.default
//                highscoreDefault.set(storedHighscore, forKey: "Highscore")
//                highscoreDefault.synchronize()
//            }
//        }
//    }
    
    @IBAction func tapped(_ sender: Any) {
        
        if #available(iOS 10.0, *) {
            if SettingsTableViewController.isHFeedbackEnabled == true {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.prepare()
                generator.impactOccurred()
            }
        }
        
        ViewController.score += 1
        scoreLabel.text = "\((ViewController.score).cleanValue)"
        
        if ViewController.mode == 0 {
            if ViewController.score >= ViewController.highscore {
                ViewController.highscore = ViewController.score
                highscoreLabel.text = "\((ViewController.highscore).cleanValue)"
                highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                highscoreLabel.textColor = UIColor.green
                scoreLabel.textColor = UIColor.green
                
                let highscoreDefault = NSUbiquitousKeyValueStore.default
                highscoreDefault.set(ViewController.highscore, forKey: "Highscore")
                highscoreDefault.synchronize()

                let user = Auth.auth().currentUser
                
                let highscore = highscoreDefault.object(forKey: "Highscore")
                
                guard let uid = user?.uid else {
                    return
                }
                
                let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                let value = ["Highscore": highscore]
                usersRef.updateChildValues(value as Any as! [AnyHashable : Any])
                
                // When watch is ready
                
//                if let validSession = session {
//                    let iPhoneAppContext = ["highscore": ViewController.highscore.cleanValue]
//
//                    do {
//                        try validSession.updateApplicationContext(iPhoneAppContext)
//                    } catch {
//                        print("error")
//                    }
//                }
            }
        }
        
    }
    
    @IBAction func locationTapped(_ sender: Any, forEvent event: UIEvent) {
        
        guard let touch = event.allTouches?.first else { return }
        let point = touch.location(in: tapBTN)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        label.center = CGPoint(x: point.x, y: point.y - 30)
        label.alpha = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "+1"
        label.textColor = UIColor.green
        
        self.view.addSubview(label)
        
        let shapeLayer = CAShapeLayer()
        
        if SettingsTableViewController.isCircleTrailsEnabled == true {
        
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: point.x, y: point.y - 30), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            shapeLayer.path = circlePath.cgPath
            
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.green.cgColor
            shapeLayer.lineWidth = 5.0
            
            view.layer.addSublayer(shapeLayer)
        
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.animate(withDuration: 1, animations: {
                if SettingsTableViewController.isCircleTrailsEnabled == true {
                    shapeLayer.opacity = 0
                }
                label.alpha = 0
            }) { _ in
                if SettingsTableViewController.isCircleTrailsEnabled == true {
                    shapeLayer.removeFromSuperlayer()
                }
                label.removeFromSuperview()
            }
        }
        
    }
}
