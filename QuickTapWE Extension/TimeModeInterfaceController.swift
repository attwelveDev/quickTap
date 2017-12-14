//
//  TimeModeInterfaceController.swift
//  QuickTapWE Extension
//
//  Created by Aaron Nguyen on 11/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import WatchKit
import Foundation


class TimeModeInterfaceController: WKInterfaceController {

    @IBOutlet var secsLabel: WKInterfaceLabel!
    @IBOutlet var slider: WKInterfaceSlider!
    
    static var time = 60
    
    @IBAction func sliderDidChange(_ value: Float) {
        let finalValue = Int(round(value))
        secsLabel.setText("\(finalValue)")
        
        TimeModeInterfaceController.time = finalValue
        
    }
    
    @IBAction func goToHM() {
        presentController(withName: "highscoreMode", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["highscoreMode"], contexts: ["highscoreMode"])
    }
    
    @IBAction func back() {
        presentController(withName: "home", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["home"], contexts: ["home"])
    }
    
    @IBAction func startGame() {
        InterfaceController.modeSelection = "time"
        
        GameplayInterfaceController.playerScore = 0
        
        presentController(withName: "gameplay", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["gameplay"], contexts: ["gameplay"])
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        TimeModeInterfaceController.time = 60
        
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
