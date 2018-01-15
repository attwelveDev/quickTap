//
//  StartViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 13/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
//import LocalAuthentication


class StartViewController: UIViewController {

    @IBOutlet weak var accountDisplay: UIButton!
    @IBOutlet weak var singleplayerDisplay: UIButton!
    @IBOutlet weak var multiplayerDisplay: UIButton!
    @IBOutlet weak var instructionsDisplay: UIButton!
    @IBOutlet weak var moreDisplay: UIButton!
    
    @IBOutlet weak var quickTapTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        if UserDefaults.standard.bool(forKey: "userHasTouchIDAuth") == true {
//
//        } else {
//            UserDefaults.standard.set(false, forKey: "userHasTouchIDAuth")
//        }
        
//        if NSUbiquitousKeyValueStore.default.object(forKey: "usernameDefault") == nil {
//            NSUbiquitousKeyValueStore.default.set("Username", forKey: "usernameDefault")
//            AccountViewController.defaultUsername = NSUbiquitousKeyValueStore.default.object(forKey: "usernameDefault") as! String
//        }
        
        accountDisplay.layer.cornerRadius = 10.0
        accountDisplay.clipsToBounds = true
        singleplayerDisplay.layer.cornerRadius = 10.0
        singleplayerDisplay.clipsToBounds = true
        multiplayerDisplay.layer.cornerRadius = 10.0
        multiplayerDisplay.clipsToBounds = true
        instructionsDisplay.layer.cornerRadius = 10.0
        instructionsDisplay.clipsToBounds = true
        moreDisplay.layer.cornerRadius = 10.0
        moreDisplay.clipsToBounds = true
    
        quickTapTitle.layer.shadowOpacity = 0.5
        
//        EnableTouchIDView.layer.cornerRadius = 10.0
//        EnableTouchIDView.clipsToBounds = true
//        cancelBTN.layer.cornerRadius = 10.0
//        cancelBTN.clipsToBounds = true
//        okBTN.layer.cornerRadius = 10.0
//        okBTN.clipsToBounds = true
        
//        accountDisplay.layer.shadowColor = UIColor.black.cgColor
//        accountDisplay.layer.shadowOpacity = 1
//        accountDisplay.layer.shadowOffset = CGSize.zero
//        accountDisplay.layer.shadowRadius = 10
//        accountDisplay.layer.shadowPath = UIBezierPath(rect: accountDisplay.bounds).cgPath
//        
//        singleplayerDisplay.layer.shadowColor = UIColor.black.cgColor
//        singleplayerDisplay.layer.shadowOpacity = 1
//        singleplayerDisplay.layer.shadowOffset = CGSize.zero
//        singleplayerDisplay.layer.shadowRadius = 10
//        singleplayerDisplay.layer.shadowPath = UIBezierPath(rect: singleplayerDisplay.bounds).cgPath
//        
//        multiplayerDisplay.layer.shadowColor = UIColor.black.cgColor
//        multiplayerDisplay.layer.shadowOpacity = 1
//        multiplayerDisplay.layer.shadowOffset = CGSize.zero
//        multiplayerDisplay.layer.shadowRadius = 10
//        multiplayerDisplay.layer.shadowPath = UIBezierPath(rect: multiplayerDisplay.bounds).cgPath
//        
//        instructionsDisplay.layer.shadowColor = UIColor.black.cgColor
//        instructionsDisplay.layer.shadowOpacity = 1
//        instructionsDisplay.layer.shadowOffset = CGSize.zero
//        instructionsDisplay.layer.shadowRadius = 10
//        instructionsDisplay.layer.shadowPath = UIBezierPath(rect: instructionsDisplay.bounds).cgPath
//        
//        moreDisplay.layer.shadowColor = UIColor.black.cgColor
//        moreDisplay.layer.shadowOpacity = 1
//        moreDisplay.layer.shadowOffset = CGSize.zero
//        moreDisplay.layer.shadowRadius = 10
//        moreDisplay.layer.shadowPath = UIBezierPath(rect: moreDisplay.bounds).cgPath
//        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Authentication foundation for the future
    
//    @IBOutlet weak var cancelBTN: UIButton!
//    @IBOutlet weak var okBTN: UIButton!
//    @IBOutlet weak var errorTitle: UILabel!
//    @IBAction func dismissEnabling(_ sender: Any) {
//        animateOutTID()
//    }
//    @IBAction func touchIDAuth(_ sender: Any) {
//        if UserDefaults.standard.bool(forKey: "userHasTouchIDAuth") == true {
//            self.authenitcateUser()
//        }
//        let context = LAContext()
//
//        var error: NSError?
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//
//        } else {
//            animateOutTID()
//        }
//    }
//    @IBOutlet weak var errorAndStuffTID: UILabel!
//    var effect: UIVisualEffect!
//    var visualEffectView: UIVisualEffectView!
//    @IBOutlet var EnableTouchIDView: UIView!
//    func animateInTID() {
//        self.view.addSubview(EnableTouchIDView)
//        EnableTouchIDView.center = self.view.center
//
//        self.errorTitle.text = "Touch ID Authentication"
//        self.errorAndStuffTID.text = "To access your Tapedup Profile, press 'OK' then input your Touch ID"
//
//        EnableTouchIDView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
//        EnableTouchIDView.alpha = 0
//
//        UIView.animate(withDuration: 0.5) {
//            self.visualEffectView?.effect = self.effect
//            self.EnableTouchIDView.alpha = 1
//            self.EnableTouchIDView.transform = CGAffineTransform.identity
//        }
//    }
//
//    func animateOutTID() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.EnableTouchIDView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
//            self.EnableTouchIDView.alpha = 0
//
//            self.visualEffectView?.effect = nil
//
//        }) { (success: Bool) in
//            self.EnableTouchIDView.removeFromSuperview()
//        }
//    }
//
//    func authenitcateUser() {
//        let context = LAContext()
//
//        var error: NSError?
//
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let displayedPermissionString = "You chose to lock your account \(AccountViewController.defaultUsername). In order to access it, input your Touch ID"
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: displayedPermissionString) {
//                [unowned self] success, authenticationError in
//                DispatchQueue.main.async {
//                    if success {
//                        self.animateOutTID()
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
//                        ivc.modalPresentationStyle = .custom
//                        ivc.modalTransitionStyle = .crossDissolve
//                        //        self.present(ivc, animated: true, completion: { _ in })
//                        self.present(ivc, animated: true, completion: nil)
//
//                    } else {
//                        self.errorTitle.text = "Error"
//                        self.errorAndStuffTID.text = "Access to Tapedup Failed. Please try again."
//                    }
//                }
//            }
//
//        } else {
//            animateInTID()
//            self.errorTitle.text = "Touch ID Authentication"
//            self.errorAndStuffTID.text = "To access your Tapedup Profile, press 'OK' then input your Touch ID"
//        }
//    }
    
    @IBAction func accountAction(_ sender: Any) {
//        if UserDefaults.standard.bool(forKey: "userHasTouchIDAuth") == true {
//            animateInTID()
//        } else {
//            UserDefaults.standard.set(false, forKey: "userHasTouchIDAuth")
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
        }
//        }
    }
    @IBAction func singleplayerAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Initial")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //       self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    @IBAction func multiplayerAction(_ sender: Any) {
        MultiplayerViewController.instantiationSource = "playerNames"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Multi")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    @IBAction func instructionsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "tutorial")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    @IBAction func moreAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "More")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
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
