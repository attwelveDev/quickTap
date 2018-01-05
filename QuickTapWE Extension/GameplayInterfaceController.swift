//
//  GameplayInterfaceController.swift
//  QuickTapWE Extension
//
//  Created by Aaron Nguyen on 12/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import WatchKit
import Foundation
//import WatchConnectivity

class GameplayInterfaceController: WKInterfaceController {
    
//    @available(watchOSApplicationExtension 2.2, *)
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//
//    let session = WCSession.default
//    var session2: WCSession?
//
//    private func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
//        DispatchQueue.main.async() {
//            self.processApplicationContext()
//        }
//    }
//
//    var storedHighscore: Int = 0
//
//    func processApplicationContext() {
//        if let iPhoneContext = session.receivedApplicationContext as? [String : Double] {
//            if iPhoneContext["highscore"] != nil {
//                highscore.setText(String(describing: iPhoneContext["highscore"]!.cleanValue))
//
//                storedHighscore = Int(iPhoneContext["highscore"]!.cleanValue)!
//            }
//        }
//    }
    
    @IBOutlet var group: WKInterfaceGroup!
    
    @IBOutlet var score: WKInterfaceLabel!
//    @IBOutlet var highscoreGroup: WKInterfaceGroup!
    @IBOutlet var countdown: WKInterfaceLabel!
//    @IBOutlet var highscore: WKInterfaceLabel!

    static var playerScore = 0

    @IBAction func tapped() {
        GameplayInterfaceController.playerScore += 1
        score.setText("\(GameplayInterfaceController.playerScore)")
        
//        if InterfaceController.modeSelection == "highscore" {
//            if GameplayInterfaceController.playerScore >= storedHighscore {
//                storedHighscore = GameplayInterfaceController.playerScore
//                highscore.setText(String(storedHighscore))
//                score.setTextColor(UIColor.green)
//                highscore.setTextColor(UIColor.green)
//                
//                if let validSession = session2 {
//                    let watchAppContext = ["highscore": storedHighscore]
//                    
//                    do {
//                        try validSession.updateApplicationContext(watchAppContext)
//                    } catch {
//                        print("error")
//                    }
//                }
//            }
//        }
        WKInterfaceDevice.current().play(.click)
        
    }

    
    var interval = 1
    var countdownTime = TimeModeInterfaceController.time
    
    @objc func countdownTimer() {
        
        countdownTime -= 1
        countdown.setText("\(countdownTime) secs")
        
        if countdownTime < 11 {
            countdown.setTextColor(UIColor.red)
        }
        
        if countdownTime == 1 {
            countdown.setText("\(countdownTime) sec")
        }
        
        if countdownTime == 0 {
            WKInterfaceController.reloadRootControllers(withNames: ["gameOver"], contexts: ["gameOver"])
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
//        processApplicationContext()
//
//        session.delegate = self
//        session.activate()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        self.group.setAlpha(0)
        
        animate(withDuration: 0.2) {
            self.group.setAlpha(1)
        }
        
        countdown.setText("\(countdownTime) secs")
        
        if countdownTime == 10 {
            countdown.setTextColor(UIColor.red)
        }
//
//        if InterfaceController.modeSelection == "time" {
//            highscoreGroup.setHidden(true)
//        } else if InterfaceController.modeSelection == "highscore" {
//            highscoreGroup.setHidden(false)
//        }
        
        interval = 1
        
        _ = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(GameplayInterfaceController.countdownTimer), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
    }

}
