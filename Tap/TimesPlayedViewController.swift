//
//  TimesPlayedViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 9/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TimesPlayedViewController: UIViewController {

    @IBOutlet weak var totalLBL: UILabel!
    @IBOutlet weak var timeData: UILabel!
    @IBOutlet weak var hsData: UILabel!
    @IBOutlet weak var atData: UILabel!
    @IBOutlet weak var trlData: UILabel!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var errorDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Total Games Played"
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
            
            if WorldContentTableViewController.isViewOtherUsers == false {
            
                let userID = Auth.auth().currentUser?.uid
                Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let value = snapshot.value as? NSDictionary {
                    
                        let timesPlayed = value["timesPlayed"] as? Int
                        NSUbiquitousKeyValueStore.default.set(timesPlayed, forKey: "timesPlayed")
                    
                        let timesPlayedTM = value["timesPlayedTM"] as? Int
                        NSUbiquitousKeyValueStore.default.set(timesPlayedTM, forKey: "timesPlayedTM")
                    
                        let timesPlayedHS = value["timesPlayedHS"] as? Int
                        NSUbiquitousKeyValueStore.default.set(timesPlayedHS, forKey: "timesPlayedHS")
                    
                        let timesPlayedAT = value["timesPlayedAT"] as? Int
                        NSUbiquitousKeyValueStore.default.set(timesPlayedAT, forKey: "timesPlayedAT")
                    
                        let timesPlayedTRLM = value["timesPlayedTRLM"] as? Int
                        NSUbiquitousKeyValueStore.default.set(timesPlayedTRLM, forKey: "timesPlayedTRLM")
                    
                        self.totalLBL.text = "You have played a total of \(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed").cleanValue) games"
                    
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTM") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedTM")
                            self.timeData.text = "0 in Time Mode"
                        } else {
                            self.timeData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTM").cleanValue) in Time Mode"
                        }
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedHS") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedHS")
                            self.hsData.text = "0 in Highscore Mode"
                        } else {
                            self.hsData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedHS").cleanValue) in Highscore Mode"
                        }
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedAT") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedAT")
                            self.atData.text = "0 in AcrossTable Mode"
                        } else {
                            self.atData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedAT").cleanValue) in AcrossTable Mode"
                        }
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTRLM") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedTRLM")
                            self.trlData.text = "0 in Territorial Mode"
                        } else {
                            self.trlData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTRLM").cleanValue) in Territorial Mode"
                        }
                    
                    } else {
                        self.totalLBL.text = "You have played a total of \(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed").cleanValue) games"
                        
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTM") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedTM")
                            self.timeData.text = "0 in Time Mode"
                        } else {
                            self.timeData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTM").cleanValue) in Time Mode"
                        }
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedHS") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedHS")
                            self.hsData.text = "0 in Highscore Mode"
                        } else {
                            self.hsData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedHS").cleanValue) in Highscore Mode"
                        }
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedAT") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedAT")
                            self.atData.text = "0 in AcrossTable Mode"
                        } else {
                            self.atData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedAT").cleanValue) in AcrossTable Mode"
                        }
                        if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTRLM") == nil {
                            NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedTRLM")
                            self.trlData.text = "0 in Territorial Mode"
                        } else {
                            self.trlData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTRLM").cleanValue) in Territorial Mode"
                        }
                    }
                }) { (error) in
                    self.totalLBL.text = "You have played a total of \(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed").cleanValue) games"
                    
                    if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTM") == nil {
                        NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedTM")
                        self.timeData.text = "0 in Time Mode"
                    } else {
                        self.timeData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTM").cleanValue) in Time Mode"
                    }
                    if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedHS") == nil {
                        NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedHS")
                        self.hsData.text = "0 in Highscore Mode"
                    } else {
                        self.hsData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedHS").cleanValue) in Highscore Mode"
                    }
                    if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedAT") == nil {
                        NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedAT")
                        self.atData.text = "0 in AcrossTable Mode"
                    } else {
                        self.atData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedAT").cleanValue) in AcrossTable Mode"
                    }
                    if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTRLM") == nil {
                        NSUbiquitousKeyValueStore.default.set(0, forKey: "timesPlayedTRLM")
                        self.trlData.text = "0 in Territorial Mode"
                    } else {
                        self.trlData.text = "\(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTRLM").cleanValue) in Territorial Mode"
                    }
                }
                
            } else {
                let usernamesRef = Database.database().reference().child("usernamesTaken")
                usernamesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        if let value = snapshot.value as? NSDictionary {

                            if WorldContentTableViewController.nameOfUserViewing != nil || WorldContentTableViewController.nameOfUserViewing?.isEmpty == false {
                                
                                Database.database().reference().child("users").child((value["\(String(describing: WorldContentTableViewController.nameOfUserViewing!))"] as? String? ?? "")!).observeSingleEvent(of: .value, with: { (snapshot) in
                                    if let value = snapshot.value as? NSDictionary {
                                        
                                        let timesPlayed = value["timesPlayed"] as? Int
                                        if timesPlayed == 1 {
                                            self.totalLBL.text = "This player has played a total of \(String(describing: timesPlayed!)) game"
                                        } else {
                                            self.totalLBL.text = "This player has played a total of \(String(describing: timesPlayed!)) games"
                                        }

                                        let timesPlayedTM = value["timesPlayedTM"] as? Int
                                        self.timeData.text = "\(String(describing: timesPlayedTM!)) in Time Mode"

                                        let timesPlayedHS = value["timesPlayedHS"] as? Int
                                        self.hsData.text = "\(String(describing: timesPlayedHS!)) in Highscore Mode"

                                        let timesPlayedAT = value["timesPlayedAT"] as? Int
                                        self.atData.text = "\(String(describing: timesPlayedAT!)) in AcrossTable Mode"

                                        let timesPlayedTRLM = value["timesPlayedTRLM"] as? Int
                                        self.trlData.text = "\(String(describing: timesPlayedTRLM!)) in Territorial Mode"
                             
                                    } else {
                                        self.animateIn()
                                        self.errorDescription.text = "Games played couldn't be found"
                                    }
                                }, withCancel: { (error) in
                                    self.animateIn()
                                    self.errorDescription.text = "\(error.localizedDescription)"
                                })
                            } else {
                                self.animateIn()
                                self.errorDescription.text = "Games played couldn't be found"
                            }
                        } else {
                            self.animateIn()
                            self.errorDescription.text = "Games played couldn't be found"
                        }
                    } else {
                        self.animateIn()
                        self.errorDescription.text = "Games played couldn't be found"
                    }
                }, withCancel: { (error) in
                    self.animateIn()
                    self.errorDescription.text = "\(error.localizedDescription)"
                })
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
