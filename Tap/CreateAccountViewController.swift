//
//  CreateAccountViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 25/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AgeField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var titleErrorView: UILabel!
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var createAccountLooks: UIButton!
    @IBOutlet weak var loginLooks: UIButton!
    @IBOutlet weak var resetPasswordLooks: UIButton!
    
    @IBAction func createAccount(_ sender: Any) {
        if emailField.text?.isEmpty == true || passwordField.text?.isEmpty == true || usernameField.text?.isEmpty == true || ageField.text?.isEmpty == true {
            
            self.view.endEditing(true)
            
            animateIn()
            
            errorDescription.text = "Please fill in all fields"
            
        } else {
            let charSet = CharacterSet(charactersIn: ".#$[]")
            if usernameField.text?.rangeOfCharacter(from: charSet) == nil {
                
                let numberSet = CharacterSet(charactersIn: "0123456789")
                if ageField.text?.rangeOfCharacter(from: numberSet) != nil {
                    
                    let usernamesRef = Database.database().reference().child("usernamesTaken")
                    let username = self.usernameField.text
                    usernamesRef.child(username!).observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists() {
                            self.view.endEditing(true)
                            
                            self.animateIn()
                            
                            self.errorDescription.text = "This username is taken."
                        } else {
                            if Int(self.ageField.text!)! >= 1 && Int(self.ageField.text!)! <= 100 {
                                Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!) {(user, error) in
                                    
                                    if error == nil {
                                        
                                        self.view.endEditing(true)
                                        
                                        self.animateIn()
                                        self.titleErrorView.text = "Success!"
                                        self.errorDescription.text = "Thank you for creating an account!"
                                        self.okButton.isHidden = true
                                        self.createAccountLooks.isUserInteractionEnabled = false
                                        
                                        let email = self.emailField.text
                                        let username = self.usernameField.text
                                        let age = Int(self.ageField.text!)
                                        
                                        guard let uid = user?.uid else {
                                            return
                                        }
                                        
                                        let date = Date()
                                        let dateFormat = DateFormatter()
                                        
                                        dateFormat.dateFormat = "dd.MM.yyyy"
                                        
                                        NSUbiquitousKeyValueStore.default.set(dateFormat.string(from: date), forKey: "joinDate")
                                        
                                        let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                                        let usersRef = ref.child("users").child(uid)
                                        let values = ["email": email as Any, "username": username as Any, "age": age as Any, "Highscore": 0, "tapedupStatus": "Amateur", "timesPlayed": 0, "timesPlayedAT": 0, "timesPlayedHS": 0, "timesPlayedTM": 0, "timesPlayedTRLM": 0, "totalPlayTime": 0, "totalTaps": 0, "joinDate": dateFormat.string(from: date)] as [String : Any]
                                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                                        
                                        let usernamesRef = ref.child("usernamesTaken")
                                        let value = ["\(String(describing: username!))": "\(uid)"]
                                        usernamesRef.updateChildValues(value)
                                        
                                        AccountViewController.usernameForRef = username!
                                        
                                        let defaultImage = UIImage(named: "anonymousTapper")
                                        
                                        
                                        let imageData = UIImageJPEGRepresentation(defaultImage!, 1.0)
                                        NSUbiquitousKeyValueStore.default.set(imageData, forKey: "userAvatar")
                                        
                                        let storageRef = Storage.storage().reference().child("\(uid)")
                                        
                                        if let uploadData = UIImagePNGRepresentation(defaultImage!) {
                                            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                                                
                                                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                                                    
                                                    let user = Auth.auth().currentUser
                                                    
                                                    guard let uid = user?.uid else {
                                                        return
                                                    }
                                                    
                                                    let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                                                    let usersRef = ref.child("users").child(uid)
                                                    let values = ["profileImageUrl": profileImageUrl]
                                                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                                                    
                                                }
                                                
                                            })
                                            
                                        }
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
                                            ivc.modalPresentationStyle = .custom
                                            ivc.modalTransitionStyle = .crossDissolve
                                            //        self.present(ivc, animated: true, completion: { _ in })
                                            self.present(ivc, animated: true, completion: nil)
                                        }
                                    } else {
                                        
                                        self.view.endEditing(true)
                                        
                                        
                                        self.animateIn()
                                        if let unwrappedError = error {
                                            self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                                        }
                                    }
                                }
                            } else {
                                self.view.endEditing(true)
                                
                                self.animateIn()
                                
                                self.errorDescription.text = "Please fill in a value of 1-100 for age."
                            }
                        }
                    }, withCancel: { (error) in
                        self.view.endEditing(true)
                        
                        self.animateIn()
                        self.errorDescription.text = "\(error.localizedDescription)"
                    })
                } else {
                    self.view.endEditing(true)
                    
                    self.animateIn()
                    
                    self.errorDescription.text = "Please input only numbers for your age"
                }
            } else {
                self.view.endEditing(true)
                
                self.animateIn()
                
                self.errorDescription.text = "'.', '#', '$', '[' or ']' are not allowed in your username"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Access Tapedup World"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 1
        errorView.layer.shadowOffset = CGSize.zero
        errorView.layer.shadowRadius = 10
        errorView.layer.shadowPath = UIBezierPath(rect: errorView.bounds).cgPath
        errorView.layer.cornerRadius = 10.0
        errorView.clipsToBounds = true
        createAccountLooks.layer.cornerRadius = 10.0
        createAccountLooks.clipsToBounds = true
        loginLooks.layer.cornerRadius = 10.0
        loginLooks.clipsToBounds = true
        resetPasswordLooks.layer.cornerRadius = 10.0
        resetPasswordLooks.clipsToBounds = true
        okButton.layer.cornerRadius = 10.0
        okButton.clipsToBounds = true
        
        self.createAccountLooks.isUserInteractionEnabled = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        emailField.addGestureRecognizer(tap)
        passwordField.addGestureRecognizer(tap)
        ageField.addGestureRecognizer(tap)
        usernameField.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    func animateIn() {
        self.view.addSubview(errorView)
        errorView.center = self.view.center
        
        errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        errorView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.errorView.alpha = 1
            self.errorView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.errorView.alpha = 0

        }) { (success: Bool) in
            self.errorView.removeFromSuperview()
        }
    }

    @IBAction func okAction(_ sender: Any) {
        animateOut()
    }
    
    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "loginVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "loginVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func goToResetPsw(_ sender: Any) {
        
        ResetPasswordViewController.sourceVC = "createAccount"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "resetVC")
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
