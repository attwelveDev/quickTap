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
    
    var gamesPlayedBgn = 25
    var timePlayedBgn = 600
    var tapsTappedBgn = 1200
    var gamesPlayedAve = 50
    var timePlayedAve = 1200
    var tapsTappedAve = 2400
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Tapedup Status"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        level.text = "You are \(UserDefaults.standard.string(forKey: "tapedupStatus")!)"
        
        if UserDefaults.standard.string(forKey: "tapedupStatus") == "Beginner" {
            if gamesPlayedBgn <= UserDefaults.standard.integer(forKey: "timesPlayed") {
                games.isHidden = true
            } else {
                games.isHidden = false
            }
            
            if timePlayedBgn <= UserDefaults.standard.integer(forKey: "totalPlayTime") {
                time.isHidden = true
            } else {
                time.isHidden = false
            }
            
            if tapsTappedBgn <= UserDefaults.standard.integer(forKey: "totalTaps") {
                taps.isHidden = true
            } else {
                taps.isHidden = false
            }
            games.text = "\(gamesPlayedBgn - UserDefaults.standard.integer(forKey: "timesPlayed")) more games"
            time.text = "\(timePlayedBgn - UserDefaults.standard.integer(forKey: "totalPlayTime")) more seconds of playing"
            taps.text = "\(tapsTappedBgn - UserDefaults.standard.integer(forKey: "totalTaps")) more taps"
            nextLabel.text = "to upgrade your Tapedup Status to Average"
        }
        if UserDefaults.standard.string(forKey: "tapedupStatus") == "Average" {
            if gamesPlayedAve <= UserDefaults.standard.integer(forKey: "timesPlayed") {
                games.isHidden = true
            } else {
                games.isHidden = false
            }
            
            if timePlayedAve <= UserDefaults.standard.integer(forKey: "totalPlayTime") {
                time.isHidden = true
            } else {
                time.isHidden = false
            }
            
            if tapsTappedAve <= UserDefaults.standard.integer(forKey: "totalTaps") {
                taps.isHidden = true
            } else {
                taps.isHidden = false
            }
            games.text = "\(gamesPlayedAve - UserDefaults.standard.integer(forKey: "timesPlayed")) more games"
            time.text = "\(timePlayedAve - UserDefaults.standard.integer(forKey: "totalPlayTime")) more seconds of playing"
            taps.text = "\(tapsTappedAve - UserDefaults.standard.integer(forKey: "totalTaps")) more taps"
            nextLabel.text = "to upgrade your Tapedup Status to Master"
        }
        if UserDefaults.standard.string(forKey: "tapedupStatus") == "Master" {
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
