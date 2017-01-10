//
//  HighscoreViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 7/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController {

    @IBOutlet weak var youLBL: UILabel!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var onLBL: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Highscore"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if UserDefaults.standard.value(forKey: "Highscore") != nil && UserDefaults.standard.integer(forKey: "Highscore") > 0 {
            youLBL.text = "You achieved your highscore of"
            highscore.text = "\(UserDefaults.standard.value(forKey: "Highscore")!)"
            onLBL.text = "on"
            date.text = "\(UserDefaults.standard.value(forKey: "checkDateNewHighscore")!)"
        } else if UserDefaults.standard.integer(forKey: "Highscore") == 0 {
            youLBL.isHidden = true
            highscore.isHidden = true
            onLBL.text = "Go play Highscore Mode to see some stats here!"
            date.isHidden = true
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
