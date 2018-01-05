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
    
    @IBOutlet var backBtn: WKInterfaceButton!
    @IBOutlet var group: WKInterfaceGroup!
    
    static var time = 60
    
    @IBAction func sliderDidChange(_ value: Float) {
        let finalValue = Int(round(value))
        secsLabel.setText("\(finalValue)")
        
        TimeModeInterfaceController.time = finalValue
        
        UserDefaults.standard.set(finalValue, forKey: "sliderValue")
        
    }
    
//    @IBAction func goToHM() {
//        presentController(withName: "highscoreMode", context: nil)
//        WKInterfaceController.reloadRootControllers(withNames: ["highscoreMode"], contexts: ["highscoreMode"])
//    }
    
    @IBAction func back() {
        WKInterfaceController.reloadRootControllers(withNames: ["home"], contexts: ["home"])
    }
    
    @IBAction func startGame() {
        InterfaceController.modeSelection = "time"
        
        GameplayInterfaceController.playerScore = 0

        WKInterfaceController.reloadRootControllers(withNames: ["gameplay"], contexts: ["gameplay"])
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        TimeModeInterfaceController.time = 60
        
        self.backBtn.setAlpha(0)
        self.group.setAlpha(0)
        
        animate(withDuration: 0.2) {
            self.backBtn.setAlpha(1)
            self.group.setAlpha(1)
        }
        
        if UserDefaults.standard.value(forKey: "sliderValue") == nil {
            slider.setValue(60)
            TimeModeInterfaceController.time = 60
            secsLabel.setText("60")
            UserDefaults.standard.set(60, forKey: "sliderValue")
        } else {
            slider.setValue(UserDefaults.standard.value(forKey: "sliderValue") as! Float)
            TimeModeInterfaceController.time = UserDefaults.standard.value(forKey: "sliderValue") as! Int
            secsLabel.setText("\(String(describing: UserDefaults.standard.value(forKey: "sliderValue")!))")
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
