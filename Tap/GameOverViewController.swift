//  GameOverViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}


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
    static var timePlayed: Double = 60
    
    static var newLevel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Auth.auth().currentUser != nil {

            // Do any additional setup after loading the view.
            
            let user = Auth.auth().currentUser
            
            guard let uid = user?.uid else {
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
            let usersRef = ref.child("users").child(uid)

                var timesPlayed = NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")
                
                if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayed") == nil {
                    
                    NSUbiquitousKeyValueStore.default.set(1, forKey: "timesPlayed")
                    
                    let values = ["timesPlayed": timesPlayed]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                } else {
                    timesPlayed += 1
                    
                    NSUbiquitousKeyValueStore.default.set(timesPlayed, forKey: "timesPlayed")
                    
                    let values = ["timesPlayed": timesPlayed]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                }
                
                var totalPlayTime = NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")
                
                if NSUbiquitousKeyValueStore.default.object(forKey: "totalPlayTime") == nil {
                    
                    if ViewController.mode == 1 {
                        NSUbiquitousKeyValueStore.default.set(GameOverViewController.timePlayed, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 0 {
                        NSUbiquitousKeyValueStore.default.set(60, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 2 {
                        NSUbiquitousKeyValueStore.default.set(GameOverViewController.timePlayed, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 3 {
                        NSUbiquitousKeyValueStore.default.set(MultiplayerViewController.timeDurationOfTM, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    }
                    
                } else {
                    
                    if ViewController.mode == 1 {
                        totalPlayTime += GameOverViewController.timePlayed
                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 0 {
                        totalPlayTime += 60
                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 2 {
                        totalPlayTime += GameOverViewController.timePlayed
                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 3 {
                        totalPlayTime += MultiplayerViewController.timeDurationOfTM
                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
                        
                        let values = ["totalPlayTime": totalPlayTime]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    }
                    
                }
                
                var totalTaps = NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")
                
                if NSUbiquitousKeyValueStore.default.object(forKey: "totalTaps") == nil {
                    
                    if ViewController.mode == 1 {
                        NSUbiquitousKeyValueStore.default.set(ViewController.score, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 0 {
                        NSUbiquitousKeyValueStore.default.set(ViewController.score, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 2 {
                        NSUbiquitousKeyValueStore.default.set(MultiplayerViewController.whiteScore, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 3 {
                        NSUbiquitousKeyValueStore.default.set(MultiplayerViewController.timesTapped, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    }
                    
                } else {
                    
                    if ViewController.mode == 1 {
                        totalTaps += ViewController.score
                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 0 {
                        totalTaps += ViewController.score
                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 2 {
                        totalTaps += MultiplayerViewController.whiteScore
                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    } else if ViewController.mode == 3 {
                        totalTaps += MultiplayerViewController.timesTapped
                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
                        
                        let values = ["totalTaps": totalTaps]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                    }
                    
                }
                
                
                if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 250 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 1000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 10000 {
                    
                    let defaults = NSUbiquitousKeyValueStore.default
                    if defaults.object(forKey: "isFirstGoingIntermediate") == nil {
                        defaults.set("No", forKey:"isFirstGoingIntermediate")
                        defaults.synchronize()
                        GameOverViewController.newLevel = true
                    }
                    
                    NSUbiquitousKeyValueStore.default.set("Intermediate", forKey: "tapedupStatus")
                    
                    let values = ["tapedupStatus": NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                    if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 500 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 10000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 100000 {
                        
                        let defaults = NSUbiquitousKeyValueStore.default
                        if defaults.object(forKey: "isFirstGoingAdvanced") == nil {
                            defaults.set("No", forKey:"isFirstGoingAdvanced")
                            defaults.synchronize()
                            GameOverViewController.newLevel = true
                        }
                        
                        NSUbiquitousKeyValueStore.default.set("Advanced", forKey: "tapedupStatus")
                        
                        let values = ["tapedupStatus": NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")]
                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                        
                        if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 1000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 100000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 1000000 {
                            
                            let defaults = NSUbiquitousKeyValueStore.default
                            if defaults.object(forKey: "isFirstGoingProfessional") == nil {
                                defaults.set("No", forKey:"isFirstGoingProfessional")
                                defaults.synchronize()
                                GameOverViewController.newLevel = true
                            }
                            
                            NSUbiquitousKeyValueStore.default.set("Professional", forKey: "tapedupStatus")
                            
                            let values = ["tapedupStatus": NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")]
                            usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                            
                            if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 10000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 1000000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 1000000000 {
                                
                                let defaults = NSUbiquitousKeyValueStore.default
                                if defaults.object(forKey: "isFirstGoingHardcore") == nil {
                                    defaults.set("No", forKey:"isFirstGoingHardcore")
                                    defaults.synchronize()
                                    GameOverViewController.newLevel = true
                                }
                                
                                NSUbiquitousKeyValueStore.default.set("Hardcore", forKey: "tapedupStatus")
                                
                                let values = ["tapedupStatus": NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")]
                                usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                                
                            }
                        }
                    }
                } else {
                    NSUbiquitousKeyValueStore.default.set("Amateur", forKey: "tapedupStatus")
                    
                    let values = ["tapedupStatus": NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                }
                
//            }, withCancel: { (error) in
////                var timesPlayed = NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed")
////
////                if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayed") == nil {
////                    NSUbiquitousKeyValueStore.default.set(1, forKey: "timesPlayed")
////                } else {
////                    timesPlayed += 1
////                    NSUbiquitousKeyValueStore.default.set(timesPlayed, forKey: "timesPlayed")
////                }
////
////                var totalPlayTime = NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime")
////
////                if NSUbiquitousKeyValueStore.default.object(forKey: "totalPlayTime") == nil {
////
////                    if ViewController.mode == 1 {
////                        NSUbiquitousKeyValueStore.default.set(GameOverViewController.timePlayed, forKey: "totalPlayTime")
////                    } else if ViewController.mode == 0 {
////                        NSUbiquitousKeyValueStore.default.set(60, forKey: "totalPlayTime")
////                    } else if ViewController.mode == 2 {
////                        NSUbiquitousKeyValueStore.default.set(GameOverViewController.timePlayed, forKey: "totalPlayTime")
////                    } else if ViewController.mode == 3 {
////                        NSUbiquitousKeyValueStore.default.set(MultiplayerViewController.timeDurationOfTM, forKey: "totalPlayTime")
////                    }
////
////                } else {
////
////                    if ViewController.mode == 1 {
////                        totalPlayTime += GameOverViewController.timePlayed
////                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
////                    } else if ViewController.mode == 0 {
////                        totalPlayTime += 60
////                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
////                    } else if ViewController.mode == 2 {
////                        totalPlayTime += GameOverViewController.timePlayed
////                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
////                    } else if ViewController.mode == 3 {
////                        totalPlayTime += MultiplayerViewController.timeDurationOfTM
////                        NSUbiquitousKeyValueStore.default.set(totalPlayTime, forKey: "totalPlayTime")
////                    }
////
////                }
////
////                var totalTaps = NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps")
////
////                if NSUbiquitousKeyValueStore.default.object(forKey: "totalTaps") == nil {
////
////                    if ViewController.mode == 1 {
////                        NSUbiquitousKeyValueStore.default.set(ViewController.score, forKey: "totalTaps")
////                    } else if ViewController.mode == 0 {
////                        NSUbiquitousKeyValueStore.default.set(ViewController.score, forKey: "totalTaps")
////                    } else if ViewController.mode == 2 {
////                        NSUbiquitousKeyValueStore.default.set(MultiplayerViewController.whiteScore, forKey: "totalTaps")
////                    } else if ViewController.mode == 3 {
////                        NSUbiquitousKeyValueStore.default.set(MultiplayerViewController.timesTapped, forKey: "totalTaps")
////                    }
////
////                } else {
////
////                    if ViewController.mode == 1 {
////                        totalTaps += ViewController.score
////                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
////                    } else if ViewController.mode == 0 {
////                        totalTaps += ViewController.score
////                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
////                    } else if ViewController.mode == 2 {
////                        totalTaps += MultiplayerViewController.whiteScore
////                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
////                    } else if ViewController.mode == 3 {
////                        totalTaps += MultiplayerViewController.timesTapped
////                        NSUbiquitousKeyValueStore.default.set(totalTaps, forKey: "totalTaps")
////                    }
////
////                }
////
////
////                if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 250 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 1000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 10000 {
////
////                    let defaults = NSUbiquitousKeyValueStore.default
////                    if defaults.object(forKey: "isFirstGoingIntermediate") == nil {
////                        defaults.set("No", forKey:"isFirstGoingIntermediate")
////                        defaults.synchronize()
////                        GameOverViewController.newLevel = true
////                    }
////
////                    NSUbiquitousKeyValueStore.default.set("Intermediate", forKey: "tapedupStatus")
////                    if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 500 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 10000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 100000 {
////
////                        let defaults = NSUbiquitousKeyValueStore.default
////                        if defaults.object(forKey: "isFirstGoingAdvanced") == nil {
////                            defaults.set("No", forKey:"isFirstGoingAdvanced")
////                            defaults.synchronize()
////                            GameOverViewController.newLevel = true
////                        }
////
////                        NSUbiquitousKeyValueStore.default.set("Advanced", forKey: "tapedupStatus")
////                        if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 1000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 100000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 1000000 {
////
////                            let defaults = NSUbiquitousKeyValueStore.default
////                            if defaults.object(forKey: "isFirstGoingProfessional") == nil {
////                                defaults.set("No", forKey:"isFirstGoingProfessional")
////                                defaults.synchronize()
////                                GameOverViewController.newLevel = true
////                            }
////
////                            NSUbiquitousKeyValueStore.default.set("Professional", forKey: "tapedupStatus")
////                            if NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed") >= 10000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalPlayTime") >= 1000000 && NSUbiquitousKeyValueStore.default.double(forKey: "totalTaps") >= 1000000000 {
////
////                                let defaults = NSUbiquitousKeyValueStore.default
////                                if defaults.object(forKey: "isFirstGoingHardcore") == nil {
////                                    defaults.set("No", forKey:"isFirstGoingHardcore")
////                                    defaults.synchronize()
////                                    GameOverViewController.newLevel = true
////                                }
////
////                                NSUbiquitousKeyValueStore.default.set("Hardcore", forKey: "tapedupStatus")
////                            }
////                        }
////                    }
////                } else {
////                    NSUbiquitousKeyValueStore.default.set("Amateur", forKey: "tapedupStatus")
////                }
//            })
//
        }
        
        mailErrorView.layer.cornerRadius = 10.0
        mailErrorView.clipsToBounds = true
        dismissBTn.layer.cornerRadius = 10.0
        dismissBTn.clipsToBounds = true
        
        MultiplayerViewController.differentMode = 0
        
        restartButton.layer.cornerRadius = 10.0
        restartButton.clipsToBounds = true
        menuDisplay.layer.cornerRadius = 10.0
        menuDisplay.clipsToBounds = true
        
        scoreDisplay.text = "\(ViewController.score.cleanValue)"
        if ViewController.mode == 1 {
            
            if Auth.auth().currentUser != nil {
     
                let user = Auth.auth().currentUser
                
                guard let uid = user?.uid else {
                    return
                }
                
                let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                
                var timesPlayedTM = NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTM")
                if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTM") == nil {
                    NSUbiquitousKeyValueStore.default.set(1, forKey: "timesPlayedTM")
                    
                    let values = ["timesPlayedTM": timesPlayedTM]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                } else {
                    timesPlayedTM += 1
                    NSUbiquitousKeyValueStore.default.set(timesPlayedTM, forKey: "timesPlayedTM")
                    let values = ["timesPlayedTM": timesPlayedTM]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                }
            }
            
            let array = ["Game Over", "Go again!", "Keep going..."]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            hs.text = "Time"
            highscoreDisplay.text = "\(GameOverViewController.timePlayed.cleanValue) secs"
            gameOver.text = "\(array[randomIndex])"
        } else if ViewController.mode == 0 {
            
            let user = Auth.auth().currentUser
            
            guard let uid = user?.uid else {
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
            let usersRef = ref.child("users").child(uid)
            
            
            var timesPlayedHS = NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedHS")
            if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedHS") == nil {
                NSUbiquitousKeyValueStore.default.set(1, forKey: "timesPlayedHS")
                
                let values = ["timesPlayedHS": timesPlayedHS]
                usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
            } else {
                timesPlayedHS += 1
                NSUbiquitousKeyValueStore.default.set(timesPlayedHS, forKey: "timesPlayedHS")
                
                let values = ["timesPlayedHS": timesPlayedHS]
                usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
            }
            
            if ViewController.score < ViewController.highscore {
                let array = ["Game Over", "Go again!", "Keep going..."]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                hs.text = "Highscore"
                highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                gameOver.text = "\(array[randomIndex])"
            } else {
                
                let defaults = NSUbiquitousKeyValueStore.default
                if defaults.object(forKey: "checkDateNewHighscore") == nil {
                    
                    let date = Date()
                    let dateFormat = DateFormatter()
                    
                    dateFormat.dateFormat = "dd.MM.yyyy"
                    
                    defaults.set(dateFormat.string(from: date), forKey: "checkDateNewHighscore")
                    
                    let values = ["checkDateNewHighscore": NSUbiquitousKeyValueStore.default.object(forKey: "checkDateNewHighscore")]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                } else {
                    
                    let date = Date()
                    let dateFormat = DateFormatter()
                    
                    dateFormat.dateFormat = "dd.MM.yyyy"
                    
                    defaults.set(dateFormat.string(from: date), forKey: "checkDateNewHighscore")

                    let values = ["checkDateNewHighscore": NSUbiquitousKeyValueStore.default.object(forKey: "checkDateNewHighscore")]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                }
                
                let array = ["New Highscore!", "Whoo! New Highscore!", "Amazing new Highscore!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                hs.text = "Highscore"
                highscoreDisplay.text = "\(ViewController.highscore.cleanValue)"
                if ViewController.score == ViewController.highscore {
                    highscoreDisplay.textColor = UIColor.green
                    scoreDisplay.textColor = UIColor.green
                    gameOver.text = "\(array[randomIndex])"
                }
            }
        } else if ViewController.mode == 2 {
            
            if Auth.auth().currentUser != nil {
                
                let user = Auth.auth().currentUser
                
                guard let uid = user?.uid else {
                    return
                }
                
                let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                
                var timesPlayedAT = NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedAT")
                if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedAT") == nil {
                    NSUbiquitousKeyValueStore.default.set(1, forKey: "timesPlayedAT")
                    
                    let values = ["timesPlayedAT": timesPlayedAT]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                } else {
                    timesPlayedAT += 1
                    NSUbiquitousKeyValueStore.default.set(timesPlayedAT, forKey: "timesPlayedAT")
                    
                    let values = ["timesPlayedAT": timesPlayedAT]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                }
            }
            
            if GameOverViewController.multiplayerWinner == 0 {
                let array = ["\(MultiplayerViewController.brownPNV) Won!", "Master of Taps - \(MultiplayerViewController.brownPNV)", "\(MultiplayerViewController.brownPNV) with the victory!", "You can do better \(MultiplayerViewController.bluePNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                s.text = "\(MultiplayerViewController.brownPNV)'s Score"
                hs.text = "\(MultiplayerViewController.bluePNV)'s Score"
                scoreDisplay.text = "\(MultiplayerViewController.whiteScore.cleanValue)"
                highscoreDisplay.text = "\(MultiplayerViewController.blueScore.cleanValue)"
                gameOver.text = "\(array[randomIndex])"
                s.textColor = UIColor.green
                scoreDisplay.textColor = UIColor.green
            } else if GameOverViewController.multiplayerWinner == 1 {
                let array = ["\(MultiplayerViewController.bluePNV) Won!", "Master of Taps - \(MultiplayerViewController.bluePNV)", "\(MultiplayerViewController.bluePNV) with the victory!", "You can do better \(MultiplayerViewController.brownPNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                s.text = "\(MultiplayerViewController.brownPNV)'s Score"
                hs.text = "\(MultiplayerViewController.bluePNV)'s Score"
                scoreDisplay.text = "\(MultiplayerViewController.whiteScore.cleanValue)"
                highscoreDisplay.text = "\(MultiplayerViewController.blueScore.cleanValue)"
                gameOver.text = "\(array[randomIndex])"
                hs.textColor = UIColor.green
                highscoreDisplay.textColor = UIColor.green
            } else if GameOverViewController.multiplayerWinner == 2 {
                let array = ["It's a tie!", "There's gotta be a winner!?", "A tie? Are you serious?", "Tie? Bowties are better."]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                s.text = "\(MultiplayerViewController.brownPNV)'s Score"
                hs.text = "\(MultiplayerViewController.bluePNV)'s Score"
                scoreDisplay.text = "\(MultiplayerViewController.whiteScore.cleanValue)"
                highscoreDisplay.text = "\(MultiplayerViewController.blueScore.cleanValue)"
                gameOver.text = "\(array[randomIndex])"
            }
        } else if ViewController.mode == 3 {
            
            if Auth.auth().currentUser != nil {
            
                let user = Auth.auth().currentUser
                
                guard let uid = user?.uid else {
                    return
                }
                
                let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                
                var timesPlayedTRLM = NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayedTRLM")
                if NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayedTRLM") == nil {
                    NSUbiquitousKeyValueStore.default.set(1, forKey: "timesPlayedTRLM")
                    
                    let values = ["timesPlayedTRLM": timesPlayedTRLM]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                } else {
                    timesPlayedTRLM += 1
                    NSUbiquitousKeyValueStore.default.set(timesPlayedTRLM, forKey: "timesPlayedTRLM")
                    
                    let values = ["timesPlayedTRLM": timesPlayedTRLM]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                }
                
            }
            
            if GameOverViewController.multiplayerWinner == 0 {
                let array = ["\(MultiplayerViewController.brownPNV) Won!", "Master of Taps - \(MultiplayerViewController.brownPNV)", "\(MultiplayerViewController.brownPNV) with the victory!", "You can do better \(MultiplayerViewController.bluePNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                gameOver.text = "\(array[randomIndex])"
                scoreStack.isHidden = true
                hs.text = "Match Duration"
                highscoreDisplay.text = "\(MultiplayerViewController.timeDurationOfTM.cleanValue) secs"
            } else if GameOverViewController.multiplayerWinner == 1 {
                let array = ["\(MultiplayerViewController.bluePNV) Won!", "Master of Taps - \(MultiplayerViewController.bluePNV)", "\(MultiplayerViewController.bluePNV) with the victory!", "You can do better \(MultiplayerViewController.brownPNV)!"]
                let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
                gameOver.text = "\(array[randomIndex])"
                scoreStack.isHidden = true
                hs.text = "Time"
                highscoreDisplay.text = "\(MultiplayerViewController.timeDurationOfTM.cleanValue) secs"
            }
        }

        restartButton.layer.cornerRadius = 10.0
        restartButton.clipsToBounds = true
        shareButton.layer.cornerRadius = 10.0
        shareButton.clipsToBounds = true
        menuDisplay.layer.cornerRadius = 10.0
        menuDisplay.clipsToBounds = true

        mailErrorView.layer.shadowColor = UIColor.black.cgColor
        mailErrorView.layer.shadowOpacity = 1
        mailErrorView.layer.shadowOffset = CGSize.zero
        mailErrorView.layer.shadowRadius = 10
        mailErrorView.layer.shadowPath = UIBezierPath(rect: mailErrorView.bounds).cgPath
        
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
                self.present(mailComposeViewController, animated: true, completion: {
                    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                })
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
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        UINavigationBar.appearance().tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([""])
        if ViewController.mode == 0 {
            mailComposerVC.setSubject("My score in QuickTap!")
            if ViewController.score < ViewController.highscore {
                mailComposerVC.setMessageBody("Hello! Today I played Highscore Mode from QuickTap. I achieved a score of \(ViewController.score.cleanValue) taps and my highscore is \(ViewController.highscore.cleanValue). \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else {
                mailComposerVC.setMessageBody("Hello! Today I played Highscore Mode from QuickTap. I achieved a score of \(ViewController.score.cleanValue) taps and my highscore is \(ViewController.highscore.cleanValue) and therefore beat my previous highscore. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            }
        } else if ViewController.mode == 1 {
            mailComposerVC.setSubject("My score in QuickTap!")
            mailComposerVC.setMessageBody("Hello! Today I played Time Mode from QuickTap. I achieved a score of \(ViewController.score.cleanValue) taps in \(GameOverViewController.timePlayed.cleanValue) secs. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
        } else if ViewController.mode == 2 {
            mailComposerVC.setSubject("Our (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) score in QuickTap!")
            if GameOverViewController.multiplayerWinner == 0 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played AcrossTable Mode from QuickTap. \(MultiplayerViewController.brownPNV) achieved a score of \(MultiplayerViewController.whiteScore.cleanValue) taps beating \(MultiplayerViewController.bluePNV) with the score of \(MultiplayerViewController.blueScore.cleanValue) taps in \(GameOverViewController.timePlayed.cleanValue) secs. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else if GameOverViewController.multiplayerWinner == 1 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played AcrossTable Mode from QuickTap. \(MultiplayerViewController.bluePNV) achieved a score of \(MultiplayerViewController.blueScore.cleanValue) taps beating \(MultiplayerViewController.brownPNV) with the score of \(MultiplayerViewController.whiteScore.cleanValue) taps in \(GameOverViewController.timePlayed.cleanValue) secs. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else if GameOverViewController.multiplayerWinner == 2 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played AcrossTable Mode from QuickTap. \(MultiplayerViewController.bluePNV) achieved a score of \(MultiplayerViewController.blueScore.cleanValue) taps tying with \(MultiplayerViewController.brownPNV) in \(GameOverViewController.timePlayed.cleanValue) secs. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            }
        } else if GameOverViewController.multiplayerWinner == 2 {
            mailComposerVC.setSubject("Our (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) score in QuickTap!")
            if GameOverViewController.multiplayerWinner == 0 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played Territorial Mode from QuickTap and \(MultiplayerViewController.brownPNV) won in \(MultiplayerViewController.timeDurationOfTM.cleanValue) secs. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
            } else if GameOverViewController.multiplayerWinner == 1 {
                mailComposerVC.setMessageBody("Hello! Today we (\(MultiplayerViewController.brownPNV) and \(MultiplayerViewController.bluePNV)) played Territorial Mode from QuickTap and \(MultiplayerViewController.bluePNV) won in \(MultiplayerViewController.timeDurationOfTM.cleanValue) secs. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
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
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            }
        } else if ViewController.mode == 3 {
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            }
        } else {
            (DispatchQueue.main).async{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Initial")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            }
        }
    }
    @IBAction func goToMenu(_ sender: Any) {
        (DispatchQueue.main).async{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
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
