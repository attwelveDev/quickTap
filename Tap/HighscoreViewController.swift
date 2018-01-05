//
//  HighscoreViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 7/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
//import WatchConnectivity
import Firebase
import FirebaseAuth
import FirebaseDatabase

class HighscoreViewController: UIViewController {
//
//    @available(iOS 9.3, *)
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//
//    func sessionDidBecomeInactive(_ session: WCSession) {
//
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//
//    }
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var youLBL: UILabel!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var onLBL: UILabel!
    @IBOutlet weak var date: UILabel!
//
//    var session: WCSession?
//    let session2 = WCSession.default
//
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        DispatchQueue.main.async() {
//            self.processApplicationContext()
//        }
//    }
//
//    func processApplicationContext() {
//        if let watchContext = session2.receivedApplicationContext as? [String : Double] {
//            if watchContext["highscore"] != nil {
//                highscore.text = (String(describing: watchContext["highscore"]!.cleanValue))
//                highscore.text = (String(describing: watchContext["highscore"]!.cleanValue))
//
//                let storedHighscore = Int(watchContext["highscore"]!.cleanValue)!
//                ViewController.highscore = Double(storedHighscore)
//
//                let highscoreDefault = NSUbiquitousKeyValueStore.default
//                highscoreDefault.set(storedHighscore, forKey: "Highscore")
//                highscoreDefault.synchronize()
//            }
//        }
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Highscore"
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
                        
                        let Highscore = value["Highscore"] as? Int
                        NSUbiquitousKeyValueStore.default.set(Highscore, forKey: "Highscore")
                        
                        let checkDateNewHighscore = value["checkDateNewHighscore"] as? String ?? ""
                        NSUbiquitousKeyValueStore.default.set(checkDateNewHighscore, forKey: "checkDateNewHighscore")

                        if NSUbiquitousKeyValueStore.default.object(forKey: "Highscore") != nil && NSUbiquitousKeyValueStore.default.double(forKey: "Highscore") > 0 {
                            self.youLBL.text = "You achieved your highscore of"
                            self.highscore.text = "\(NSUbiquitousKeyValueStore.default.object(forKey: "Highscore")!)"
                            self.onLBL.text = "on"
                            
                            self.date.text = "\(NSUbiquitousKeyValueStore.default.object(forKey: "checkDateNewHighscore")!)"
                            
                        } else if NSUbiquitousKeyValueStore.default.double(forKey: "Highscore") == 0 {
                            self.youLBL.isHidden = true
                            self.highscore.isHidden = true
                            self.onLBL.text = "Go play Highscore Mode to see some stats here!"
                            self.date.isHidden = true
                        }
                    } else {
                        if NSUbiquitousKeyValueStore.default.object(forKey: "Highscore") != nil && NSUbiquitousKeyValueStore.default.double(forKey: "Highscore") > 0 {
                            self.youLBL.text = "You achieved your highscore of"
                            self.highscore.text = "\(NSUbiquitousKeyValueStore.default.object(forKey: "Highscore")!)"
                            self.onLBL.text = "on"
                            
                            self.date.text = "\(NSUbiquitousKeyValueStore.default.object(forKey: "checkDateNewHighscore")!)"
                            
                        } else if NSUbiquitousKeyValueStore.default.double(forKey: "Highscore") == 0 {
                            self.youLBL.isHidden = true
                            self.highscore.isHidden = true
                            self.onLBL.text = "Go play Highscore Mode to see some stats here!"
                            self.date.isHidden = true
                        }
                    }
                }) { (error) in
                    if NSUbiquitousKeyValueStore.default.object(forKey: "Highscore") != nil && NSUbiquitousKeyValueStore.default.double(forKey: "Highscore") > 0 {
                        self.youLBL.text = "You achieved your highscore of"
                        self.highscore.text = "\(NSUbiquitousKeyValueStore.default.object(forKey: "Highscore")!)"
                        self.onLBL.text = "on"
                        
                        self.date.text = "\(NSUbiquitousKeyValueStore.default.object(forKey: "checkDateNewHighscore")!)"
                        
                    } else if NSUbiquitousKeyValueStore.default.double(forKey: "Highscore") == 0 {
                        self.youLBL.isHidden = true
                        self.highscore.isHidden = true
                        self.onLBL.text = "Go play Highscore Mode to see some stats here!"
                        self.date.isHidden = true
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

                                        let Highscore = value["Highscore"] as? Int
                                        NSUbiquitousKeyValueStore.default.set(Highscore, forKey: "Highscore")
                                    
                                        let checkDateNewHighscore = value["checkDateNewHighscore"] as? String ?? ""
                                    
                                        if Highscore == 0 {
                                            self.youLBL.isHidden = true
                                            self.highscore.isHidden = true
                                            self.onLBL.text = "This player hasn't played Highscore Mode yet!"
                                            self.date.isHidden = true
                                        } else {
                                            self.youLBL.text = "This player achieved their highscore of"
                                            self.highscore.text = "\(String(describing: Highscore!))"
                                            self.onLBL.text = "on"
                                            self.date.text = "\(checkDateNewHighscore)"
                                        }
                                    } else {
                                        self.animateIn()
                                        
                                        self.errorDescription.text = "Highscore couldn't be found"
                                    }
                                }, withCancel: { (error) in
                                    self.animateIn()
                                    
                                    self.errorDescription.text = "\(error.localizedDescription)"
                                })
                            } else {
                                self.animateIn()
                                
                                self.errorDescription.text = "Highscore couldn't be found"
                            }
                        
                        } else {
                            self.animateIn()
                            
                            self.errorDescription.text = "Highscore couldn't be found"
                        }
                    } else {
                        self.animateIn()
                        
                        self.errorDescription.text = "Highscore couldn't be found"
                    }
                }, withCancel: { (error) in
                    self.animateIn()
                    
                    self.errorDescription.text = "\(error.localizedDescription)"
                })
            }
        
        }
//
//        if WCSession.isSupported() {
//            session = WCSession.default
//            session?.delegate = self
//            session?.activate()
//        }
//
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
