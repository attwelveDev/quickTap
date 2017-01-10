//
//  TimesPlayedViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 9/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit

class TimesPlayedViewController: UIViewController {

    @IBOutlet weak var totalLBL: UILabel!
    @IBOutlet weak var timeData: UILabel!
    @IBOutlet weak var hsData: UILabel!
    @IBOutlet weak var atData: UILabel!
    @IBOutlet weak var trlData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Total Games Played"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        totalLBL.text = "You have played a total of \(UserDefaults.standard.value(forKey: "timesPlayed")!) games"
        
        if UserDefaults.standard.value(forKey: "timesPlayedTM") == nil {
            UserDefaults.standard.set(0, forKey: "timesPlayedTM")
            timeData.text = "0 in Time Mode"
        } else {
            timeData.text = "\(UserDefaults.standard.integer(forKey: "timesPlayedTM")) in Time Mode"
        }
        if UserDefaults.standard.value(forKey: "timesPlayedHS") == nil {
            UserDefaults.standard.set(0, forKey: "timesPlayedHS")
            hsData.text = "0 in Highscore Mode"
        } else {
            hsData.text = "\(UserDefaults.standard.integer(forKey: "timesPlayedHS")) in Highscore Mode"
        }
        if UserDefaults.standard.value(forKey: "timesPlayedAT") == nil {
            UserDefaults.standard.set(0, forKey: "timesPlayedAT")
            atData.text = "0 in AcrossTable Mode"
        } else {
            atData.text = "\(UserDefaults.standard.integer(forKey: "timesPlayedAT")) in AcrossTable Mode"
        }
        if UserDefaults.standard.value(forKey: "timesPlayedTRLM") == nil {
            UserDefaults.standard.set(0, forKey: "timesPlayedTRLM")
            trlData.text = "0 in Territorial Mode"
        } else {
            trlData.text = "\(UserDefaults.standard.integer(forKey: "timesPlayedTRLM")) in Territorial Mode"
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
