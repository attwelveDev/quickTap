//
//  SettingsTableViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 21/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {

    let hFeedback = [
        ("Feedback When Tapped")
    ]
    let circleTrails = [
        ("Circle Trails")
    ]
    let accountSettings = [
        ("Change Email"),
        ("Change Password"),
        ("Delete Account")
    ]
    
    @IBOutlet var tableContent: UITableView!
    
    @IBOutlet var deleteAccountView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet var changeEmlPswView: UIView!
    @IBOutlet weak var changeViewTitle: UILabel!
    @IBOutlet weak var cancelButton2: UIButton!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var fieldZero: UITextField!
    @IBOutlet weak var fieldOne: UITextField!
    @IBOutlet weak var fieldTwo: UITextField!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "More")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Settings"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        tableContent.backgroundColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        tableContent.delegate = self
        tableContent.dataSource = self
        
        if Auth.auth().currentUser != nil {
            
            let userID = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    
                    let username = value["username"] as? String ?? ""
                    NSUbiquitousKeyValueStore.default.set(username, forKey: "usernameDefault")
                    
                    AccountViewController.usernameForRef = username

                } else {
                    self.animateIn()
                    self.errorDescription.text = "Unknown error"
                    
                    let indexPath = IndexPath(row: 0, section: 2)
                    let cell = self.tableView.cellForRow(at: indexPath)
                    cell?.isUserInteractionEnabled = false
                    cell?.textLabel?.isEnabled = false
                    let indexPath1 = IndexPath(row: 1, section: 2)
                    let cell1 = self.tableView.cellForRow(at: indexPath1)
                    cell1?.isUserInteractionEnabled = false
                    cell1?.textLabel?.isEnabled = false
                    let indexPath2 = IndexPath(row: 2, section: 2)
                    let cell2 = self.tableView.cellForRow(at: indexPath2)
                    cell2?.isUserInteractionEnabled = false
                    cell2?.textLabel?.isEnabled = false

                }
            }) { (error) in

                self.animateIn()
                self.errorDescription.text = "Unknown error"
                
                let indexPath = IndexPath(row: 0, section: 2)
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.isUserInteractionEnabled = false
                cell?.textLabel?.isEnabled = false
                let indexPath1 = IndexPath(row: 1, section: 2)
                let cell1 = self.tableView.cellForRow(at: indexPath1)
                cell1?.isUserInteractionEnabled = false
                cell1?.textLabel?.isEnabled = false
                let indexPath2 = IndexPath(row: 2, section: 2)
                let cell2 = self.tableView.cellForRow(at: indexPath2)
                cell2?.isUserInteractionEnabled = false
                cell2?.textLabel?.isEnabled = false
 
            }
            
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if (tableContent.contentSize.height < tableContent.frame.size.height) {
            tableContent.isScrollEnabled = false
        } else {
            tableContent.isScrollEnabled = true
        }

        deleteAccountView.layer.shadowColor = UIColor.black.cgColor
        deleteAccountView.layer.shadowOpacity = 1
        deleteAccountView.layer.shadowOffset = CGSize.zero
        deleteAccountView.layer.shadowRadius = 10
        deleteAccountView.layer.shadowPath = UIBezierPath(rect: deleteAccountView.bounds).cgPath
        deleteAccountView.layer.cornerRadius = 10.0
        deleteAccountView.clipsToBounds = true
        cancelBtn.layer.cornerRadius = 10.0
        cancelBtn.clipsToBounds = true
        deleteBtn.layer.cornerRadius = 10.0
        deleteBtn.clipsToBounds = true
        
        changeEmlPswView.layer.shadowColor = UIColor.black.cgColor
        changeEmlPswView.layer.shadowOpacity = 1
        changeEmlPswView.layer.shadowOffset = CGSize.zero
        changeEmlPswView.layer.shadowRadius = 10
        changeEmlPswView.layer.shadowPath = UIBezierPath(rect: changeEmlPswView.bounds).cgPath
        changeEmlPswView.layer.cornerRadius = 10.0
        changeEmlPswView.clipsToBounds = true
        cancelButton2.layer.cornerRadius = 10.0
        cancelButton2.clipsToBounds = true
        changeBtn.layer.cornerRadius = 10.0
        changeBtn.clipsToBounds = true
        
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 1
        errorView.layer.shadowOffset = CGSize.zero
        errorView.layer.shadowRadius = 10
        errorView.layer.shadowPath = UIBezierPath(rect: errorView.bounds).cgPath
        errorView.layer.cornerRadius = 10.0
        errorView.clipsToBounds = true
        okBtn.layer.cornerRadius = 10.0
        okBtn.clipsToBounds = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        fieldZero.addGestureRecognizer(tap)
        fieldOne.addGestureRecognizer(tap)
        fieldTwo.addGestureRecognizer(tap)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    static var isHFeedbackEnabled = true
    static var isCircleTrailsEnabled = true
    
    @objc func switchTriggered(_ sender: UISwitch) {
        
        let hFeedback = sender
        
        if hFeedback.tag == 1 {
            
            if SettingsTableViewController.isHFeedbackEnabled == true {
                SettingsTableViewController.isHFeedbackEnabled = false
                UserDefaults.standard.set(hFeedbackSwitch.isOn, forKey: "hFeedbackState")
                
                print(SettingsTableViewController.isHFeedbackEnabled)
                
            } else if SettingsTableViewController.isHFeedbackEnabled == false {
                SettingsTableViewController.isHFeedbackEnabled = true
                UserDefaults.standard.set(hFeedbackSwitch.isOn, forKey: "hFeedbackState")
                print(SettingsTableViewController.isHFeedbackEnabled)
            }
        } else if hFeedback.tag == 2 {
            
            if SettingsTableViewController.isCircleTrailsEnabled == true {
                SettingsTableViewController.isCircleTrailsEnabled = false
                UserDefaults.standard.set(circleTrailsSwitch.isOn, forKey: "circleTrailsState")
                
                print(SettingsTableViewController.isCircleTrailsEnabled)
                
            } else if SettingsTableViewController.isCircleTrailsEnabled == false {
                SettingsTableViewController.isCircleTrailsEnabled = true
                UserDefaults.standard.set(circleTrailsSwitch.isOn, forKey: "circleTrailsState")
                
                print(SettingsTableViewController.isCircleTrailsEnabled)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return hFeedback.count
        } else if section == 1 {
            return circleTrails.count
        } else {
            return accountSettings.count
        }
    }

    let hFeedbackSwitch = UISwitch()
    let circleTrailsSwitch = UISwitch()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        if indexPath.section == 0 {
            let hFeedbackName = hFeedback[indexPath.row]
            cell.textLabel?.text = hFeedbackName
            cell.selectionStyle = .none
            cell.accessoryView = hFeedbackSwitch
            
            let hFeedbackCompatibleDevices = ["iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus" , "iPhone X"]
            let currentDeviceModel = UIDevice.current.modelName
            
            if hFeedbackCompatibleDevices.contains(currentDeviceModel) {
                // normal
            } else {
                cell.isUserInteractionEnabled = false
                cell.textLabel?.isEnabled = false
                hFeedbackSwitch.isEnabled = false
            }
            
        } else if indexPath.section == 1 {
            let circleTrailsName = circleTrails[indexPath.row]
            cell.textLabel?.text = circleTrailsName
            cell.selectionStyle = .none
            cell.accessoryView = circleTrailsSwitch
        } else {
            let accountSettingsName = accountSettings[indexPath.row]
            cell.textLabel?.text = accountSettingsName
            cell.selectionStyle = .default
            cell.accessoryView = nil
            
            if Auth.auth().currentUser == nil {
                cell.isUserInteractionEnabled = false
                cell.textLabel?.isEnabled = false
            }
        }
        
        hFeedbackSwitch.tag = 1
        hFeedbackSwitch.addTarget(self, action: #selector(SettingsTableViewController.switchTriggered(_:)), for: .valueChanged)
        hFeedbackSwitch.onTintColor = UIColor.lightText
        hFeedbackSwitch.thumbTintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        if UserDefaults.standard.object(forKey: "hFeedbackState") == nil {
            UserDefaults.standard.set(true, forKey: "hFeedbackState")
            hFeedbackSwitch.isOn = UserDefaults.standard.bool(forKey: "hFeedbackState")
        } else {
            hFeedbackSwitch.isOn = UserDefaults.standard.bool(forKey: "hFeedbackState")
        }
    
        
        circleTrailsSwitch.tag = 2
        circleTrailsSwitch.addTarget(self, action: #selector(SettingsTableViewController.switchTriggered(_:)), for: .valueChanged)
        circleTrailsSwitch.onTintColor = UIColor.lightText
        circleTrailsSwitch.thumbTintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        if UserDefaults.standard.object(forKey: "circleTrailsState") == nil {
            UserDefaults.standard.set(true, forKey: "circleTrailsState")
            circleTrailsSwitch.isOn = UserDefaults.standard.bool(forKey: "circleTrailsState")
        } else {
            circleTrailsSwitch.isOn = UserDefaults.standard.bool(forKey: "circleTrailsState")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Haptic Feedback"
        } else if section == 1 {
            return "Circle Trails"
        } else {
            return "Tapedup Account Settings"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "When on, a gentle vibration will accompany your taps in-game. This setting only applies to iPhone 7 and above."
        } else if section == 1 {
            return "When on, circles will trail above your finger's tapping location in-game. These trails will fade out."
        } else {
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        header.tintColor = UIColor(white: 1, alpha: 0)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        footer.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        footer.tintColor = UIColor(white: 1, alpha: 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {

            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 0) {
            animateOut()
            animateOutErrorView()
            animateInChangeView()
            
            changeType = "email"
            
            changeViewTitle.text = "Change Email"
            fieldZero.placeholder = "Current Email"
            fieldOne.placeholder = "Password"
            fieldTwo.placeholder = "New Email"
            
            fieldZero.text = nil
            fieldOne.text = nil
            fieldTwo.text = nil
            
            errorTitle.text = "Error"
            okBtn.isHidden = false
            
            if #available(iOS 10.0, *) {
                fieldTwo.textContentType = UITextContentType.emailAddress
                fieldTwo.isSecureTextEntry = false
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 1) {
            animateOut()
            animateOutErrorView()
            animateInChangeView()
            
            changeType = "password"
            
            changeViewTitle.text = "Change Password"
            fieldZero.placeholder = "Email"
            fieldOne.placeholder = "Current Password"
            fieldTwo.placeholder = "New Password"
            
            fieldZero.text = nil
            fieldOne.text = nil
            fieldTwo.text = nil
            
            errorTitle.text = "Error"
            okBtn.isHidden = false
            
            if #available(iOS 10.0, *) {
                if #available(iOS 11.0, *) {
                    fieldTwo.textContentType = UITextContentType.password
                }
                fieldTwo.isSecureTextEntry = true
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 2) {
            animateOutChangeView()
            animateOutErrorView()
            animateIn()
            
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    var changeType = ""
    
    @IBAction func okAction(_ sender: Any) {
        animateOutErrorView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        animateOut()
    }
    
    @IBAction func changeEmlPswAction(_ sender: Any) {
        if fieldZero.text?.isEmpty == true || fieldOne.text?.isEmpty == true || fieldTwo.text?.isEmpty == true {
                
            self.view.endEditing(true)
                
            animateInErrorView()
                
            errorDescription.text = "Please fill in all fields"
                
        } else {
        
            let credential = EmailAuthProvider.credential(withEmail: fieldZero.text!, password: fieldOne.text!)
                
            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
                if error == nil {
                    
                    if self.changeType == "email" {
                    
                        Auth.auth().currentUser?.updateEmail(to: self.fieldTwo.text!, completion: { (error) in
                            if error == nil {
                                let user = Auth.auth().currentUser
                                let email = self.fieldTwo.text
                                guard let uid = user?.uid else {
                                    return
                                }
                                let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                                let usersRef = ref.child("users").child(uid)
                                let values = ["email": email]
                                usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                                
                                self.view.endEditing(true)
                                
                                self.animateInErrorView()
                                self.errorTitle.text = "Success"
                                self.errorDescription.text = "Successfully changed email."
                                self.okBtn.isHidden = true
                                
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                    self.animateOutChangeView()
                                    self.animateOutErrorView()
                                }
                            } else {
                                self.view.endEditing(true)
                                
                                self.animateInErrorView()
                                if let unwrappedError = error {
                                    self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                                }
                            }
                        })
                        
                    } else {
                        Auth.auth().currentUser?.updatePassword(to: self.fieldTwo.text!, completion: { (error) in
                            if error == nil {
                                self.view.endEditing(true)
                                
                                self.animateInErrorView()
                                self.errorTitle.text = "Success"
                                self.errorDescription.text = "Successfully changed password."
                                self.okBtn.isHidden = true
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                    self.animateOutChangeView()
                                    self.animateOutErrorView()
                                }
                            } else {
                                self.view.endEditing(true)
                                
                                self.animateInErrorView()
                                if let unwrappedError = error {
                                    self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                                }
                            }
                        })
                    }
                } else {
                    self.view.endEditing(true)
                        
                    self.animateInErrorView()
                    if let unwrappedError = error {
                        self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                    }
                }
            })
            
        }
    }
    
    @IBAction func cancelActionChangeView(_ sender: Any) {
        animateOutChangeView()
        animateOutErrorView()
    }

    @IBAction func deleteAccountAction(_ sender: Any) {
        let user = Auth.auth().currentUser
        guard let uid = user?.uid else {
            return
        }
        
        Auth.auth().currentUser?.delete(completion: { (error) in
            
            if error == nil {

                let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                usersRef.removeValue(completionBlock: { (error, database) in
                    if error != nil {
                        self.animateInErrorView()
                        if let unwrappedError = error {
                            self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                        }
                    }
                })
                let usernamesRef = ref.child("usernamesTaken").child(AccountViewController.usernameForRef)
                usernamesRef.removeValue(completionBlock: { (error, database) in
                    if error != nil {
                        self.animateInErrorView()
                        if let unwrappedError = error {
                            self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                        }
                    }
                })
                
                let storageRef = Storage.storage().reference().child("\(uid)")
                storageRef.delete(completion: { (error) in
                    if error != nil {
                        self.animateInErrorView()
                        if let unwrappedError = error {
                            self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                        }
                    }
                })
                
                let indexPath = IndexPath(row: 0, section: 2)
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.isUserInteractionEnabled = false
                cell?.textLabel?.isEnabled = false
                let indexPath1 = IndexPath(row: 1, section: 2)
                let cell1 = self.tableView.cellForRow(at: indexPath1)
                cell1?.isUserInteractionEnabled = false
                cell1?.textLabel?.isEnabled = false
                let indexPath2 = IndexPath(row: 2, section: 2)
                let cell2 = self.tableView.cellForRow(at: indexPath2)
                cell2?.isUserInteractionEnabled = false
                cell2?.textLabel?.isEnabled = false
                
                self.animateInErrorView()
                self.errorTitle.text = "Success"
                self.errorDescription.text = "Successfully deleted account."
                self.okBtn.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.animateOut()
                    self.animateOutErrorView()
                }
                
            } else {
                self.animateInErrorView()
                if let unwrappedError = error {
                    self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                }
            }
        })
    }
    
    func animateIn() {
        self.view.addSubview(deleteAccountView)
        deleteAccountView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.navigationController?.navigationBar.frame.height)!)
        
        deleteAccountView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        deleteAccountView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.deleteAccountView.alpha = 1
            self.deleteAccountView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.deleteAccountView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.deleteAccountView.alpha = 0
            
        }) { (success: Bool) in
            self.deleteAccountView.removeFromSuperview()
        }
    }
    
    func animateInChangeView() {
        self.view.addSubview(changeEmlPswView)
        changeEmlPswView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.navigationController?.navigationBar.frame.height)!)
        
        changeEmlPswView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        changeEmlPswView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.changeEmlPswView.alpha = 1
            self.changeEmlPswView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutChangeView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeEmlPswView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.changeEmlPswView.alpha = 0
            
        }) { (success: Bool) in
            self.changeEmlPswView.removeFromSuperview()
        }
    }
    
    func animateInErrorView() {
        self.view.addSubview(errorView)
        errorView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.navigationController?.navigationBar.frame.height)!)
        
        errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        errorView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.errorView.alpha = 1
            self.errorView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutErrorView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.errorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.errorView.alpha = 0
            
        }) { (success: Bool) in
            self.errorView.removeFromSuperview()
        }
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
