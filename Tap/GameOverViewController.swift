//  GameOverViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import MessageUI

class GameOverViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var mailErrorView: UIView!
    @IBOutlet weak var dismissBTn: UIButton!
    
    @IBOutlet weak var gameOver: UILabel!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var highscoreDisplay: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var menuDisplay: UIButton!
    
    @IBOutlet weak var hs: UILabel!
    @IBOutlet weak var s: UILabel!
    
    static var multiplayerWinner = 0
    static var timePlayed = 60
    
    static var newLevel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var timesPlayed = UserDefaults.standard.integer(forKey: "timesPlayed")
        
        if UserDefaults.standard.value(forKey: "timesPlayed") == nil {
            
            UserDefaults.standard.set(1, forKey: "timesPlayed")
            
        } else {
            timesPlayed += 1
            
            UserDefaults.standard.set(timesPlayed, forKey: "timesPlayed")
        }
        
        var totalPlayTime = UserDefaults.standard.integer(forKey: "totalPlayTime")
        
        if UserDefaults.standard.value(forKey: "totalPlayTime") == nil {
            
            if ViewController.mode == 1 {
                UserDefaults.standard.set(GameOverViewController.timePlayed, forKey: "totalPlayTime")
            } else if ViewController.mode == 0 {
                UserDefaults.standard.set(60, forKey: "totalPlayTime")
            } else if ViewController.mode == 2 {
                UserDefaults.standard.set(GameOverViewController.timePlayed, forKey: "totalPlayTime")
            } else if ViewController.mode == 3 {
                UserDefaults.standard.set(MultiplayerViewController.timeDurationOfTM, forKey: "totalPlayTime")
            }
            
        } else {
            
            if ViewController.mode == 1 {
                totalPlayTime += GameOverViewController.timePlayed
                UserDefaults.standard.set(totalPlayTime, forKey: "totalPlayTime")
            } else if ViewController.mode == 0 {
                totalPlayTime += 60
                UserDefaults.standard.set(totalPlayTime, forKey: "totalPlayTime")
            } else if ViewController.mode == 2 {
                totalPlayTime += GameOverViewController.timePlayed
                UserDefaults.standard.set(totalPlayTime, forKey: "totalPlayTime")
            } else if ViewController.mode == 3 {
                totalPlayTime += MultiplayerViewController.timeDurationOfTM
                UserDefaults.standard.set(totalPlayTime, forKey: "totalPlayTime")
            }
            
        }
        
        var totalTaps = UserDefaults.standard.integer(forKey: "totalTaps")
        
        if UserDefaults.standard.value(forKey: "totalTaps") == nil {
            
            if ViewController.mode == 1 {
                UserDefaults.standard.set(ViewController.score, forKey: "totalTaps")
            } else if ViewController.mode == 0 {
                UserDefaults.standard.set(ViewController.score, forKey: "totalTaps")
            } else if ViewController.mode == 2 {
                UserDefaults.standard.set(MultiplayerViewController.whiteScore, forKey: "totalTaps")
            } else if ViewController.mode == 3 {
                UserDefaults.standard.set(MultiplayerViewController.timesTapped, forKey: "totalTaps")
            }
            
        } else {
            
            if ViewController.mode == 1 {
                totalTaps += ViewController.score
                UserDefaults.standard.set(totalTaps, forKey: "totalTaps")
            } else if ViewController.mode == 0 {
                totalTaps += ViewController.score
                UserDefaults.standard.set(totalTaps, forKey: "totalTaps")
            } else if ViewController.mode == 2 {
                totalTaps += MultiplayerViewController.whiteScore
                UserDefaults.standard.set(totalTaps, forKey: "totalTaps")
            } else if ViewController.mode == 3 {
                totalTaps += MultiplayerViewController.timesTapped
                UserDefaults.standard.set(totalTaps, forKey: "totalTaps")
            }
            
        }

        
        if UserDefaults.standard.integer(forKey: "timesPlayed") >= 25 && UserDefaults.standard.integer(forKey: "totalPlayTime") >= 600 && UserDefaults.standard.integer(forKey: "totalTaps") >= 1200 {

            let defaults = UserDefaults.standard
            if defaults.object(forKey: "isFirstGoingAverage") == nil {
                defaults.set("No", forKey:"isFirstGoingAverage")
                defaults.synchronize()
                GameOverViewController.newLevel = true
            }
            
            UserDefaults.standard.set("Average", forKey: "tapedupStatus")
        
            if UserDefaults.standard.integer(forKey: "timesPlayed") >= 50 && UserDefaults.standard.integer(forKey: "totalPlayTime") >= 1200 && UserDefaults.standard.integer(forKey: "totalTaps") >= 2400 {
                
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "isFirstGoingMaster") == nil {
                    defaults.set("No", forKey:"isFirstGoingMaster")
                    defaults.synchronize()
                    GameOverViewController.newLevel = true
                }
                
                UserDefaults.standard.set("Master", forKey: "tapedupStatus")
            
            }
        }

        
        mailErrorView.layer.cornerRadius = 5.0
        mailErrorView.clipsToBounds = true
        dismissBTn.layer.cornerRadius = 5.0
        dismissBTn.clipsToBounds = true
        
        MultiplayerViewController.differentMode = 0
        
        restartButton.layer.cornerRadius = 5.0
        restartButton.clipsToBounds = true
        menuDisplay.layer.cornerRadius = 5.0
        menuDisplay.clipsToBounds = true
        
        scoreDisplay.text = "\(ViewController.score)"
        if ViewController.mode == 1 {
            var timesPlayedTM = UserDefaults.standard.integer(forKey: "timesPlayedTM")
            if UserDefaults.standard.value(forKey: "timesPlayedTM") == nil {
                UserDefaults.standard.set(1, forKey: "timesPlayedTM")
            } else {
                timesPlayedTM += 1
                UserDefaults.standard.set(timesPlayedTM, forKey: "timesPlayedTM")
            }
            
            let array = ["Game Over", "Go again!", "Keep going..."]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            hs.text = "In the time of"
            highscoreDisplay.text = "\(GameOverViewController.timePlayed) secs"
            gameOver.text = "\(array[randomIndex])"
        } else if ViewController.mode == 0 {
            var timesPlayedHS = UserDefaults.standard.integer(forKey: "timesPlayedHS")
            if UserDefaults.standard.value(forKey: "timesPlayedHS") == nil {
                UserDefaults.standard.set(1, forKey: "timesPlayedHS")
            } else {
                timesPlayedHS += 1
                UserDefaults.standard.set(timesPlayedHS, forKey: "timesPlayedHS")
            }
            
            if ViewController.score < ViewController.highscore {
                let array = ["Game Over", "Go again!", "Keep going..."]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                hs.text = "Highscore"
                highscoreDisplay.text = "\(ViewController.highscore)"
                gameOver.text = "\(array[randomIndex])"
            } else {
                
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "checkDateNewHighscore") == nil {
                    
                    let date = Date()
                    let dateFormat = DateFormatter()
                    
                    dateFormat.dateFormat = "dd.MM.yyyy"
                    
                    defaults.set(dateFormat.string(from: date), forKey: "checkDateNewHighscore")
                    
                } else {
                    
                    let date = Date()
                    let dateFormat = DateFormatter()
                    
                    dateFormat.dateFormat = "dd.MM.yyyy"
                    
                    defaults.set(dateFormat.string(from: date), forKey: "checkDateNewHighscore")

                    
                }
                
                let array = ["New Highscore!", "Whoo! New Highscore!", "Amazing new Highscore!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                hs.text = "Highscore"
                highscoreDisplay.text = "\(ViewController.highscore)"
                if ViewController.score == ViewController.highscore {
                    highscoreDisplay.textColor = UIColor.green
                    scoreDisplay.textColor = UIColor.green
                    gameOver.text = "\(array[randomIndex])"
                }
            }
        } else if ViewController.mode == 2 {
            var timesPlayedAT = UserDefaults.standard.integer(forKey: "timesPlayedAT")
            if UserDefaults.standard.value(forKey: "timesPlayedAT") == nil {
                UserDefaults.standard.set(1, forKey: "timesPlayedAT")
            } else {
                timesPlayedAT += 1
                UserDefaults.standard.set(timesPlayedAT, forKey: "timesPlayedAT")
            }
            
            if GameOverViewController.multiplayerWinner == 0 {
                let array = ["\(MultiplayerViewController.brownPNV) Won!", "Master of Taps - \(MultiplayerViewController.brownPNV)", "\(MultiplayerViewController.brownPNV) with the victory!", "You can do better \(MultiplayerViewController.bluePNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                s.text = "\(MultiplayerViewController.brownPNV)'s Score"
                hs.text = "\(MultiplayerViewController.bluePNV)'s Score"
                scoreDisplay.text = "\(MultiplayerViewController.whiteScore)"
                highscoreDisplay.text = "\(MultiplayerViewController.blueScore)"
                gameOver.text = "\(array[randomIndex])"
                s.textColor = UIColor.green
                scoreDisplay.textColor = UIColor.green
            } else if GameOverViewController.multiplayerWinner == 1 {
                let array = ["\(MultiplayerViewController.bluePNV) Won!", "Master of Taps - \(MultiplayerViewController.bluePNV)", "\(MultiplayerViewController.bluePNV) with the victory!", "You can do better \(MultiplayerViewController.brownPNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                s.text = "\(MultiplayerViewController.brownPNV)'s Score"
                hs.text = "\(MultiplayerViewController.bluePNV)'s Score"
                scoreDisplay.text = "\(MultiplayerViewController.whiteScore)"
                highscoreDisplay.text = "\(MultiplayerViewController.blueScore)"
                gameOver.text = "\(array[randomIndex])"
                hs.textColor = UIColor.green
                highscoreDisplay.textColor = UIColor.green
            } else if GameOverViewController.multiplayerWinner == 2 {
                let array = ["It's a tie!", "There's gotta be a winner!?", "A tie? Are you serious?", "Tie? Bowties are better."]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                s.text = "\(MultiplayerViewController.brownPNV)'s Score"
                hs.text = "\(MultiplayerViewController.bluePNV)'s Score"
                scoreDisplay.text = "\(MultiplayerViewController.whiteScore)"
                highscoreDisplay.text = "\(MultiplayerViewController.blueScore)"
                gameOver.text = "\(array[randomIndex])"
            }
        } else if ViewController.mode == 3 {
            var timesPlayedTRLM = UserDefaults.standard.integer(forKey: "timesPlayedTRLM")
            if UserDefaults.standard.value(forKey: "timesPlayedTRLM") == nil {
                UserDefaults.standard.set(1, forKey: "timesPlayedTRLM")
            } else {
                timesPlayedTRLM += 1
                UserDefaults.standard.set(timesPlayedTRLM, forKey: "timesPlayedTRLM")
            }
            
            if GameOverViewController.multiplayerWinner == 0 {
                let array = ["\(MultiplayerViewController.brownPNV) Won!", "Master of Taps - \(MultiplayerViewController.brownPNV)", "\(MultiplayerViewController.brownPNV) with the victory!", "You can do better \(MultiplayerViewController.bluePNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                gameOver.text = "\(array[randomIndex])"
                scoreStack.isHidden = true
                hs.text = "Match Duration"
                highscoreDisplay.text = "\(MultiplayerViewController.timeDurationOfTM) secs"
            } else if GameOverViewController.multiplayerWinner == 1 {
                let array = ["\(MultiplayerViewController.bluePNV) Won!", "Master of Taps - \(MultiplayerViewController.bluePNV)", "\(MultiplayerViewController.bluePNV) with the victory!", "You can do better \(MultiplayerViewController.brownPNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                gameOver.text = "\(array[randomIndex])"
                scoreStack.isHidden = true
                hs.text = "Match Duration"
                highscoreDisplay.text = "\(MultiplayerViewController.timeDurationOfTM) secs"
            }
        }

        restartButton.layer.cornerRadius = 5.0
        restartButton.clipsToBounds = true
        shareButton.layer.cornerRadius = 5.0
        shareButton.clipsToBounds = true
        menuDisplay.layer.cornerRadius = 5.0
        menuDisplay.clipsToBounds = true

    }
    @IBOutlet weak var scoreStack: UIStackView!
    @IBOutlet weak var hsStack: UIStackView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        
        //let activityViewController = UIActivityViewController(activityItems: [mailComposeViewController], applicationActivities: nil)
        //navigationController?.present(activityViewController, animated: true) {
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        //}
        
        //activityViewController.excludedActivityTypes = [UIActivityType.postToFacebook]
        //activityViewController.excludedActivityTypes = [UIActivityType.postToTwitter]
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        UINavigationBar.appearance().barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        UINavigationBar.appearance().tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([""])
        if ViewController.mode == 0 {
            mailComposerVC.setSubject("My score in QuickTap!")
            if ViewController.score < ViewController.highscore {
                mailComposerVC.setMessageBody("Hello! Today I played Highscore Mode from QuickTap. I achieved a score of \(ViewController.score) taps and my highscore is \(ViewController.highscore). QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else {
                mailComposerVC.setMessageBody("Hello! Today I played Highscore Mode from QuickTap. I achieved a score of \(ViewController.score) taps and my highscore is \(ViewController.highscore) and therefore beat my previous highscore. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            }
        } else if ViewController.mode == 1 {
            mailComposerVC.setSubject("My score in QuickTap!")
            mailComposerVC.setMessageBody("Hello! Today I played Time Mode from QuickTap. I achieved a score of \(ViewController.score) taps in the time of \(GameOverViewController.timePlayed) secs. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
        } else if ViewController.mode == 2 {
            mailComposerVC.setSubject("Our (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) score in QuickTap!")
            if GameOverViewController.multiplayerWinner == 0 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played AcrossTable Mode from QuickTap. \(MultiplayerViewController.brownPNV) achieved a score of \(MultiplayerViewController.whiteScore) taps beating \(MultiplayerViewController.bluePNV) with the score of \(MultiplayerViewController.blueScore) taps in the time of \(GameOverViewController.timePlayed) secs. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else if GameOverViewController.multiplayerWinner == 1 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played AcrossTable Mode from QuickTap. \(MultiplayerViewController.bluePNV) achieved a score of \(MultiplayerViewController.blueScore) taps beating \(MultiplayerViewController.brownPNV) with the score of \(MultiplayerViewController.whiteScore) taps in the time of \(GameOverViewController.timePlayed) secs. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else if GameOverViewController.multiplayerWinner == 2 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played AcrossTable Mode from QuickTap. \(MultiplayerViewController.bluePNV) achieved a score of \(MultiplayerViewController.blueScore) taps tying with \(MultiplayerViewController.brownPNV) in the time of \(GameOverViewController.timePlayed) secs. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            }
        } else if GameOverViewController.multiplayerWinner == 2 {
            mailComposerVC.setSubject("Our (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) score in QuickTap!")
            if GameOverViewController.multiplayerWinner == 0 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played Territorial Mode from QuickTap and \(MultiplayerViewController.brownPNV) won in \(MultiplayerViewController.timeDurationOfTM) secs. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else if GameOverViewController.multiplayerWinner == 1 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played Territorial Mode from QuickTap and \(MultiplayerViewController.bluePNV) won in \(MultiplayerViewController.timeDurationOfTM) secs. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            }
        }
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func showSendMailErrorAlert() {
        animateIn2()
    }
    
    @IBAction func dismissError(_ sender: Any) {
        animateOut2()
    }
    
    
    var effect: UIVisualEffect!
    var visualEffectView: UIVisualEffectView!
    func animateIn2() {
        self.view.addSubview(mailErrorView)
        mailErrorView.center = self.view.center
        
        mailErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        mailErrorView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.mailErrorView.alpha = 1
            self.mailErrorView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut2() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mailErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.mailErrorView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.mailErrorView.removeFromSuperview()
        }
    }
    
    @IBAction func restartAction(_ sender: Any) {
        if ViewController.mode == 2 {
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
        } else if ViewController.mode == 3 {
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
        } else {
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Initial")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                self.present(ivc, animated: true, completion: { _ in })
            }
        }
    }
    @IBAction func goToMenu(_ sender: Any) {
        (DispatchQueue.main).async{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
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
