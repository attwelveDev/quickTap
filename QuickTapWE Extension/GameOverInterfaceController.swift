//
//  GameOverInterfaceController.swift
//  QuickTapWE Extension
//
//  Created by Aaron Nguyen on 12/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import WatchKit
import Foundation
//import WatchConnectivity

class GameOverInterfaceController: WKInterfaceController {
    
//    @available(watchOSApplicationExtension 2.2, *)
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//
//    let session = WCSession.default
//
//    private func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
//        DispatchQueue.main.async() {
//            self.processApplicationContext()
//        }
//    }
//
//    func processApplicationContext() {
//        if let iPhoneContext = session.receivedApplicationContext as? [String : Double] {
//            if iPhoneContext["highscore"] != nil {
//                highscore.setText(String(describing: iPhoneContext["highscore"]!.cleanValue))
//            }
//        }
//    }
    
    @IBOutlet var group: WKInterfaceGroup!
    
    @IBOutlet var score: WKInterfaceLabel!
    @IBOutlet var highscore: WKInterfaceLabel!
    @IBOutlet var leftHighscoreLbl: WKInterfaceLabel!
    @IBOutlet var highscoreGroup: WKInterfaceGroup!
    
    @IBAction func playAgain() {
        if InterfaceController.modeSelection == "time" {
            WKInterfaceController.reloadRootControllers(withNames: ["timeMode"], contexts: ["timeMode"])
        } else if InterfaceController.modeSelection == "highscore" {
            WKInterfaceController.reloadRootControllers(withNames: ["highscoreMode"], contexts: ["highscoreMode"])
        }
    }
    
    @IBAction func goToMenu() {
        WKInterfaceController.reloadRootControllers(withNames: ["home"], contexts: ["home"])
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
        
        if InterfaceController.modeSelection == "time" {
            leftHighscoreLbl.setText("Time")
            highscore.setText("\(TimeModeInterfaceController.time) secs")
        } else if InterfaceController.modeSelection == "highscore" {
            leftHighscoreLbl.setText("Highscore")
        }
        
        score.setText("\(GameplayInterfaceController.playerScore)")
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
