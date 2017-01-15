//
//  PlayerNamesViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 24/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

class PlayerNamesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var startBTN: UIButton!
    @IBAction func startGame(_ sender: Any) {
        
        if playerOneTF.text?.isEmpty == false {
            MultiplayerViewController.brownPNV = playerOneTF.text!
            let playerOneDefault = UserDefaults.standard
            playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
            playerOneDefault.synchronize()
        } else if playerOneTF.text?.isEmpty == true {
            MultiplayerViewController.brownPNV = "Username"
            let playerOneDefault = UserDefaults.standard
            playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
            playerOneDefault.synchronize()
        }
        
        if playerTwoTF.text?.isEmpty == false {
            MultiplayerViewController.bluePNV = playerTwoTF.text!
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
            playerTwoDefault.synchronize()
        } else if playerTwoTF.text?.isEmpty == true {
            MultiplayerViewController.bluePNV = "Blue"
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
            playerTwoDefault.synchronize()
        }
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input two different names.",for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        } else if MultiplayerViewController.brownPNV != MultiplayerViewController.bluePNV {
            
            if UserDefaults.standard.value(forKey: "acModeSwitchState") == nil {
                MultiplayerViewController.bluePNV = playerOneTF.text!
                MultiplayerViewController.brownPNV = playerTwoTF.text!
                MultiplayerViewController.differentMode = 1
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
            
            if acModeSwitch.isOn == true {
                MultiplayerViewController.bluePNV = playerOneTF.text!
                MultiplayerViewController.brownPNV = playerTwoTF.text!
                MultiplayerViewController.differentMode = 1
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
            if trlModeSwitch.isOn == true {
                MultiplayerViewController.bluePNV = playerOneTF.text!
                MultiplayerViewController.brownPNV = playerTwoTF.text!
                MultiplayerViewController.differentMode = 2
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
        }

    }
    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
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
        
        //let playerOneDefault = UserDefaults.standard
        //if (playerOneDefault.value(forKey: "playerOneName") != nil){
        //    MultiplayerViewController.brownPNV = playerOneDefault.value(forKey: "playerOneName") as! String!
        //    playerOneTF.text = "\(MultiplayerViewController.brownPNV)"
        //}
        
        let usernameDefault = UserDefaults.standard
        if (usernameDefault.value(forKey: "usernameDefault") != nil){
            playerOneTF.text = "\(usernameDefault.value(forKey: "usernameDefault")!)"
            playerOneTF.isUserInteractionEnabled = false
        } else {
            
        }
        
        let playerTwoDefault = UserDefaults.standard
        if (playerTwoDefault.value(forKey: "playerTwoName") != nil){
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
        
        backBTN.layer.cornerRadius = 5.0
        backBTN.clipsToBounds = true
        bottomBTN.layer.cornerRadius = 5.0
        bottomBTN.clipsToBounds = true
        startBTN.layer.cornerRadius = 5.0
        startBTN.clipsToBounds = true

        self.playerOneTF.delegate = self
        self.playerTwoTF.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        playerOneTF.addGestureRecognizer(tap)
        playerTwoTF.addGestureRecognizer(tap)
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input two different names.", for: .normal)
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
    
    func changed() {
        if playerOneTF.text?.isEmpty == false {
            MultiplayerViewController.brownPNV = playerOneTF.text!
            let playerOneDefault = UserDefaults.standard
            playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
            playerOneDefault.synchronize()
        } else if playerOneTF.text?.isEmpty == true {
            MultiplayerViewController.brownPNV = "Username"
            let playerOneDefault = UserDefaults.standard
            playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
            playerOneDefault.synchronize()
        }
        
        if playerTwoTF.text?.isEmpty == false {
            MultiplayerViewController.bluePNV = playerTwoTF.text!
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
            playerTwoDefault.synchronize()
        } else if playerTwoTF.text?.isEmpty == true {
            MultiplayerViewController.bluePNV = "Blue"
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
            playerTwoDefault.synchronize()
        }
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input two different names.", for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        } else if MultiplayerViewController.brownPNV != MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                , for: .normal)
            startBTN.setTitle("Start",for: .normal)
            startBTN.isUserInteractionEnabled = true
            
        }
    }
    
    func dismissKeyboard() {
        
        self.view.endEditing(true)
        
        if playerOneTF.text?.isEmpty == true {
            playerOneTF.text = "Brown"
        }
        if playerTwoTF.text?.isEmpty == true {
            playerTwoTF.text = "Blue"
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
        
        if currentTextField == 1 {
            if playerOneTF.text?.isEmpty == false {
                MultiplayerViewController.brownPNV = playerOneTF.text!
                let playerOneDefault = UserDefaults.standard
                playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
                playerOneDefault.synchronize()
            } else if playerOneTF.text?.isEmpty == true {
                MultiplayerViewController.brownPNV = "Username"
                let playerOneDefault = UserDefaults.standard
                playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
                playerOneDefault.synchronize()
            }
            
            if playerTwoTF.text?.isEmpty == false {
                MultiplayerViewController.bluePNV = playerTwoTF.text!
                let playerTwoDefault = UserDefaults.standard
                playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
                playerTwoDefault.synchronize()
            } else if playerTwoTF.text?.isEmpty == true {
                MultiplayerViewController.bluePNV = "Blue"
                let playerTwoDefault = UserDefaults.standard
                playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
                playerTwoDefault.synchronize()
            }
            
            if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
                
                startBTN.setTitleColor(UIColor.red, for: .normal)
                startBTN.setTitle("Please input two different names.",for: .normal)
                startBTN.isUserInteractionEnabled = false
                
            } else if MultiplayerViewController.brownPNV != MultiplayerViewController.bluePNV {
                
                if UserDefaults.standard.value(forKey: "acModeSwitchState") == nil {
                    MultiplayerViewController.differentMode = 1
                }
                
                if acModeSwitch.isOn == true {
                    MultiplayerViewController.bluePNV = playerOneTF.text!
                    MultiplayerViewController.brownPNV = playerTwoTF.text!
                    MultiplayerViewController.differentMode = 1
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    self.present(ivc, animated: true, completion: { _ in })
                }
                if trlModeSwitch.isOn == true {
                    MultiplayerViewController.bluePNV = playerOneTF.text!
                    MultiplayerViewController.brownPNV = playerTwoTF.text!
                    MultiplayerViewController.differentMode = 2
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    self.present(ivc, animated: true, completion: { _ in })
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }

        }
        
        if playerOneTF.text?.isEmpty == true {
            playerOneTF.text = "Username"
        }
        if playerTwoTF.text?.isEmpty == true {
            playerTwoTF.text = "Blue"
        }
        
        if playerOneTF.text?.isEmpty == false {
            MultiplayerViewController.brownPNV = playerOneTF.text!
            let playerOneDefault = UserDefaults.standard
            playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
            playerOneDefault.synchronize()
        } else if playerOneTF.text?.isEmpty == true {
            MultiplayerViewController.brownPNV = "Username"
            let playerOneDefault = UserDefaults.standard
            playerOneDefault.setValue(MultiplayerViewController.brownPNV, forKey: "playerOneName")
            playerOneDefault.synchronize()
        }
        
        if playerTwoTF.text?.isEmpty == false {
            MultiplayerViewController.bluePNV = playerTwoTF.text!
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
            playerTwoDefault.synchronize()
        } else if playerTwoTF.text?.isEmpty == true {
            MultiplayerViewController.bluePNV = "Blue"
            let playerTwoDefault = UserDefaults.standard
            playerTwoDefault.setValue(MultiplayerViewController.bluePNV, forKey: "playerTwoName")
            playerTwoDefault.synchronize()
        }
        
        if MultiplayerViewController.brownPNV == MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor.red, for: .normal)
            startBTN.setTitle("Please input two different names.", for: .normal)
            startBTN.isUserInteractionEnabled = false
            
        } else if MultiplayerViewController.brownPNV != MultiplayerViewController.bluePNV {
            
            startBTN.setTitleColor(UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
, for: .normal)
            startBTN.setTitle("Start",for: .normal)
            startBTN.isUserInteractionEnabled = true
            
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
