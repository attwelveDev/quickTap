//
//  MultiplayerViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 18/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

extension CGFloat {
    var cleanCGFValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(describing: self)
    }
}

class MultiplayerViewController: UIViewController {

    static var differentMode = 0
    
    static var time: Int = 60
    
    @IBOutlet weak var whiteScoreStack: UIStackView!
    @IBOutlet weak var whiteTimeStack: UIStackView!
    
    @IBOutlet weak var blueScoreStack: UIStackView!
    @IBOutlet weak var blueTimeStack: UIStackView!
    
    @IBOutlet weak var whiteScoreLabel: UILabel!
    @IBOutlet weak var blueScoreLabel: UILabel!
    
    @IBOutlet weak var whiteCountdown: UILabel!
    @IBOutlet weak var blueCountdown: UILabel!
    
    @IBOutlet weak var brownPN: UILabel!
    @IBOutlet weak var bluePN: UILabel!
    
    static var brownPNV = "Username"
    static var bluePNV = "Blue"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var playerNameView: UIView!
    
    var timer = Timer()
    var stopwatch = Timer()
    
    var visualEffectView: UIVisualEffectView!
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.playerNameView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.playerNameView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.playerNameView.removeFromSuperview()
        }
    }
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var spaceToBTN: NSLayoutConstraint!
    @IBOutlet weak var spaceToBTN2: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        brownPN.isHidden = true
        bluePN.isHidden = true
        whiteScoreStack.isHidden = true
        blueScoreStack.isHidden = true
        whiteTimeStack.isHidden = true
        blueTimeStack.isHidden = true
        
        self.view.addSubview(self.playerNameView)
        playerNameView.center = self.view.center
        
        whiteCountdown.text = "\(MultiplayerViewController.time) secs"
        blueCountdown.text = "\(MultiplayerViewController.time) secs"
        
        if (MultiplayerViewController.time <= 10) {
            whiteCountdown.textColor = UIColor.red
            blueCountdown.textColor = UIColor.red
        } else if (MultiplayerViewController.time >= 11) {
            whiteCountdown.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
            blueCountdown.textColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            self.playerNameView.alpha = 0
        }) { _ in
            self.playerNameView.alpha = 1
        }
        
        if MultiplayerViewController.differentMode == 1 {
            
            ViewController.mode = 2
            
            spaceToBTN.constant = 50
            spaceToBTN2.constant = 50
            
            animateOut()
            brownPN.isHidden = false
            bluePN.isHidden = false
            whiteScoreStack.isHidden = false
            blueScoreStack.isHidden = false
            whiteTimeStack.isHidden = false
            blueTimeStack.isHidden = false
            
            timer.invalidate()
            stopwatch.invalidate()
            
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MultiplayerViewController.update), userInfo: nil, repeats: true)
            
        } else if MultiplayerViewController.differentMode == 2 {

            
            ViewController.mode = 3
            
            spaceToBTN.constant = 1
            spaceToBTN2.constant = 1
            
            animateOut()
            
            brownPN.isHidden = false
            bluePN.isHidden = false
            
            whiteScoreStack.isHidden = false
            blueScoreStack.isHidden = false
            
            score.text = "Match Duration"
            score2.text = "Match Duration"
            
            whiteScoreLabel.text = "0 secs"
            blueScoreLabel.text = "0 secs"
            
            whiteTimeStack.isHidden = true
            blueTimeStack.isHidden = true
            
            timer.invalidate()
            stopwatch.invalidate()
            
            MultiplayerViewController.timeDurationOfTM = 0
            
            self.stopwatch = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MultiplayerViewController.stopwatchUpdate), userInfo: nil, repeats: true)
            
        }

        playerNameView.center = self.view.center

        playerNameView.layer.shadowColor = UIColor.black.cgColor
        playerNameView.layer.shadowOpacity = 1
        playerNameView.layer.shadowOffset = CGSize.zero
        playerNameView.layer.shadowRadius = 10
        playerNameView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        playerNameView.layer.cornerRadius = 5.0
        playerNameView.layer.masksToBounds = false
        
        // Do any additional setup after loading the view.
        whiteScoreStack.transform = CGAffineTransform(rotationAngle: 3.14)
        whiteTimeStack.transform = CGAffineTransform(rotationAngle: 3.14)
        brownPN.transform = CGAffineTransform(rotationAngle: 3.14)
        
        if UserDefaults.standard.value(forKey: "usernameDefault") == nil {
            UserDefaults.standard.set("Username", forKey: "usernameDefault")
            AccountViewController.defaultUsername = "Username"
        }
        MultiplayerViewController.brownPNV = AccountViewController.defaultUsername
        
        brownPN.text = "\(AccountViewController.defaultUsername)"
        bluePN.text = "\(MultiplayerViewController.bluePNV)"
        
        MultiplayerViewController.whiteScore = 0
        MultiplayerViewController.blueScore = 0
        
        MultiplayerViewController.timeDurationOfTM = 0
        MultiplayerViewController.timesTapped = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static var timeDurationOfTM: Double = 0
    
    @objc func stopwatchUpdate() {
        MultiplayerViewController.timeDurationOfTM += 1
        whiteScoreLabel.text = "\(MultiplayerViewController.timeDurationOfTM) secs"
        blueScoreLabel.text = "\(MultiplayerViewController.timeDurationOfTM) secs"
        
        if brownBTN.bounds.height >= self.view.bounds.height {
            
            stopwatch.invalidate()
            
        } else if blueBTN.bounds.height >= self.view.bounds.height {
            
            stopwatch.invalidate()
            
        }
        
    }
    
    @objc func update (){

        MultiplayerViewController.time -= 1
        whiteCountdown.text = "\(MultiplayerViewController.time) secs"
        blueCountdown.text = "\(MultiplayerViewController.time) secs"
        
        if(MultiplayerViewController.time < 11) {
            whiteCountdown.textColor = UIColor.red
            blueCountdown.textColor = UIColor.red
        }
        
        if(MultiplayerViewController.time <= 1) {
            whiteCountdown.text = "\(MultiplayerViewController.time) sec"
            blueCountdown.text = "\(MultiplayerViewController.time) sec"
        }
        
        if(MultiplayerViewController.time == 0) {
            
            (DispatchQueue.main).async{
                self.timer.invalidate()
                self.winner()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            }
        }
    }
    
    static var whiteScore: Double = 0
    static var blueScore: Double = 0
    static var win = 0
    
    func winner () {
        if MultiplayerViewController.whiteScore > MultiplayerViewController.blueScore {
            GameOverViewController.multiplayerWinner = 0
        } else if MultiplayerViewController.blueScore > MultiplayerViewController.whiteScore {
            GameOverViewController.multiplayerWinner = 1
        } else if MultiplayerViewController.blueScore == MultiplayerViewController.whiteScore {
            GameOverViewController.multiplayerWinner = 2
        }
    }
    
    static var timesTapped: Double = 0
    
    @IBOutlet weak var brownBTN: UIButton!
    @IBOutlet weak var brownBTNHeight: NSLayoutConstraint!
    @IBOutlet weak var blueBTN: UIButton!
    @IBOutlet weak var blueBTNHeight: NSLayoutConstraint!
    @IBAction func whiteTapped(_ sender: Any) {
        
        if MultiplayerViewController.differentMode == 2 {
            brownBTNHeight.constant += 5
            blueBTNHeight.constant -= 5
            
            MultiplayerViewController.timesTapped += 1
            
            if brownBTN.bounds.height >= self.view.bounds.height {

                (DispatchQueue.main).async{
                    GameOverViewController.multiplayerWinner = 0
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }

            } else if blueBTN.bounds.height >= self.view.bounds.height {

                (DispatchQueue.main).async{
                    GameOverViewController.multiplayerWinner = 1
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }
                
            }
            
        } else {
        
            MultiplayerViewController.whiteScore += 1
            whiteScoreLabel.text = "\(MultiplayerViewController.whiteScore)"
        
            if MultiplayerViewController.whiteScore > MultiplayerViewController.blueScore {
                whiteScoreLabel.textColor = UIColor.green
                blueScoreLabel.textColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            } else if MultiplayerViewController.whiteScore < MultiplayerViewController.blueScore {
                whiteScoreLabel.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                blueScoreLabel.textColor = UIColor.green
            } else if MultiplayerViewController.whiteScore == MultiplayerViewController.blueScore {
                whiteScoreLabel.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                blueScoreLabel.textColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            }
        }
    }
    @IBAction func blueTapped(_ sender: Any) {
        
        if MultiplayerViewController.differentMode == 2 {
            brownBTNHeight.constant -= 5
            blueBTNHeight.constant += 5

            if blueBTN.bounds.height >= self.view.bounds.height {
                
                (DispatchQueue.main).async{
                    GameOverViewController.multiplayerWinner = 1
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }
                
            } else if brownBTN.bounds.height >= self.view.bounds.height {
                
                (DispatchQueue.main).async{
                    GameOverViewController.multiplayerWinner = 0
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)
                }
                
            }
            
        } else {
        
            MultiplayerViewController.blueScore += 1
            blueScoreLabel.text = "\(MultiplayerViewController.blueScore)"
        
            if MultiplayerViewController.whiteScore < MultiplayerViewController.blueScore {
                whiteScoreLabel.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                blueScoreLabel.textColor = UIColor.green
            } else if MultiplayerViewController.whiteScore > MultiplayerViewController.blueScore {
                whiteScoreLabel.textColor = UIColor.green
                blueScoreLabel.textColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            } else if MultiplayerViewController.whiteScore == MultiplayerViewController.blueScore {
                whiteScoreLabel.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                blueScoreLabel.textColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            }
        }
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
