//
//  TapedupStatusViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 6/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit

class TapedupStatusViewController: UIViewController {

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var play: UILabel!
    @IBOutlet weak var games: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var taps: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    
    var gamesPlayedBgn: Double = 25
    var timePlayedBgn: Double = 600
    var tapsTappedBgn: Double = 1200
    var gamesPlayedAve: Double = 50
    var timePlayedAve: Double = 1200
    var tapsTappedAve: Double = 2400
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Tapedup Status"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        level.text = "You are \(NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus")!)"
        
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Beginner" {
            if gamesPlayedBgn <= NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") {
                games.isHidden = true
            } else {
                games.isHidden = false
            }
            
            if timePlayedBgn <= NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") {
                time.isHidden = true
            } else {
                time.isHidden = false
            }
            
            if tapsTappedBgn <= NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") {
                taps.isHidden = true
            } else {
                taps.isHidden = false
            }
            games.text = "\((gamesPlayedBgn - NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")).cleanValue) more games"
            time.text = "\((timePlayedBgn - NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")).cleanValue) more seconds of playing"
            taps.text = "\((tapsTappedBgn - NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")).cleanValue) more taps"
            nextLabel.text = "to upgrade your Tapedup Status to Average"
        }
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Average" {
            if gamesPlayedAve <= NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") {
                games.isHidden = true
            } else {
                games.isHidden = false
            }
            
            if timePlayedAve <= NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") {
                time.isHidden = true
            } else {
                time.isHidden = false
            }
            
            if tapsTappedAve <= NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") {
                taps.isHidden = true
            } else {
                taps.isHidden = false
            }
            games.text = "\((gamesPlayedAve - NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")).cleanValue) more games"
            time.text = "\((timePlayedAve - NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")).cleanValue) more seconds of playing"
            taps.text = "\((tapsTappedAve - NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")).cleanValue) more taps"
            nextLabel.text = "to upgrade your Tapedup Status to Master"
        }
        if NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus") == "Master" {
            play.text = "Well done!"
            games.text = "You are one of the unique humans to achieve"
            time.text = "the Master Status!"
            taps.text = "The Developer congratulates you!"
            nextLabel.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
