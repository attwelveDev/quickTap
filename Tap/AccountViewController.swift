//
//  AccountViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 3/1/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import MessageUI

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let tableItems = ["Tapedup Status", "Highscore", "Total Taps", "Total Seconds Played", "Total Games Played"]
    var detailTableItems = ["\(UserDefaults.standard.string(forKey: "tapedupStatus")!)", "\(UserDefaults.standard.value(forKey: "Highscore")!)", "\(UserDefaults.standard.value(forKey: "totalTaps")!)", "\(UserDefaults.standard.value(forKey: "totalPlayTime")!) secs", "\(UserDefaults.standard.integer(forKey: "timesPlayed"))"]
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
                cell.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
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
            cell.selectionStyle = UITableViewCellSelectionStyle.default
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
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "status")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
            
        } else if (indexPath.section == 0 && indexPath.row == 1) {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "highscore")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
            
        } else if (indexPath.section == 0 && indexPath.row == 4) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "games")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
            
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return indexPath
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
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        UINavigationBar.appearance().barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        UINavigationBar.appearance().tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("My Tapedup Profile")
        mailComposerVC.setMessageBody("I am currently \(UserDefaults.standard.string(forKey: "tapedupStatus")!) Tapedup Status. My highscore is \(UserDefaults.standard.value(forKey: "Highscore")!) and I have tapped \(UserDefaults.standard.value(forKey: "totalTaps")!) times. I have played for \(UserDefaults.standard.value(forKey: "totalPlayTime")!) secs and played \(UserDefaults.standard.integer(forKey: "timesPlayed")) games. QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
        
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
        animateOutD()
        
    }
    
    @IBAction func dismissMailError(_ sender: Any) {
        animateOutME()
    }

    @IBOutlet var mailErrorView: UIView!
    
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
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
        animateOutD()
    }
    
    @IBAction func changeToDefault(_ sender: Any) {
        imageAvatar.image = UIImage(named: "anonymousTapper")
        animateOut()
        
        imageAvatar.transform = CGAffineTransform.identity
        
        let defaultImage = UIImage(named: "anonymousTapper")
        let imageData = UIImageJPEGRepresentation(defaultImage!, 1.0)
        UserDefaults.standard.set(imageData, forKey: "userAvatar")
        
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
        
        let imageData = UIImageJPEGRepresentation(newAvatar, 1.0)
        UserDefaults.standard.set(imageData, forKey: "userAvatar")
        
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
        animateOutD()
    }
    @IBAction func cancelUsernameEditing(_ sender: Any) {

        self.view.endEditing(true)
        
        animateOutUN()
    }
    @IBAction func changeUsername(_ sender: Any) {
        
        self.view.endEditing(true)
        
        animateOutUN()

        name.setTitle("\(usernameField.text!)", for: UIControlState.normal)
        
        let usernameDefault = UserDefaults.standard
        usernameDefault.setValue(usernameField.text!, forKey: "usernameDefault")
        usernameDefault.synchronize()
    }
    
    func dismissKeyboard() {
        
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
            self.changeUsernameView.removeFromSuperview()
        }
    }
    
    var whichFunction = 0
    
    let values = (1...100).map{$0}
    @IBOutlet var changeAgeView: UIView!
    @IBOutlet weak var pickAge: UIPickerView!
    @IBOutlet weak var cancelChangingAge: UIButton!
    @IBOutlet weak var changeAge: UIButton!
    @IBAction func startChangeAge(_ sender: Any) {
        
        whichFunction = 0
        
        let ageDefault = UserDefaults.standard
        if (ageDefault.value(forKey: "ageForRow") != nil){
            pickAge.selectRow((ageDefault.integer(forKey: "ageForRow") - 1), inComponent: 0, animated: false)
        }
        animateInA()
        animateOutCE()
        animateOut()
        animateOutUN()
        animateOutD()
    }
    @IBAction func cancelAction(_ sender: Any) {
        animateOutA()
    }
    @IBAction func changeAgeAction(_ sender: Any) {
        let row = pickAge.selectedRow(inComponent: 0)
        age.setTitle("\(values[row]) yo", for: UIControlState.normal)
        animateOutA()
        UserDefaults.standard.set(values[row], forKey: "ageForRow")
        
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
    
    var size = ""
    var deviceArray = ["iPod Touch 5G", "iPod Touch 6 Gen", "iPad Mini", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", "iPad 2", "iPad 3", "iPad 4", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inches", "iPad Pro 12.9 Inches", "iPhone 4s", "iPhone 5", "iPhone 5C", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 6s", "iPhone 6s Plus", "iPhone SE", "iPhone 7", "iPhone 7 Plus"]
    
    var threePointFiveInchesDevices = ["iPhone 4s"]
    var fourInchesDevices = ["iPhone 5", "iPhone 5C", "iPhone 5s", "iPhone SE", "iPod Touch 5G", "iPod Touch 6 Gen"]
    var fourPointSevenInchesDevices = ["iPhone 6", "iPhone 6s", "iPhone 7"]
    var fivePointFiveInchesDevices = ["iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus"]
    var sevenPointNineInchesDevices = ["iPad Mini", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4"]
    var ninePointSevenInchesDevices = ["iPad 2", "iPad 3", "iPad 4", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inches"]
    var twelvePointNineInchesDevices = ["iPad Pro 12.9 Inches"]
    
    @IBOutlet var changeDeviceView: UIView!
    @IBOutlet weak var pickDevice: UIPickerView!
    @IBOutlet weak var cancelPickingDevice: UIButton!
    @IBOutlet weak var changeDevice: UIButton!
    @IBAction func startChangeDevice(_ sender: Any) {
        
        whichFunction = 1
        
        let deviceDefault = UserDefaults.standard
        if (deviceDefault.value(forKey: "deviceForRow") != nil){
            pickDevice.selectRow(deviceDefault.integer(forKey: "deviceForRow"), inComponent: 0, animated: false)
        }
        
        animateInD()
        animateOutCE()
        animateOut()
        animateOutUN()
        animateOutA()
    }
    @IBAction func cancelChangingDevice(_ sender: Any) {
        animateOutD()
    }
    @IBAction func changeDeviceAction(_ sender: Any) {
        
        let row = pickDevice.selectedRow(inComponent: 0)
        
        if threePointFiveInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("3.5 Inch Device", for: UIControlState.normal)
        } else if fourInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("4 Inch Device", for: UIControlState.normal)
        } else if fourPointSevenInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("4.7 Inch Device", for: UIControlState.normal)
        } else if fivePointFiveInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("5.5 Inch Device", for: UIControlState.normal)
        } else if sevenPointNineInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("7.9 Inch Device", for: UIControlState.normal)
        } else if ninePointSevenInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("9.7 Inch Device", for: UIControlState.normal)
        } else if twelvePointNineInchesDevices.contains(deviceArray[row]) {
            screenSize.setTitle("12.9 Inch Device", for: UIControlState.normal)
        } else {
            print("No such device")
        }
        
        UserDefaults.standard.set(pickDevice.selectedRow(inComponent: 0), forKey: "deviceForRow")
        UserDefaults.standard.set(screenSize.currentTitle, forKey: "device")
        
        animateOutD()
    }
    
    func animateInD() {
        self.view.addSubview(changeDeviceView)
        changeDeviceView.center = self.view.center
        
        changeDeviceView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        changeDeviceView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.changeDeviceView.alpha = 1
            self.changeDeviceView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutD() {
        UIView.animate(withDuration: 0.5, animations: {
            self.changeDeviceView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.changeDeviceView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.changeDeviceView.removeFromSuperview()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if whichFunction == 0 {
            return values.count
        } else {
            return deviceArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if whichFunction == 0 {
            let ageValues = values[row]
            return "\(ageValues)"
        } else {
            return deviceArray[row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "My Tapedup Profile"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if let savedUserAvatar = UserDefaults.standard.object(forKey: "userAvatar") as? NSData {
            if let image = UIImage(data: savedUserAvatar as Data) {
                imageAvatar.image = image

            }
        }
        
        AccountViewController.defaultUsername = name.currentTitle!
        
        imageAvatar.layer.cornerRadius = self.imageAvatar.frame.size.width / 2
        imageAvatar.clipsToBounds = true
        
        imageAvatar.layer.borderWidth = 3.0
        imageAvatar.layer.borderColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        
        shareButton.layer.cornerRadius = 5.0
        shareButton.clipsToBounds = true
        
        changeImageView.layer.cornerRadius = 5.0
        changeImageView.clipsToBounds = true
        defaultBTN.layer.cornerRadius = 5.0
        defaultBTN.clipsToBounds = true
        cameraBTN.layer.cornerRadius = 5.0
        cameraBTN.clipsToBounds = true
        photoBTN.layer.cornerRadius = 5.0
        photoBTN.clipsToBounds = true
        cancelBTN.layer.cornerRadius = 5.0
        cancelBTN.clipsToBounds = true
        
        changeUsernameView.layer.cornerRadius = 5.0
        changeUsernameView.clipsToBounds = true
        cancelUsernameBTN.layer.cornerRadius = 5.0
        cancelUsernameBTN.clipsToBounds = true
        okBTN.layer.cornerRadius = 5.0
        okBTN.clipsToBounds = true
        
        let usernameDefault = UserDefaults.standard
        if (usernameDefault.value(forKey: "usernameDefault") != nil){
            name.setTitle("\(usernameDefault.value(forKey: "usernameDefault")!)", for: UIControlState.normal)
            usernameField.text = "\(usernameDefault.value(forKey: "usernameDefault")!)"
        }
        
        let ageDefault = UserDefaults.standard
        if (ageDefault.value(forKey: "ageForRow") != nil){
            age.setTitle("\(ageDefault.value(forKey: "ageForRow")!) yo", for: UIControlState.normal)
        }
        
        self.usernameField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        usernameField.addGestureRecognizer(tap)
        
        pickAge.dataSource = self
        pickAge.delegate = self
        pickAge.showsSelectionIndicator = false
        
        changeAgeView.layer.cornerRadius = 5.0
        changeAgeView.clipsToBounds = true
        cancelChangingAge.layer.cornerRadius = 5.0
        cancelChangingAge.clipsToBounds = true
        changeAge.layer.cornerRadius = 5.0
        changeAge.clipsToBounds = true
        
        pickDevice.dataSource = self
        pickDevice.delegate = self
        pickDevice.showsSelectionIndicator = false
        
        let deviceDefault = UserDefaults.standard
        if (deviceDefault.value(forKey: "device") != nil){
            
            screenSize.setTitle("\(deviceDefault.value(forKey: "device")!)", for: UIControlState.normal)
            
        }
        
        changeDeviceView.layer.cornerRadius = 5.0
        changeDeviceView.clipsToBounds = true
        cancelPickingDevice.layer.cornerRadius = 5.0
        cancelPickingDevice.clipsToBounds = true
        changeDevice.layer.cornerRadius = 5.0
        changeDevice.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.separatorColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        tableView.tableFooterView = UIView()
        
        if (tableView.contentSize.height < tableView.frame.size.height) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        
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
