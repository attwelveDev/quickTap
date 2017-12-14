//
//  HighscoreModeInterfaceController.swift
//  QuickTapWE Extension
//
//  Created by Aaron Nguyen on 11/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class HighscoreModeInterfaceController: WKInterfaceController, WCSessionDelegate {

    @available(watchOSApplicationExtension 2.2, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    @IBOutlet var highscore: WKInterfaceLabel!
    
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

    @IBAction func goToTM() {
        presentController(withName: "timeMode", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["timeMode"], contexts: ["timeMode"])
    }
    
    @IBAction func startGame() {
        InterfaceController.modeSelection = "highscore"
        
        TimeModeInterfaceController.time = 60
        
        GameplayInterfaceController.playerScore = 0
        
        presentController(withName: "gameplay", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["gameplay"], contexts: ["gameplay"])
    }
    
    @IBAction func back() {
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
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
