//
//  StartViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var accountDisplay: UIButton!
    @IBOutlet weak var singleplayerDisplay: UIButton!
    @IBOutlet weak var multiplayerDisplay: UIButton!
    @IBOutlet weak var instructionsDisplay: UIButton!
    @IBOutlet weak var moreDisplay: UIButton!
    
    @IBOutlet weak var quickTapTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.value(forKey: "usernameDefault") == nil {
            UserDefaults.standard.set("Username", forKey: "usernameDefault")
            AccountViewController.defaultUsername = UserDefaults.standard.value(forKey: "usernameDefault") as! String
        }
        
        if UserDefaults.standard.value(forKey: "timesPlayed") == nil {
            
            UserDefaults.standard.set(0, forKey: "timesPlayed")
            
        }
        
        if UserDefaults.standard.value(forKey: "Highscore") == nil {
            
            UserDefaults.standard.set(0, forKey: "Highscore")
            
        }
        
        if UserDefaults.standard.value(forKey: "totalPlayTime") == nil {

            print("isNil")
            
            UserDefaults.standard.set(0, forKey: "totalPlayTime")

        }
        
        if UserDefaults.standard.value(forKey: "totalTaps") == nil {

            UserDefaults.standard.set(0, forKey: "totalTaps")

        }
        
        if UserDefaults.standard.value(forKey: "tapedupStatus") == nil {
            
            UserDefaults.standard.set("Beginner", forKey: "tapedupStatus")
            
        }
        
        accountDisplay.layer.cornerRadius = 5.0
        accountDisplay.clipsToBounds = true
        singleplayerDisplay.layer.cornerRadius = 5.0
        singleplayerDisplay.clipsToBounds = true
        multiplayerDisplay.layer.cornerRadius = 5.0
        multiplayerDisplay.clipsToBounds = true
        instructionsDisplay.layer.cornerRadius = 5.0
        instructionsDisplay.clipsToBounds = true
        moreDisplay.layer.cornerRadius = 5.0
        moreDisplay.clipsToBounds = true
    
        quickTapTitle.layer.shadowOpacity = 0.5
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accountAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
    }
    @IBAction func singleplayerAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Initial")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
    }
    @IBAction func multiplayerAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
    }
    @IBAction func instructionsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "tutorial")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
    }
    @IBAction func moreAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "More")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
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
