//
//  SignInViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 26/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var titleErrorView: UILabel!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var loginLooks: UIButton!
    @IBOutlet weak var createAccountLooks: UIButton!
    @IBOutlet weak var resetPswLooks: UIButton!
    
    @IBAction func loginAction(_ sender: Any) {
        if emailField.text?.isEmpty == true || passwordField.text?.isEmpty == true {
            
            self.view.endEditing(true)
            
            animateIn()
            
            errorDescription.text = "Please fill in all fields"
            
        } else {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) {(user, error) in
                
                if error == nil {
                    
                    
                    self.view.endEditing(true)
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
                    ivc.modalPresentationStyle = .custom
                    ivc.modalTransitionStyle = .crossDissolve
                    //        self.present(ivc, animated: true, completion: { _ in })
                    self.present(ivc, animated: true, completion: nil)

                } else {
                    
                    self.view.endEditing(true)
                    
                    
                    self.animateIn()
                    if let unwrappedError = error {
                        self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                    }
                }
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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        emailField.addGestureRecognizer(tap)
        passwordField.addGestureRecognizer(tap)
        
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 1
        errorView.layer.shadowOffset = CGSize.zero
        errorView.layer.shadowRadius = 10
        errorView.layer.shadowPath = UIBezierPath(rect: errorView.bounds).cgPath
        errorView.layer.cornerRadius = 10.0
        errorView.clipsToBounds = true
        loginLooks.layer.cornerRadius = 10.0
        loginLooks.clipsToBounds = true
        createAccountLooks.layer.cornerRadius = 10.0
        createAccountLooks.clipsToBounds = true
        resetPswLooks.layer.cornerRadius = 10.0
        resetPswLooks.clipsToBounds = true
        okButton.layer.cornerRadius = 10.0
        okButton.clipsToBounds = true
        
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
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func goToCreateAccount(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "signUpVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func goToResetPsw(_ sender: Any) {
        
        ResetPasswordViewController.sourceVC = "login"
        
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
