//
//  AccountViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 3/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
//import LocalAuthentication

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5th Generation"
        case "iPod7,1":                                 return "iPod Touch 6th Generation"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2nd Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

//    @IBOutlet weak var lockBTN: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var statsLbl: UILabel!
    @IBOutlet weak var dateJoinedLbl: UILabel!
    
    let tableItems = ["Tapedup Status", "Highscore", "Total Taps", "Total Seconds Played", "Total Games Played"]
    var detailTableItems = ["", "", "", "", "",]
    let cellIdentifier = "Cell"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        GameOverViewController.newLevel = false
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        
        
        if GameOverViewController.newLevel == true {
            if (indexPath.section == 0 && indexPath.row == 0) {
                cell.textLabel?.textColor = UIColor.green
                cell.detailTextLabel?.textColor = UIColor.green
            } else if (indexPath.section == 0 && indexPath.row == 1) {
                cell.textLabel?.textColor = UIColor(red: 204.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            } else if (indexPath.section == 0 && indexPath.row == 2) {
                cell.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            } else if (indexPath.section == 0 && indexPath.row == 3) {
                cell.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            } else if (indexPath.section == 0 && indexPath.row == 4) {
                cell.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                cell.detailTextLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            }
        } else {
            cell.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            cell.detailTextLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.detailTextLabel?.preferredMaxLayoutWidth = 50
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.minimumScaleFactor = 10
        
        cell.backgroundColor = UIColor.clear
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            if WorldContentTableViewController.isViewOtherUsers == false {
                cell.selectionStyle = UITableViewCellSelectionStyle.default
            } else {
                cell.selectionStyle = UITableViewCellSelectionStyle.none
            }
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            cell.selectionStyle = UITableViewCellSelectionStyle.default
        } else if (indexPath.section == 0 && indexPath.row == 2) {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        } else if (indexPath.section == 0 && indexPath.row == 3) {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        } else if (indexPath.section == 0 && indexPath.row == 4) {
            cell.selectionStyle = UITableViewCellSelectionStyle.default
        }
        
        let row = indexPath.row
        cell.textLabel?.text = tableItems[row]
        cell.detailTextLabel?.text = detailTableItems[row]

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            if WorldContentTableViewController.isViewOtherUsers == false {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "status")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            }
            
        } else if (indexPath.section == 0 && indexPath.row == 1) {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "highscore")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
            
        } else if (indexPath.section == 0 && indexPath.row == 4) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "games")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section == 0 && indexPath.row == 0) {
            if WorldContentTableViewController.isViewOtherUsers == false {
                return indexPath
            } else {
                return nil
            }
            
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            return indexPath
        } else if (indexPath.section == 0 && indexPath.row == 2) {
            return nil
        } else if (indexPath.section == 0 && indexPath.row == 3) {
            return nil
        } else {
            return indexPath
        }
    }

    static var defaultUsername = ""
    
    @IBOutlet weak var imageAvatar: UIImageView!

    @IBOutlet weak var name: UIButton!
    @IBOutlet weak var age: UIButton!
    @IBOutlet weak var screenSize: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func shareAction(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: {
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            })
        } else {
            self.showSendMailErrorAlert()
            errorTitle.text = "Cannot share"
            errorDescription.text = "Please check mail configuration and try again."
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        UINavigationBar.appearance().barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        UINavigationBar.appearance().tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("My Tapedup Profile")
        mailComposerVC.setMessageBody("I am currently \(NSUbiquitousKeyValueStore.default.string(forKey: "tapedupStatus")!) Tapedup Status. My highscore is \(NSUbiquitousKeyValueStore.default.object(forKey: "Highscore")!) and I have tapped \(NSUbiquitousKeyValueStore.default.object(forKey: "totalTaps")!) times. I have played for \(NSUbiquitousKeyValueStore.default.object(forKey: "totalPlayTime")!) secs and played \(NSUbiquitousKeyValueStore.default.double(forKey: "timesPlayed").cleanValue) games. \n\nQuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' sit along side Multiplayer's two modes: AcrossTable Mode and Territorial Mode. When you've become too tired, jump over to Tapedup World to check out other Tapedupers. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func showSendMailErrorAlert() {
        animateInME()
        animateOut()
        animateOutCE()
        animateOutUN()
        animateOutA()
//        animateOutTID()

        
    }
    
    @IBAction func dismissMailError(_ sender: Any) {
        animateOutME()
    }

    @IBOutlet var mailErrorView: UIView!
    @IBOutlet weak var errorOkBtn: UIButton!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorDescription: UILabel!
    
    func animateInME() {
        self.view.addSubview(mailErrorView)
        mailErrorView.center = self.view.center
        
        mailErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        mailErrorView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.mailErrorView.alpha = 1
            self.mailErrorView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutME() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mailErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.mailErrorView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.mailErrorView.removeFromSuperview()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        if WorldContentTableViewController.isViewOtherUsers == false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "worldContentVC")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var changeImageView: UIView!
    @IBOutlet var changeErrorView: UIView!
    @IBOutlet weak var noAccess: UILabel!
    @IBOutlet weak var dismissBTN: UIButton!
    @IBOutlet weak var defaultBTN: UIButton!
    @IBOutlet weak var cameraBTN: UIButton!
    @IBOutlet weak var photoBTN: UIButton!
    @IBOutlet weak var cancelBTN: UIButton!
    @IBAction func changeImageGesture(_ sender: Any) {
        animateIn()
        animateOutCE()
        animateOutUN()
        animateOutA()
//        animateOutTID()

    }
    
    @IBAction func changeToDefault(_ sender: Any) {
        imageAvatar.image = UIImage(named: "anonymousTapper")
        animateOut()
        
        imageAvatar.transform = CGAffineTransform.identity
        
        let defaultImage = UIImage(named: "anonymousTapper")
        let imageData = UIImageJPEGRepresentation(defaultImage!, 1.0)
        NSUbiquitousKeyValueStore.default.set(imageData, forKey: "userAvatar")
        
        let user = Auth.auth().currentUser
        
        guard let uid = user?.uid else {
            return
        }
        
        let storageRef = Storage.storage().reference().child("\(uid)")
        
        if let uploadData = UIImageJPEGRepresentation(defaultImage!, 1.0) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                    let usersRef = ref.child("users").child(uid)
                    let values = ["profileImageUrl": profileImageUrl]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                }
                
            })
            
        }
        
    }
    @IBAction func changeViaCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            animateOut()
            animateInCE()
            noAccess.text = "Cannot access Camera"
        }
    }
    @IBAction func changeViaPhotos(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            animateOut()
            animateInCE()
            noAccess.text = "Cannot access Photo Library"
        }
    }
    @IBAction func dismissView(_ sender: Any) {
        animateOut()
    }
    @IBAction func dismissError(_ sender: Any) {
        animateOutCE()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let newAvatar = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageAvatar.image = newAvatar
        picker.dismiss(animated: true, completion: nil)
        
        animateOut()
        
        imageAvatar.transform = CGAffineTransform.identity
        
        let imageData = UIImageJPEGRepresentation(newAvatar, 0.1)
        NSUbiquitousKeyValueStore.default.set(imageData, forKey: "userAvatar")
        
        let user = Auth.auth().currentUser
        
        guard let uid = user?.uid else {
            return
        }
        
        let storageRef = Storage.storage().reference().child("\(uid)")
        
        if let uploadData = UIImageJPEGRepresentation(newAvatar, 0.1) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                    let usersRef = ref.child("users").child(uid)
                    let values = ["profileImageUrl": profileImageUrl]
                    usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                    
                }
                
            })
            
        }
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
        animateOut()
    }
    
    var effect: UIVisualEffect!
    var visualEffectView: UIVisualEffectView!
    func animateIn() {
        self.view.addSubview(changeImageView)
        changeImageView.center = self.view.center
        
        changeImageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        changeImageView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.changeImageView.alpha = 1
            self.changeImageView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeImageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.changeImageView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.changeImageView.removeFromSuperview()
        }
    }
    func animateInCE() {
        self.view.addSubview(changeErrorView)
        changeErrorView.center = self.view.center
        
        changeErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        changeErrorView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.changeErrorView.alpha = 1
            self.changeErrorView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutCE() {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.changeErrorView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.changeErrorView.removeFromSuperview()
        }
    }
    @IBOutlet var changeUsernameView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var cancelUsernameBTN: UIButton!
    @IBOutlet weak var okBTN: UIButton!
    @IBAction func startChangeUsername(_ sender: Any) {
        animateInUN()
        animateOutCE()
        animateOut()
        animateOutA()
//        animateOutTID()

    }
    @IBAction func cancelUsernameEditing(_ sender: Any) {

        self.view.endEditing(true)
        
        animateOutUN()
    }
    
    static var usernameForRef = ""
    
    @objc func changed() {
        if usernameField.text == AccountViewController.usernameForRef {
            okBTN.isUserInteractionEnabled = false
            okBTN.isEnabled = false
        } else {
            okBTN.isUserInteractionEnabled = true
            okBTN.isEnabled = true
        }
    }
    
    @IBAction func changeUsername(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let charSet = CharacterSet(charactersIn: ".#$[]")
        if usernameField.text?.rangeOfCharacter(from: charSet) == nil {

            let usernamesRef = Database.database().reference().child("usernamesTaken")
            let usernameValue = self.usernameField.text
            usernamesRef.child(usernameValue!).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    self.view.endEditing(true)
                    
                    self.animateInME()
                    
                    self.errorTitle.text = "Error"
                    self.errorDescription.text = "This username is taken."
                } else {
                    self.view.endEditing(true)
                    
                    let user = Auth.auth().currentUser
                    
                    let username = self.usernameField.text
                    
                    guard let uid = user?.uid else {
                        return
                    }
                    
                    let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                    
                    var usernamesRef = ref.child("usernamesTaken").child(AccountViewController.usernameForRef)
                    usernamesRef.removeValue(completionBlock: { (error, reference) in
                        if error != nil {
                            self.animateInME()
                            
                            self.errorTitle.text = "Error"
                            self.errorDescription.text = "\(String(describing: error?.localizedDescription))"
                        } else {
                            
                            self.animateOutUN()
                            
                            self.name.setTitle("\(self.usernameField.text!)", for: UIControlState.normal)
                            
                            let usernameDefault = NSUbiquitousKeyValueStore.default
                            usernameDefault.set(self.usernameField.text!, forKey: "usernameDefault")
                            usernameDefault.synchronize()
                            
                            let usersRef = ref.child("users").child(uid)
                            let values = ["username": username]
                            usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                            
                            let value = ["\(String(describing: username!))": "\(uid)"]
                            usernamesRef = ref.child("usernamesTaken")
                            usernamesRef.updateChildValues(value)
                            
                            AccountViewController.usernameForRef = username!
                            
                        }
                    })
                    
                }
            }, withCancel: { (error) in
                self.view.endEditing(true)
                
                self.animateInME()
                
                self.errorTitle.text = "Error"
                self.errorDescription.text = "\(error.localizedDescription)"
            })
        } else {
            self.view.endEditing(true)
            
            self.animateInME()
            
            self.errorTitle.text = "Error"
            self.errorDescription.text = "'.', '#', '$', '[' or ']' are not allowed"
        }
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    func animateInUN() {
        self.view.addSubview(changeUsernameView)
        changeUsernameView.center = self.view.center
        
        changeUsernameView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        changeUsernameView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.changeUsernameView.alpha = 1
            self.changeUsernameView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutUN() {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeUsernameView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.changeUsernameView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.okBTN.isUserInteractionEnabled = false
            self.okBTN.isEnabled = false
            self.usernameField.text = AccountViewController.usernameForRef
            
            self.changeUsernameView.removeFromSuperview()
        }
    }
    
    let values = (1...100).map{$0}
    @IBOutlet var changeAgeView: UIView!
    @IBOutlet weak var pickAge: UIPickerView!
    @IBOutlet weak var cancelChangingAge: UIButton!
    @IBOutlet weak var changeAge: UIButton!
    @IBAction func startChangeAge(_ sender: Any) {
        
        animateInA()
        animateOutCE()
        animateOut()
        animateOutUN()
//        animateOutTID()
    }
    @IBAction func cancelAction(_ sender: Any) {
        animateOutA()
    }
    @IBAction func changeAgeAction(_ sender: Any) {
        let row = pickAge.selectedRow(inComponent: 0)
        age.setTitle("\(values[row]) yo", for: UIControlState.normal)
        animateOutA()
        NSUbiquitousKeyValueStore.default.set(values[row], forKey: "ageForRow")
        UserDefaults.standard.set(values[row], forKey: "ageForRow")
        
        let user = Auth.auth().currentUser
        
        let ageValue = values[row]
        
        guard let uid = user?.uid else {
            return
        }
        
        let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
        let usersRef = ref.child("users").child(uid)
        let value = ["age": ageValue]
        usersRef.updateChildValues(value as Any as! [AnyHashable : Any])
    }
    
    func animateInA() {
        self.view.addSubview(changeAgeView)
        changeAgeView.center = self.view.center
        
        changeAgeView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        changeAgeView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.changeAgeView.alpha = 1
            self.changeAgeView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutA() {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeAgeView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.changeAgeView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.changeAgeView.removeFromSuperview()
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return values.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            let ageValues = values[row]
            return "\(ageValues)"
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 295, height: 116))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 295, height: 116))
        let ageValues = values[row]
        label.text = "\(ageValues)"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(label)
        
        return view
        
    }
    
    // Authentication foundation for the future
    
