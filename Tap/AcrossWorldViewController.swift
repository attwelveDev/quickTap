//
//  AcrossWorldViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 15/1/18.
//  Copyright © 2018 Aaron Nguyen. All rights reserved.
//

import UIKit

class AcrossWorldViewController: UIViewController {

    // MARK: Declarations
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var randomGameSwitch: UISwitch!
    @IBOutlet weak var createPartySwitch: UISwitch!
    @IBOutlet weak var joinPartySwitch: UISwitch!
    
    @IBOutlet weak var partyCodeField: UITextField!
    
    @IBOutlet weak var randomGameLbl: UILabel!
    @IBOutlet weak var createPartyLbl: UILabel!
    @IBOutlet weak var joinPartyLbl: UILabel!
    
    let defaults = UserDefaults.standard
    
    // MARK: 'Action' functions
    @IBAction func randomGameDidChange(_ sender: Any) {
        switchStateHandler(randomGameSwitch)
    }
    
    @IBAction func createPartyDidChange(_ sender: Any) {
        switchStateHandler(createPartySwitch)
    }
    
    @IBAction func joinPartyDidChange(_ sender: Any) {
        switchStateHandler(joinPartySwitch)
    }
    
    func switchStateHandler(_ sender: UISwitch) {
        switch sender {
        case randomGameSwitch:
            if randomGameSwitch.isOn {
                createPartySwitch.setOn(!randomGameSwitch.isOn, animated: true)
                joinPartySwitch.setOn(!randomGameSwitch.isOn, animated: true)
            } else {
                randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                
                startBtn.setTitleColor(UIColor.red, for: .normal)
                startBtn.setTitle("Please select a mode",for: .normal)
                startBtn.isEnabled = false
            }
        case createPartySwitch:
            if createPartySwitch.isOn {
                randomGameSwitch.setOn(!createPartySwitch.isOn, animated: true)
                joinPartySwitch.setOn(!createPartySwitch.isOn, animated: true)
            } else {
                createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                
                startBtn.setTitleColor(UIColor.red, for: .normal)
                startBtn.setTitle("Please select a mode",for: .normal)
                startBtn.isEnabled = false
            }
        case joinPartySwitch:
            if joinPartySwitch.isOn {
                randomGameSwitch.setOn(!joinPartySwitch.isOn, animated: true)
                createPartySwitch.setOn(!joinPartySwitch.isOn, animated: true)
            } else {
                joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                partyCodeField.isEnabled = false
                
                startBtn.setTitleColor(UIColor.red, for: .normal)
                startBtn.setTitle("Please select a mode",for: .normal)
                startBtn.isEnabled = false
            }
        default:
            break
        }
        
        if sender.isOn {
            startBtn.setTitleColor(UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                , for: .normal)
            startBtn.setTitle("Start",for: .normal)
            startBtn.isEnabled = true
            
            switch sender.isOn {
            case randomGameSwitch.isOn:
                randomGameLbl.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                partyCodeField.isEnabled = false
            case createPartySwitch.isOn:
                randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                createPartyLbl.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                partyCodeField.isEnabled = false
            case joinPartySwitch.isOn:
                randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
                joinPartyLbl.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                partyCodeField.isEnabled = true
            default:
                break
            }
        }
        
        defaults.set(randomGameSwitch.isOn, forKey: "rgState")
        defaults.set(createPartySwitch.isOn, forKey: "cpState")
        defaults.set(joinPartySwitch.isOn, forKey: "jpState")
    }
    
    @IBAction func startGame(_ sender: Any) {
        if randomGameSwitch.isOn {
            print("rg")
        } else if createPartySwitch.isOn {
            createRandomString()
            partyCodeField.text = randomString
            randomString = ""
        } else if joinPartySwitch.isOn {
            print("jp")
        } else {
            randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            partyCodeField.isEnabled = false
            
            startBtn.setTitleColor(UIColor.red, for: .normal)
            startBtn.setTitle("Please select a mode",for: .normal)
            startBtn.isEnabled = false
        }
    }
    
    var randomString = ""
    
    func createRandomString() {
        let characters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(characters.length)
        
        for _ in 0 ..< 6 {
            let rand = arc4random_uniform(len)
            var nextCharacter = characters.character(at: Int(rand))
            randomString += NSString(characters: &nextCharacter, length: 1) as String
        }
    }
    
    // MARK: 'Default' Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if defaults.object(forKey: "rgState") != nil {
            randomGameSwitch.setOn(defaults.bool(forKey: "rgState"), animated: false)
            createPartySwitch.setOn(defaults.bool(forKey: "cpState"), animated: false)
            joinPartySwitch.setOn(defaults.bool(forKey: "jpState"), animated: false)
        } else {
            defaults.set(true, forKey: "rgState")
            defaults.set(false, forKey: "cpState")
            defaults.set(false, forKey: "jpState")
            
            randomGameSwitch.setOn(defaults.bool(forKey: "rgState"), animated: false)
            createPartySwitch.setOn(defaults.bool(forKey: "cpState"), animated: false)
            joinPartySwitch.setOn(defaults.bool(forKey: "jpState"), animated: false)
        }
        
        if randomGameSwitch.isOn {
            randomGameLbl.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            partyCodeField.isEnabled = false
        }
        
        if createPartySwitch.isOn {
            randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            createPartyLbl.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            partyCodeField.isEnabled = false
        }
        
        if joinPartySwitch.isOn {
            randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            joinPartyLbl.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            partyCodeField.isEnabled = true
        }
        
        if !randomGameSwitch.isOn && !createPartySwitch.isOn && !joinPartySwitch.isOn {
            randomGameLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            createPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            joinPartyLbl.textColor = UIColor(red: 81.0/255.0, green: 118.0/255.0, blue: 138.0/255.0, alpha: 1.0)
            partyCodeField.isEnabled = false
            
            startBtn.setTitleColor(UIColor.red, for: .normal)
            startBtn.setTitle("Please select a mode",for: .normal)
            startBtn.isEnabled = false
        }
        
        startBtn.layer.cornerRadius = 10.0
        startBtn.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Go Back Action
    @IBAction func goBack(_ sender: Any) {
        MultiplayerViewController.instantiationSource = "playerNames"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
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
