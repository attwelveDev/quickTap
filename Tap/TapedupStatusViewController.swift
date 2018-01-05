//
//  TapedupStatusViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 6/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TapedupStatusViewController: UIViewController {

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var levelDescription: UILabel!
    @IBOutlet weak var games: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var taps: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    // Level Requirements
    
    // Intermediate Level
    var gamesPlayedImd: Double = 250
    var timePlayedImd: Double = 1000
    var tapsTappedImd: Double = 10000
    
    // Advanced Level
    var gamesPlayedAvd: Double = 500
    var timePlayedAvd: Double = 10000
    var tapsTappedAvd: Double = 100000
    
    // Professional Level
    var gamesPlayedPsl: Double = 1000
    var timePlayedPsl: Double = 100000
    var tapsTappedPsl: Double = 1000000
    
    // Hardcore Level
    var gamesPlayedHcr: Double = 10000
    var timePlayedHcr: Double = 1000000
    var tapsTappedHcr: Double = 1000000000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Tapedup Status"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 1
        errorView.layer.shadowOffset = CGSize.zero
        errorView.layer.shadowRadius = 10
        errorView.layer.shadowPath = UIBezierPath(rect: errorView.bounds).cgPath
        errorView.layer.cornerRadius = 10.0
        errorView.clipsToBounds = true
        okBtn.layer.cornerRadius = 10.0
        okBtn.clipsToBounds = true
        
        if Auth.auth().currentUser != nil {
        
            let userID = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {

                    let tapedupStatus = value["tapedupStatus"] as? String ?? ""
                    NSUbiquitousKeyValueStore.default.set(tapedupStatus, forKey: "tapedupStatus")
                    
                    let timesPlayed = value["timesPlayed"] as? Int
                    NSUbiquitousKeyValueStore.default.set(timesPlayed, forKey: "timesPlayed")
                    
                    let totalPlayTime = value["totalPlayTime"] as? Int
                    NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
                    
                    let totalTaps = value["totalTaps"] as? Int
                    NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
                    
                    self.calculateStatus()

                } else {
                    self.calculateStatus()
                }
            }) { (error) in
                self.calculateStatus()
            }
        
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateStatus() {
        self.level.text = "You are \(NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus")!)"
        
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Amateur" {
            if self.gamesPlayedImd <= NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") {
                self.games.isHidden = true
            } else {
                self.games.isHidden = false
            }
            
            if self.timePlayedImd <= NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") {
                self.time.isHidden = true
            } else {
                self.time.isHidden = false
            }
            
            if self.tapsTappedImd <= NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") {
                self.taps.isHidden = true
            } else {
                self.taps.isHidden = false
            }
            self.levelDescription.text = "You’re at sea level and you have a long way to go!"
            self.games.text = "Play \((self.gamesPlayedImd - NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")).cleanValue) more games"
            self.time.text = "Play for \((self.timePlayedImd - NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")).cleanValue) more seconds"
            self.taps.text = "Achieve \((self.tapsTappedImd - NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")).cleanValue) more taps"
            self.nextLabel.text = "To upgrade to Intermediate"
        }
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Intermediate" {
            if self.gamesPlayedAvd <= NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") {
                self.games.isHidden = true
            } else {
                self.games.isHidden = false
            }
            
            if self.timePlayedAvd <= NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") {
                self.time.isHidden = true
            } else {
                self.time.isHidden = false
            }
            
            if self.tapsTappedAvd <= NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") {
                self.taps.isHidden = true
            } else {
                self.taps.isHidden = false
            }
            self.levelDescription.text = "Keep going! You’re getting there!"
            self.games.text = "Play \((self.gamesPlayedAvd - NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")).cleanValue) more games"
            self.time.text = "Play for \((self.timePlayedAvd - NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")).cleanValue) more seconds"
            self.taps.text = "Achieve \((self.tapsTappedAvd - NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")).cleanValue) more taps"
            self.nextLabel.text = "To upgrade to Advanced"
        }
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Advanced" {
            if self.gamesPlayedPsl <= NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") {
                self.games.isHidden = true
            } else {
                self.games.isHidden = false
            }
            
            if self.timePlayedPsl <= NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") {
                self.time.isHidden = true
            } else {
                self.time.isHidden = false
            }
            
            if self.tapsTappedPsl <= NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") {
                self.taps.isHidden = true
            } else {
                self.taps.isHidden = false
            }
            self.levelDescription.text = "You’re halfway up that mountain. Keep pushing!"
            self.games.text = "Play \((self.gamesPlayedPsl - NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")).cleanValue) more games"
            self.time.text = "Play for \((self.timePlayedPsl - NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")).cleanValue) more seconds"
            self.taps.text = "Achieve \((self.tapsTappedPsl - NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")).cleanValue) more taps"
            self.nextLabel.text = "To upgrade to Professional"
        }
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Professional" {
            if self.gamesPlayedHcr <= NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") {
                self.games.isHidden = true
            } else {
                self.games.isHidden = false
            }
            
            if self.timePlayedHcr <= NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") {
                self.time.isHidden = true
            } else {
                self.time.isHidden = false
            }
            
            if self.tapsTappedHcr <= NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") {
                self.taps.isHidden = true
            } else {
                self.taps.isHidden = false
            }
            self.levelDescription.text = "Your status says it all. But you have one more step."
            self.games.text = "Play \((self.gamesPlayedHcr - NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")).cleanValue) more games"
            self.time.text = "Play for \((self.timePlayedHcr - NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")).cleanValue) more seconds"
            self.taps.text = "Achieve \((self.tapsTappedHcr - NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")).cleanValue) more taps"
            self.nextLabel.text = "To upgrade to Hardcore"
        }
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Hardcore" {
            self.levelDescription.isHidden = true
            self.games.text = "Well Done!"
            self.time.text = "You have reached the summit."
            self.taps.text = "Everyone looks up to you."
            self.nextLabel.text = "Even the creator of QuickTap."
        }
    }
    
    func animateIn() {
        self.view.addSubview(errorView)
        errorView.center = self.view.center
        
        errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        errorView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.errorView.alpha = 1
            self.errorView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.errorView.alpha = 0
            
        }) { (success: Bool) in
            self.errorView.removeFromSuperview()
        }
    }
    
    @IBAction func dismissError(_ sender: Any) {
        animateOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
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