//    @IBOutlet var EnableTouchIDView: UIView!
//    @IBOutlet weak var cancelEnabling: UIButton!
//    @IBOutlet weak var enableTouchID: UIButton!
//    @IBOutlet weak var errorTitle: UILabel!
//    @IBOutlet weak var errorAndStuffTID: UILabel!
//    @IBAction func dismissEnablingView(_ sender: Any) {
//        animateOutTID()
//    }
//    @IBAction func enableTouchIDAuth(_ sender: Any) {
//        if UserDefaults.standard.bool(forKey: "userHasTouchIDAuth") == true {
//
//            UserDefaults.standard.set(false, forKey: "userHasTouchIDAuth")
//            animateOutTID()
//        } else {
//            authenitcateUser()
//        }
//    }
//    @IBAction func startEnableTouchID(_ sender: Any) {
//        if UserDefaults.standard.bool(forKey: "userHasTouchIDAuth") == false {
//        animateInTID()
//        animateOutCE()
//        animateOut()
//        animateOutUN()
//        animateOutA()
//        } else {
//            animateInTID()
//            animateOutCE()
//            animateOut()
//            animateOutUN()
//            animateOutA()
//
//            errorTitle.text = "Disable Touch ID Authentication"
//            errorAndStuffTID.text = "Press 'OK', then input Touch ID"
//
//        }
//    }
//
//    func animateInTID() {
//        self.view.addSubview(EnableTouchIDView)
//        EnableTouchIDView.center = self.view.center
//
//        self.errorTitle.text = "Enable Touch ID Authentication"
//        self.errorAndStuffTID.text = "You must have a Touch ID fingerprint stored on your Touch ID compatible device to enable Touch ID authentication."
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
//                    [unowned self] success, authenticationError in
//                DispatchQueue.main.async {
//                    if success {
//                        self.animateOutTID()
//                        UserDefaults.standard.set(true, forKey: "userHasTouchIDAuth")
//
//                    } else {
//                        self.errorTitle.text = "Error"
//                        self.errorAndStuffTID.text = "Access to Tapedup Failed. Please try again."
//                    }
//                }
//            }
//
//        } else {
//            self.errorTitle.text = "Error"
//            self.errorAndStuffTID.text = "Your device is not compatible with Touch ID authentication"
//        }
//    }

    var shouldGoBackIfError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "My Tapedup Profile"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
