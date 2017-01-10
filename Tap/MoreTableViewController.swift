//
//  MoreViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 14/11/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class MoreTableViewController: UITableViewController, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet var mailErrorView: UIView!
    @IBOutlet weak var dismissBTN: UIButton!
    
    @IBOutlet var versionView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var dismissLabel: UIButton!
    @IBOutlet var tableContent: UITableView!
    let version = [
        ("Version and Build")
    ]
    
    let share = [
        ("Rate & Review"),
        ("Share via Mail")
    ]
    
    let about = [
        ("QuickTap Site"),
        ("Privacy Policy"),
        ("More from the Developer"),
        ("About")
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return version.count
        } else if section == 1 {
            return share.count
        } else {
            return about.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        if indexPath.section == 0 {
            let (versionName) = version[indexPath.row]
            cell.textLabel?.text = versionName
        } else if indexPath.section == 1 {
            let (shareName) = share[indexPath.row]
            cell.textLabel?.text = shareName
        } else if indexPath.section == 2 {
            let (aboutName) = about[indexPath.row]
            cell.textLabel?.text = aboutName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Version and Build"
        } else if section == 1 {
            return "Share"
        } else {
            return "About"
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            animateIn()
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            
            if let url = URL(string: "https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 1 && indexPath.row == 1) {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 0) {
            
            if let url = URL(string: "https://sites.google.com/view/attwelve") {
                let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
                present(vc, animated: true)
                
                if #available(iOS 10.0, *) {
                    vc.preferredBarTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                    vc.preferredControlTintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                } else {
                    // Fallback on earlier versions
                }
                
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 1) {
            
            if let url = URL(string: "https://sites.google.com/view/attwelve/privacy-policy") {
                let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
                present(vc, animated: true)
                
                if #available(iOS 10.0, *) {
                    vc.preferredBarTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
                    vc.preferredControlTintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                } else {
                    // Fallback on earlier versions
                }
                
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 2) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "fromDeveloper")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
            
            tableView.deselectRow(at: indexPath, animated: true)
        } else if (indexPath.section == 2 && indexPath.row == 3) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "about")
            ivc.modalPresentationStyle = .custom
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
            
            tableView.deselectRow(at: indexPath, animated: true)
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
        mailComposerVC.setSubject("Download QuickTap!")
        mailComposerVC.setMessageBody("Hello! I love QuickTap and I think you should check it out! QuickTap is all about tapping quickly, hence the name. With two modes in Singleplayer, 'Time Mode' and 'Highscore Mode' along side AcrossTable Mode and Territorial Mode. You'll always be engaged because of the huge range of choices. Download here: https://itunes.apple.com/us/app/quicktap/id1190851546?mt=8", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func showSendMailErrorAlert() {
        animateIn2()
    }
    
    @IBAction func dismissError(_ sender: Any) {
        animateOut2()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        animateOut()
    }
    
    var effect: UIVisualEffect!
    var visualEffectView: UIVisualEffectView!
    func animateIn() {
        self.view.addSubview(versionView)
        versionView.center = self.view.center
        
        versionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        versionView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView?.effect = self.effect
            self.versionView.alpha = 1
            self.versionView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.versionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.versionView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.versionView.removeFromSuperview()
        }
    }
    
    func animateIn2() {
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
    
    func animateOut2() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mailErrorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.mailErrorView.alpha = 0
            
            self.visualEffectView?.effect = nil
            
        }) { (success: Bool) in
            self.mailErrorView.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "More"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        tableContent.backgroundColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableContent.delegate = self
        tableContent.dataSource = self
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        versionLabel.layer.cornerRadius = 5.0
        versionLabel.clipsToBounds = true
        dismissLabel.layer.cornerRadius = 5.0
        dismissLabel.clipsToBounds = true
        versionView.layer.cornerRadius = 5.0
        versionView.clipsToBounds = true
        
        mailErrorView.layer.cornerRadius = 5.0
        mailErrorView.clipsToBounds = true
        dismissBTN.layer.cornerRadius = 5.0
        dismissBTN.clipsToBounds = true
    
        if (tableContent.contentSize.height < tableContent.frame.size.height) {
            tableContent.isScrollEnabled = false
        } else {
            tableContent.isScrollEnabled = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
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
