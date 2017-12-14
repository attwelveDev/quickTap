//
//  InterfaceController.swift
//  QuickTapWE Extension
//
//  Created by Aaron Nguyen on 11/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    static var modeSelection: String!

    @IBAction func goToTimeMode() {
        presentController(withName: "timeMode", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["timeMode"], contexts: ["timeMode"])
    }
    
    @IBAction func goToHighscoreMode() {
        presentController(withName: "highscoreMode", context: nil)
        WKInterfaceController.reloadRootControllers(withNames: ["highscoreMode"], contexts: ["highscoreMode"])
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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
