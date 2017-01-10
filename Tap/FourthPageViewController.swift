//
//  FourthPageViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 28/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

class FourthPageViewController: UIViewController {

    let step: Float = 10
    
    @IBAction func slider(_ sender: UISlider) {
        let currentValue = round(sender.value / step) * step
        sender.value = currentValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
