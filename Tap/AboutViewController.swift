//
//  AboutViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 25/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "More")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "About"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        textView.layer.cornerRadius = 5.0
        textView.clipsToBounds = true
        
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
