//
//  GameOverInterfaceController.swift
//  QuickTapWE Extension
//
//  Created by Aaron Nguyen on 12/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class GameOverInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @available(watchOSApplicationExtension 2.2, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    let session = WCSession.default
    
    private func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        DispatchQueue.main.async() {
            self.processApplicationContext()
        }
    }
    
    func processApplicationContext() {
        if let iPhoneContext = session.receivedApplicationContext as? [String : Double] {
            if iPhoneContext["highscore"] != nil {
                highscore.setText(String(describing: iPhoneContext["highscore"]!.cleanValue))
            }
        }
    }

    @IBOutlet var score: WKInterfaceLabel!
    @IBOutlet var highscore: WKInterfaceLabel!
    @IBOutlet var highscoreGroup: WKInterfaceGroup!
    
    @IBAction func playAgain() {
        if InterfaceController.modeSelection == "time" {
            presentController(withName: "timeMode", context: nil)
            WKInterfaceController.reloadRootControllers(withNames: ["timeMode"], contexts: ["timeMode"])
        } else if InterfaceController.modeSelection == "highscore" {
            presentController(withName: "highscoreMode", context: nil)
            WKInterfaceController.reloadRootControllers(withNames: ["highscoreMode"], contexts: ["highscoreMode"])
        }
    }
    
    @IBAction func goToMenu() {
        presentController(withName: "home", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["home"], contexts: ["home"])
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        processApplicationContext()
        
        session.delegate = self
        session.activate()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        if InterfaceController.modeSelection == "time" {
            highscoreGroup.setHidden(true)
        } else if InterfaceController.modeSelection == "highscore" {
            highscoreGroup.setHidden(false)
        }
        
        score.setText("\(GameplayInterfaceController.playerScore)")
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
