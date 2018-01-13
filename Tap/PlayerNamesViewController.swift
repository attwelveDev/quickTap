//
//  PlayerNamesViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 24/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PlayerNamesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var startBTN: UIButton!
    @IBAction func startGame(_ sender: Any) {
        
        if playerOneTF.text?.isEmpty == false {
            MultiplayerViewController.brownPNV = playerOneTF.text!
            let playerOneDefault = NSUbiquitousKeyValueStore.default
            playerOneDefault.set(MultiplayerViewController.brownPNV, forKey: "usernameDefault")
        } else {
            MultiplayerViewController.brownPNV = "Username"
            let playerOneDefault = NSUbiquitousKeyValueStore.default
            playerOneDefault.set(MultiplayerViewController.brownPNV, forKey: "usernameDefault")
        }
        
        if playerTwoTF.text?.isEmpty == false {
            MultiplayerViewController.bluePNV = playerTwoTF.text!
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
        } else {
            MultiplayerViewController.bluePNV = "Blue"
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
        }
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input different names",for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        } else {
            
            if UserDefaults.standard.value(forKey: "acModeSwitchState") == nil {
                MultiplayerViewController.brownPNV = playerOneTF.text!
                MultiplayerViewController.bluePNV = playerTwoTF.text!
                MultiplayerViewController.differentMode = 1
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            } else {
            
                if acModeSwitch.isOn == true {
                    MultiplayerViewController.brownPNV = playerOneTF.text!
                    MultiplayerViewController.bluePNV = playerTwoTF.text!
                    MultiplayerViewController.differentMode = 1
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                } else {
                    MultiplayerViewController.brownPNV = playerOneTF.text!
                    MultiplayerViewController.bluePNV = playerTwoTF.text!
                    MultiplayerViewController.differentMode = 2
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var bottomBTN: UIButton!
    
    let step: Float = 10
    
    @IBAction func slider(_ sender: UISlider) {
        let currentValue = round(sender.value / step) * step
        sender.value = currentValue
        value.text = "\(currentValue.cleanValue)"
        
        UserDefaults.standard.set(slider.value, forKey: "multiSliderValue")
        UserDefaults.standard.set(value.text!, forKey: "multiValueTextValue")
        
        MultiplayerViewController.time = Int(sender.value)
        GameOverViewController.timePlayed = Double(Int(sender.value))
        
    }
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var value: UILabel!

    func acTapped() {
        if acModeSwitch.isOn {
            trlModeSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(acModeSwitch.isOn, forKey: "acModeSwitchState")
            UserDefaults.standard.set(trlModeSwitch.isOn, forKey: "trlModeSwitchState")
            slider.isUserInteractionEnabled = true
            trlModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            value.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        } else {
            trlModeSwitch.setOn(true, animated: true)
            UserDefaults.standard.set(acModeSwitch.isOn, forKey: "acModeSwitchState")
            UserDefaults.standard.set(trlModeSwitch.isOn, forKey: "trlModeSwitchState")
            trlModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor.lightText
            value.textColor = UIColor.lightText
            secText.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = false
        }
    }
    func trlTapped () {
        if trlModeSwitch.isOn {
            acModeSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(acModeSwitch.isOn, forKey: "acModeSwitchState")
            UserDefaults.standard.set(trlModeSwitch.isOn, forKey: "trlModeSwitchState")
            trlModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor.lightText
            value.textColor = UIColor.lightText
            secText.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = false
        } else {
            acModeSwitch.setOn(true, animated: true)
            UserDefaults.standard.set(acModeSwitch.isOn, forKey: "acModeSwitchState")
            UserDefaults.standard.set(trlModeSwitch.isOn, forKey: "trlModeSwitchState")
            slider.isUserInteractionEnabled = true
            trlModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            value.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
    }

    
    @IBOutlet weak var acModeText: UILabel!
    @IBOutlet weak var trlModeText: UILabel!
    @IBOutlet weak var tapText: UILabel!
    @IBOutlet weak var secText: UILabel!
    
    @IBOutlet weak var acModeSwitch: UISwitch!
    @IBAction func acModeUpdate(_ sender: Any) {
        acTapped()
    }
    @IBOutlet weak var trlModeSwitch: UISwitch!
    @IBAction func trlModeUpdate(_ sender: Any) {
        trlTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acModeSwitch.isOn = UserDefaults.standard.bool(forKey: "acModeSwitchState")
        trlModeSwitch.isOn = UserDefaults.standard.bool(forKey: "trlModeSwitchState")
        
        if UserDefaults.standard.value(forKey: "acModeSwitchState") == nil {
            (DispatchQueue.main).async{
                self.acModeSwitch.setOn(true, animated: false)
                self.trlModeSwitch.setOn(false, animated: false)
            }
            acModeSwitch.isOn = UserDefaults.standard.bool(forKey: "acModeSwitchState")
            trlModeSwitch.isOn = UserDefaults.standard.bool(forKey: "trlModeSwitchState")
            slider.isUserInteractionEnabled = true
            trlModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            value.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
        
        if acModeSwitch.isOn {
            trlModeSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(acModeSwitch.isOn, forKey: "acModeSwitchState")
            UserDefaults.standard.set(trlModeSwitch.isOn, forKey: "trlModeSwitchState")
            slider.isUserInteractionEnabled = true
            trlModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            value.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            secText.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        } else if trlModeSwitch.isOn {
            acModeSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(acModeSwitch.isOn, forKey: "acModeSwitchState")
            UserDefaults.standard.set(trlModeSwitch.isOn, forKey: "trlModeSwitchState")
            trlModeText.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            acModeText.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            tapText.textColor = UIColor.lightText
            value.textColor = UIColor.lightText
            secText.textColor = UIColor.lightText
            slider.isUserInteractionEnabled = false
        }
        
        if Auth.auth().currentUser != nil {
            
            let userID = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    
                    let usernameDefault = NSUbiquitousKeyValueStore.default
                    let username = value["username"] as? String ?? ""
                    NSUbiquitousKeyValueStore.default.set(username, forKey: "usernameDefault")
                    
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

                    if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
                        
                        self.startBTN.setTitleColor(UIColor.red, for: .normal)
                        self.startBTN.setTitle("Please input different names", for: .normal)
                        self.startBTN.isUserInteractionEnabled = false
                        
                    }
                    
                    if (usernameDefault.object(forKey: "usernameDefault") != nil){
                        MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                        self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                        self.playerOneTF.isUserInteractionEnabled = false
                    } else {
                        usernameDefault.set("Username", forKey: "usernameDefault")
                        MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                        self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                        self.playerOneTF.isUserInteractionEnabled = false
                    }
                    
                    self.playerOneTF.backgroundColor = .clear
                    self.playerOneTF.textColor = UIColor(red: 48.0/255.0, green: 90.0/255.0, blue: 123.0/255.0, alpha: 1.0)
                   
                } else {
                    let usernameDefault = NSUbiquitousKeyValueStore.default
                    
                    if (usernameDefault.object(forKey: "usernameDefault") != nil){
                        MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                        self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                        self.playerOneTF.isUserInteractionEnabled = false
                    } else {
                        usernameDefault.set("Username", forKey: "usernameDefault")
                        MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                        self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                        self.playerOneTF.isUserInteractionEnabled = false
                    }
                    
                    self.playerOneTF.backgroundColor = .clear
                    self.playerOneTF.textColor = UIColor(red: 48.0/255.0, green: 90.0/255.0, blue: 123.0/255.0, alpha: 1.0)
                }
            }) { (error) in
                let usernameDefault = NSUbiquitousKeyValueStore.default

                if (usernameDefault.object(forKey: "usernameDefault") != nil){
                    MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                    self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                    self.playerOneTF.isUserInteractionEnabled = false
                } else {
                    usernameDefault.set("Username", forKey: "usernameDefault")
                    MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                    self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                    self.playerOneTF.isUserInteractionEnabled = false
                }
                
                self.playerOneTF.backgroundColor = .clear
                self.playerOneTF.textColor = UIColor(red: 48.0/255.0, green: 90.0/255.0, blue: 123.0/255.0, alpha: 1.0)
            }
        } else {
            let usernameDefault = NSUbiquitousKeyValueStore.default
            if (usernameDefault.object(forKey: "usernameDefault") != nil){
                MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                self.playerOneTF.isUserInteractionEnabled = true
            } else {
                usernameDefault.set("Username", forKey: "usernameDefault")
                MultiplayerViewController.brownPNV = usernameDefault.object(forKey: "usernameDefault") as! String
                self.playerOneTF.text = "\(usernameDefault.object(forKey: "usernameDefault")!)"
                self.playerOneTF.isUserInteractionEnabled = true
            }
        }
        
        let playerTwoDefault = UserDefaults.standard
        if (playerTwoDefault.value(forKey: "playerTwoName") != nil){
            MultiplayerViewController.bluePNV = playerTwoDefault.value(forKey: "playerTwoName") as! String!
            playerTwoTF.text = "\(MultiplayerViewController.bluePNV)"
        } else {
            playerTwoDefault.set("Blue", forKey: "playerTwoName")
            MultiplayerViewController.bluePNV = playerTwoDefault.value(forKey: "playerTwoName") as! String!
            playerTwoTF.text = "\(MultiplayerViewController.bluePNV)"
        }
        
        MultiplayerViewController.time = UserDefaults.standard.integer(forKey: "multiValueTextValue")
        
        slider.setValue(UserDefaults.standard.float(forKey: "multiSliderValue"), animated: false)
        if UserDefaults.standard.value(forKey: "multiSliderValue") == nil {
            slider.value = 60
        }
        
        value.text = "\(UserDefaults.standard.integer(forKey: "multiValueTextValue"))"
        if UserDefaults.standard.value(forKey: "multiValueTextValue") == nil {
            value.text! = "60"
            MultiplayerViewController.time = 60
        }
        
        GameOverViewController.timePlayed = Double(Int(slider.value))
        
        backBTN.layer.cornerRadius = 10.0
        backBTN.clipsToBounds = true
        bottomBTN.layer.cornerRadius = 10.0
        bottomBTN.clipsToBounds = true
        startBTN.layer.cornerRadius = 10.0
        startBTN.clipsToBounds = true

        self.playerOneTF.delegate = self
        self.playerTwoTF.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        playerOneTF.addGestureRecognizer(tap)
        playerTwoTF.addGestureRecognizer(tap)
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input different names", for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        }
        
        playerOneTF.addTarget(self, action: #selector(PlayerNamesViewController.changed), for: UIControlEvents.editingChanged)
        playerTwoTF.addTarget(self, action: #selector(PlayerNamesViewController.changed), for: UIControlEvents.editingChanged)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var playerOneTF: UITextField!
    @IBOutlet weak var playerTwoTF: UITextField!
    
    @objc func changed() {
        if playerOneTF.text?.isEmpty == false {
            MultiplayerViewController.brownPNV = playerOneTF.text!
            let playerOneDefault = NSUbiquitousKeyValueStore.default
            playerOneDefault.set(MultiplayerViewController.brownPNV, forKey: "usernameDefault")
        }
        
        if playerTwoTF.text?.isEmpty == false {
            MultiplayerViewController.bluePNV = playerTwoTF.text!
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
        }
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input different names", for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        } else {
            
            startBTN.setTitleColor(UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                , for: .normal)
            startBTN.setTitle("Start",for: .normal)
            startBTN.isUserInteractionEnabled = true
            
        }
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
        
        if playerOneTF.text?.isEmpty == true {
            MultiplayerViewController.brownPNV = "Username"
            let playerOneDefault = NSUbiquitousKeyValueStore.default
            playerOneDefault.set(MultiplayerViewController.brownPNV, forKey: "usernameDefault")
        }
        if playerTwoTF.text?.isEmpty == true {
            MultiplayerViewController.bluePNV = "Blue"
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
        }
        
    }
    
    var currentTextField = 0
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if playerOneTF.isEditing == true {
            currentTextField = 0
        }
        if playerTwoTF.isEditing == true {
            currentTextField = 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if playerOneTF.text?.isEmpty == false {
            MultiplayerViewController.brownPNV = playerOneTF.text!
            let playerOneDefault = NSUbiquitousKeyValueStore.default
            playerOneDefault.set(MultiplayerViewController.brownPNV, forKey: "usernameDefault")
        } else {
            MultiplayerViewController.brownPNV = "Username"
            let playerOneDefault = NSUbiquitousKeyValueStore.default
            playerOneDefault.set(MultiplayerViewController.brownPNV, forKey: "usernameDefault")
        }
        
        if playerTwoTF.text?.isEmpty == false {
            MultiplayerViewController.bluePNV = playerTwoTF.text!
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
        } else {
            MultiplayerViewController.bluePNV = "Blue"
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
        }
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input different names",for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        } else {
            
            startBTN.setTitleColor(UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                , for: .normal)
            startBTN.setTitle("Start",for: .normal)
            startBTN.isUserInteractionEnabled = true
            
            if currentTextField == 1 {
                if UserDefaults.standard.value(forKey: "acModeSwitchState") == nil {
                    MultiplayerViewController.differentMode = 1
                }
                
                if acModeSwitch.isOn == true {
                    MultiplayerViewController.bluePNV = playerTwoTF.text!
                    MultiplayerViewController.brownPNV = playerOneTF.text!
                    MultiplayerViewController.differentMode = 1
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }
                
                if trlModeSwitch.isOn == true {
                    MultiplayerViewController.bluePNV = playerTwoTF.text!
                    MultiplayerViewController.brownPNV = playerOneTF.text!
                    MultiplayerViewController.differentMode = 2
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }
            }
        }
        
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        currentTextField = 0
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