//        if UserDefaults.standard.bool(forKey: "userHasTouchIDAuth") == true {
//
//        } else {
//            UserDefaults.standard.set(false, forKey: "userHasTouchIDAuth")
//        }
        
        if Auth.auth().currentUser != nil {
        
            if WorldContentTableViewController.isViewOtherUsers == false {
                let userID = Auth.auth().currentUser?.uid
                Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let value = snapshot.value as? NSDictionary {
                        
                        
                        let UD = UserDefaults.standard
                        
                        if let age = value["age"] as! Int? {
                            NSUbiquitousKeyValueStore.default.set(age, forKey: "ageForRow")
                            UD.set(age, forKey: "ageForRow")
                            
                            let ageDefault = NSUbiquitousKeyValueStore.default
                            let ageValue = UD.integer(forKey: "ageForRow")
                            if (ageDefault.object(forKey: "ageForRow") != nil){
                                self.pickAge.selectRow((UD.integer(forKey: "ageForRow") - 1), inComponent: 0, animated: false)
                                ageDefault.set(ageValue, forKey: "ageForRow")
                            }
                            
                            UIView.performWithoutAnimation {
                                self.age.setTitle("\(String(describing: age)) yo", for: .normal)
                                self.age.layoutIfNeeded()
                            }
                        }
                        
                        let profileImageUrl = value["profileImageUrl"] as? String? ?? ""
                        
                        if snapshot.hasChild("profileImageUrl") {
                        
                            Storage.storage().reference(forURL: profileImageUrl!).downloadURL(completion: { (url, error) in
                                
                                let session = URLSession(configuration: .default)
                                let getImageFromUrl = session.dataTask(with: url!) { (data, response, error) in

                                    if error != nil {
                                        if let savedUserAvatar = NSUbiquitousKeyValueStore.default.object(forKey: "userAvatar") as? NSData {
                                            if let image = UIImage(data: savedUserAvatar as Data) {
                                                DispatchQueue.main.async(execute: {
                                                    self.imageAvatar.image = image
                                                })
                                            }
                                        }
                                    } else {
                                        if response as? HTTPURLResponse != nil {
                                            if let imageData = data {
                                                
                                                DispatchQueue.main.async(execute: {
                                                    let image = UIImage(data: imageData)
                                                    self.imageAvatar.image = image
                                                })
                                                
                                            } else {
                                                if let savedUserAvatar = NSUbiquitousKeyValueStore.default.object(forKey: "userAvatar") as? NSData {
                                                    if let image = UIImage(data: savedUserAvatar as Data) {
                                                        self.imageAvatar.image = image
                                                    }
                                                }
                                            }
                                        } else {
                                            if let savedUserAvatar = NSUbiquitousKeyValueStore.default.object(forKey: "userAvatar") as? NSData {
                                                if let image = UIImage(data: savedUserAvatar as Data) {
                                                    DispatchQueue.main.async(execute: {
                                                        self.imageAvatar.image = image
                                                    })
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                getImageFromUrl.resume()
                                
                                
                            })
                        
                        } else {
                            let defaultImage = UIImage(named: "anonymousTapper")
                            let imageData = UIImageJPEGRepresentation(defaultImage!, 1.0)
                            NSUbiquitousKeyValueStore.default.set(imageData, forKey: "userAvatar")
                            
                            let user = Auth.auth().currentUser
                            
                            guard let uid = user?.uid else {
                                return
                            }
                            
                            let storageRef = Storage.storage().reference().child("\(uid)")
                            
                            if let uploadData = UIImageJPEGRepresentation(defaultImage!, 1.0) {
                                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                                    
                                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                                        
                                        let ref = Database.database().reference(fromURL: "https://quicktap-155512.firebaseio.com/")
                                        let usersRef = ref.child("users").child(uid)
                                        let values = ["profileImageUrl": profileImageUrl]
                                        usersRef.updateChildValues(values as Any as! [AnyHashable : Any])
                                        
                                    }
                                    
                                })
                                
                            }
                        }
                        
                        
                        let username = value["username"] as? String? ?? ""
                        NSUbiquitousKeyValueStore.default.set(username, forKey: "usernameDefault")
                        
                        let Highscore = value["Highscore"] as! Int?
                        NSUbiquitousKeyValueStore.default.set(Highscore as Any, forKey: "Highscore")
                        
                        let tapedupStatus = value["tapedupStatus"] as? String? ?? ""
                        NSUbiquitousKeyValueStore.default.set(tapedupStatus, forKey: "tapedupStatus")
                        
                        let timesPlayed = value["timesPlayed"] as! Int?
                        NSUbiquitousKeyValueStore.default.set(timesPlayed as Any, forKey: "timesPlayed")
                        
                        let totalPlayTime = value["totalPlayTime"] as! Int?
                        NSUbiquitousKeyValueStore.default.set(totalPlayTime as Any, forKey: "totalPlayTime")
                        
                        let totalTaps = value["totalTaps"] as! Int?
                        NSUbiquitousKeyValueStore.default.set(totalTaps as Any, forKey: "totalTaps")
                        
                        let joinDate = value["joinDate"] as? String? ?? ""
                        NSUbiquitousKeyValueStore.default.set(joinDate, forKey: "joinDate")
                        
                        UIView.performWithoutAnimation {
                            self.name.setTitle(username, for: .normal)
                            self.name.layoutIfNeeded()
                            
                        }
                        
                        if username != nil {
                            AccountViewController.usernameForRef = username!
                        }
                        
                        self.usernameField.text = username
                        self.dateJoinedLbl.text = joinDate
                        
                        if tapedupStatus != nil {
                            self.detailTableItems.insert(tapedupStatus!, at: 0)
                        } else {
                            self.detailTableItems.insert("", at: 0)
                        }
                        
                        if Highscore != nil {
                            self.detailTableItems.insert(String(describing: Highscore!), at: 1)
                        } else {
                            self.detailTableItems.insert("", at: 1)
                        }
                        
                        if totalTaps != nil {
                            self.detailTableItems.insert(String(describing: totalTaps!), at: 2)
                        } else {
                            self.detailTableItems.insert("", at: 2)
                        }
                        
                        if totalPlayTime != nil {
                            self.detailTableItems.insert("\(String(describing: totalPlayTime!)) secs", at: 3)
                        } else {
                            self.detailTableItems.insert("", at: 3)
                        }
                        
                        if timesPlayed != nil {
                            self.detailTableItems.insert(String(describing: timesPlayed!), at: 4)
                        } else {
                            self.detailTableItems.insert("", at: 4)
                        }

                        self.tableView.reloadData()
                        
                    } else {
                        let UD = UserDefaults.standard
                        let age = NSUbiquitousKeyValueStore.default.object(forKey: "ageForRow")
                        UD.set(age, forKey: "ageForRow")
                        
                        let ageDefault = NSUbiquitousKeyValueStore.default
                        let ageValue = UD.integer(forKey: "ageForRow")
                        if (ageDefault.object(forKey: "ageForRow") != nil){
                            self.pickAge.selectRow((UD.integer(forKey: "ageForRow") - 1), inComponent: 0, animated: false)
                            ageDefault.set(ageValue, forKey: "ageForRow")
                        }
                        
                        if let profilePicture = NSUbiquitousKeyValueStore.default.object(forKey: "userAvatar") as? NSData {
                            if let image = UIImage(data: profilePicture as Data) {
                                self.imageAvatar.image = image
                            }
                        }
                        let username = NSUbiquitousKeyValueStore.default.object(forKey: "usernameDefault")
                        let Highscore = NSUbiquitousKeyValueStore.default.object(forKey: "Highscore")
                        let tapedupStatus = NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")
                        let timesPlayed = NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayed")
                        let totalPlayTime = NSUbiquitousKeyValueStore.default.object(forKey: "totalPlayTime")
                        let totalTaps = NSUbiquitousKeyValueStore.default.object(forKey: "totalTaps")
                        
                        UIView.performWithoutAnimation {
                            self.name.setTitle(username as? String, for: .normal)
                            self.name.layoutIfNeeded()
                            
                            self.age.setTitle("\(String(describing: age!)) yo", for: .normal)
                            self.age.layoutIfNeeded()
                        }
                        self.usernameField.text = username as? String
                        AccountViewController.usernameForRef = username as! String
                        
                        self.detailTableItems = [tapedupStatus as! String, String(describing: Highscore!), String(describing: totalTaps!), "\(String(describing: totalPlayTime!)) secs", String(describing: timesPlayed!)]
                        
                        self.tableView.reloadData()
                    }
                }) { (error) in
                    let UD = UserDefaults.standard
                    let age = NSUbiquitousKeyValueStore.default.object(forKey: "ageForRow")
                    UD.set(age, forKey: "ageForRow")
                    
                    let ageDefault = NSUbiquitousKeyValueStore.default
                    let ageValue = UD.integer(forKey: "ageForRow")
                    if (ageDefault.object(forKey: "ageForRow") != nil){
                        self.pickAge.selectRow((UD.integer(forKey: "ageForRow") - 1), inComponent: 0, animated: false)
                        ageDefault.set(ageValue, forKey: "ageForRow")
                    }
                    
                    if let profilePicture = NSUbiquitousKeyValueStore.default.object(forKey: "userAvatar") as? NSData {
                        if let image = UIImage(data: profilePicture as Data) {
                            self.imageAvatar.image = image
                        }
                    }
                    let username = NSUbiquitousKeyValueStore.default.object(forKey: "usernameDefault")
                    let Highscore = NSUbiquitousKeyValueStore.default.object(forKey: "Highscore")
                    let tapedupStatus = NSUbiquitousKeyValueStore.default.object(forKey: "tapedupStatus")
                    let timesPlayed = NSUbiquitousKeyValueStore.default.object(forKey: "timesPlayed")
                    let totalPlayTime = NSUbiquitousKeyValueStore.default.object(forKey: "totalPlayTime")
                    let totalTaps = NSUbiquitousKeyValueStore.default.object(forKey: "totalTaps")
                    
                    UIView.performWithoutAnimation {
                        self.name.setTitle(username as? String, for: .normal)
                        self.name.layoutIfNeeded()
                        
                        self.age.setTitle("\(String(describing: age!)) yo", for: .normal)
                        self.age.layoutIfNeeded()
                    }
                    self.usernameField.text = username as? String
                    AccountViewController.usernameForRef = username as! String
                    
                    self.detailTableItems = [tapedupStatus as! String, String(describing: Highscore!), String(describing: totalTaps!), "\(String(describing: totalPlayTime!)) secs", String(describing: timesPlayed!)]
                    
                    self.tableView.reloadData()
                }
            } else {
                let usernamesRef = Database.database().reference().child("usernamesTaken")
                usernamesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        if let value = snapshot.value as? NSDictionary {

                            if WorldContentTableViewController.nameOfUserViewing != nil || WorldContentTableViewController.nameOfUserViewing?.isEmpty == false {
                                
                                Database.database().reference().child("users").child((value["\(String(describing: WorldContentTableViewController.nameOfUserViewing!))"] as? String? ?? "")!).observeSingleEvent(of: .value, with: { (snapshot) in
                                    if let value = snapshot.value as? NSDictionary {
                                        
                                        let profileImageUrl = value["profileImageUrl"] as? String? ?? ""
                                        
                                        if snapshot.hasChild("profileImageUrl") {
                                            
                                            Storage.storage().reference(forURL: profileImageUrl!).downloadURL(completion: { (url, error) in
                                                
                                                let session = URLSession(configuration: .default)
                                                let getImageFromUrl = session.dataTask(with: url!) { (data, response, error) in
                                                    
                                                    if error != nil {
                                                        print("error")
                                                    } else {
                                                        if response as? HTTPURLResponse != nil {
                                                            if let imageData = data {
                                                                
                                                                DispatchQueue.main.async(execute: {
                                                                    let image = UIImage(data: imageData)
                                                                    self.imageAvatar.image = image
                                                                })
                                                                
                                                            } else {
                                                                if let savedUserAvatar = NSUbiquitousKeyValueStore.default.object(forKey: "userAvatar") as? NSData {
                                                                    if let image = UIImage(data: savedUserAvatar as Data) {
                                                                        self.imageAvatar.image = image
                                                                    }
                                                                }
                                                            }
                                                        } else {
                                                            self.animateInME()
                                                            
                                                            self.errorTitle.text = "Error"
                                                            self.errorDescription.text = "Couldn't retrieve profile pic"
                                                        }
                                                    }
                                                }
                                                
                                                getImageFromUrl.resume()
                                                
                                                
                                            })
                                            
                                        }
                                        
                                        let username = value["username"] as? String? ?? ""

                                        let Highscore = value["Highscore"] as! Int?
               
                                        let tapedupStatus = value["tapedupStatus"] as? String? ?? ""
                      
                                        let timesPlayed = value["timesPlayed"] as! Int?
                                   
                                        let totalPlayTime = value["totalPlayTime"] as! Int?
                        
                                        let totalTaps = value["totalTaps"] as! Int?

                                        let joinDate = value["joinDate"] as? String? ?? ""
                                        
                                        UIView.performWithoutAnimation {
                                            self.name.setTitle(username, for: .normal)
                                            self.name.layoutIfNeeded()
                                        }
                                        self.usernameField.text = username
                                        self.dateJoinedLbl.text = joinDate
                                        
                                        self.age.isHidden = true
                                        self.screenSize.isHidden = true
                                        self.shareButton.isHidden = true
                                        self.viewOtherUsersBtn.isEnabled = false
                                        self.viewOtherUsersBtn.title = ""
                                        self.imageAvatar.isUserInteractionEnabled = false
                                        self.name.isUserInteractionEnabled = false
                                        
                                        if username != nil {
                                            self.statsLbl.text = "\(String(describing: username!))'s Stats"
                                            
                                            self.navigationItem.title = "\(String(describing: username!))'s Profile"
                                        }

                                        if tapedupStatus != nil {
                                            self.detailTableItems.insert(tapedupStatus!, at: 0)
                                        } else {
                                            self.detailTableItems.insert("", at: 0)
                                        }
                                        
                                        if Highscore != nil {
                                            self.detailTableItems.insert(String(describing: Highscore!), at: 1)
                                        } else {
                                            self.detailTableItems.insert("", at: 1)
                                        }
                                        
                                        if totalTaps != nil {
                                            self.detailTableItems.insert(String(describing: totalTaps!), at: 2)
                                        } else {
                                            self.detailTableItems.insert("", at: 2)
                                        }
                                        
                                        if totalPlayTime != nil {
                                            self.detailTableItems.insert("\(String(describing: totalPlayTime!)) secs", at: 3)
                                        } else {
                                            self.detailTableItems.insert("", at: 3)
                                        }
                                        
                                        if timesPlayed != nil {
                                            self.detailTableItems.insert(String(describing: timesPlayed!), at: 4)
                                        } else {
                                            self.detailTableItems.insert("", at: 4)
                                        }
                                        
                                        self.tableView.reloadData()
                                    } else {
                                        self.animateInME()
                                        
                                        self.errorTitle.text = "Error"
                                        self.errorDescription.text = "Couldn't find user"
                                    }
                                }, withCancel: { (error) in
                                    self.animateInME()
                                    
                                    self.errorTitle.text = "Error"
                                    self.errorDescription.text = "\(String(describing: error.localizedDescription))"
                                    
                                })

                            } else {
                                self.animateInME()
                                
                                self.errorTitle.text = "Error"
                                self.errorDescription.text = "Couldn't find user"
                            }
                        } else {
                            self.animateInME()
                            
                            self.errorTitle.text = "Error"
                            self.errorDescription.text = "Couldn't find user"
                        }
                    } else {
                        self.animateInME()
                        
                        self.errorTitle.text = "Error"
                        self.errorDescription.text = "Couldn't find user"
                    }
                }, withCancel: { (error) in
                    self.animateInME()
                    
                    self.errorTitle.text = "Error"
                    self.errorDescription.text = "\(String(describing: error.localizedDescription))"
                })
            }
        }
        AccountViewController.defaultUsername = name.currentTitle!
        
        okBTN.isUserInteractionEnabled = false
        okBTN.isEnabled = false
        usernameField.addTarget(self, action: #selector(AccountViewController.changed), for: UIControlEvents.editingChanged)
        
        imageAvatar.layer.cornerRadius = self.imageAvatar.frame.size.width / 2
        imageAvatar.clipsToBounds = true
        
        imageAvatar.layer.borderWidth = 5.0
        imageAvatar.layer.borderColor = UIColor(red: 204.0/255.0, green: 150.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        
        shareButton.layer.cornerRadius = 10.0
        shareButton.clipsToBounds = true
        
        changeImageView.layer.shadowColor = UIColor.black.cgColor
        changeImageView.layer.shadowOpacity = 1
        changeImageView.layer.shadowOffset = CGSize.zero
        changeImageView.layer.shadowRadius = 10
        changeImageView.layer.shadowPath = UIBezierPath(rect: changeImageView.bounds).cgPath
        changeImageView.layer.cornerRadius = 10.0
        changeImageView.clipsToBounds = true
        defaultBTN.layer.cornerRadius = 10.0
        defaultBTN.clipsToBounds = true
        cameraBTN.layer.cornerRadius = 10.0
        cameraBTN.clipsToBounds = true
        photoBTN.layer.cornerRadius = 10.0
        photoBTN.clipsToBounds = true
        cancelBTN.layer.cornerRadius = 10.0
        cancelBTN.clipsToBounds = true
        
        changeUsernameView.layer.shadowColor = UIColor.black.cgColor
        changeUsernameView.layer.shadowOpacity = 1
        changeUsernameView.layer.shadowOffset = CGSize.zero
        changeUsernameView.layer.shadowRadius = 10
        changeUsernameView.layer.shadowPath = UIBezierPath(rect: changeUsernameView.bounds).cgPath
        changeUsernameView.layer.cornerRadius = 10.0
        changeUsernameView.clipsToBounds = true
        cancelUsernameBTN.layer.cornerRadius = 10.0
        cancelUsernameBTN.clipsToBounds = true
        okBTN.layer.cornerRadius = 10.0
        okBTN.clipsToBounds = true
        
        mailErrorView.layer.shadowColor = UIColor.black.cgColor
        mailErrorView.layer.shadowOpacity = 1
        mailErrorView.layer.shadowOffset = CGSize.zero
        mailErrorView.layer.shadowRadius = 10
        mailErrorView.layer.shadowPath = UIBezierPath(rect: mailErrorView.bounds).cgPath
        mailErrorView.layer.cornerRadius = 10.0
        mailErrorView.clipsToBounds = true
        errorOkBtn.layer.cornerRadius = 10.0
        errorOkBtn.clipsToBounds = true
        
        changeErrorView.layer.shadowColor = UIColor.black.cgColor
        changeErrorView.layer.shadowOpacity = 1
        changeErrorView.layer.shadowOffset = CGSize.zero
        changeErrorView.layer.shadowRadius = 10
        changeErrorView.layer.shadowPath = UIBezierPath(rect: changeErrorView.bounds).cgPath
        changeErrorView.layer.cornerRadius = 10.0
        changeErrorView.clipsToBounds = true
        dismissBTN.layer.cornerRadius = 10.0
        dismissBTN.clipsToBounds = true
        
        self.usernameField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        usernameField.addGestureRecognizer(tap)
        
        pickAge.dataSource = self
        pickAge.delegate = self

        changeAgeView.layer.shadowColor = UIColor.black.cgColor
        changeAgeView.layer.shadowOpacity = 1
        changeAgeView.layer.shadowOffset = CGSize.zero
        changeAgeView.layer.shadowRadius = 10
        changeAgeView.layer.shadowPath = UIBezierPath(rect: changeAgeView.bounds).cgPath
        changeAgeView.layer.cornerRadius = 10.0
        changeAgeView.clipsToBounds = true
        cancelChangingAge.layer.cornerRadius = 10.0
        cancelChangingAge.clipsToBounds = true
        changeAge.layer.cornerRadius = 10.0
        changeAge.clipsToBounds = true
        
        screenSize.setTitle("\(UIDevice.current.modelName)", for: UIControlState.normal)

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.separatorColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        tableView.tableFooterView = UIView()
        
        if (tableView.contentSize.height < tableView.frame.size.height) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        
//        let image = lockBTN.image
//        let tintedImage = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//        lockBTN.image = tintedImage
//        lockBTN.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
//        EnableTouchIDView.layer.cornerRadius = 10.0
//        EnableTouchIDView.clipsToBounds = false
//        cancelEnabling.layer.cornerRadius = 10.0
//        cancelEnabling.clipsToBounds = false
//        enableTouchID.layer.cornerRadius = 10.0
//        enableTouchID.clipsToBounds = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        for subview in pickAge.subviews{
            if subview.frame.origin.y != 0 {
                subview.isHidden = true
            }
        }
        
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOpacity = 1
        background.layer.shadowOffset = CGSize.zero
        background.layer.shadowRadius = 10
        background.layer.shadowPath = UIBezierPath(rect: background.bounds).cgPath
    }
    @IBOutlet weak var viewOtherUsersBtn: UIBarButtonItem!
    @IBAction func goToCreateAccount(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "worldContentVC")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "signUpVC")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            //        self.present(ivc, animated: true, completion: { _ in })
            self.present(ivc, animated: true, completion: nil)
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
