//
//  MoreFromDeveloperTableViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 27/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit
import StoreKit

class MoreFromDeveloperTableViewController: UITableViewController, SKStoreProductViewControllerDelegate {

    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet var tableContent: UITableView!
    let tempConv = [
        ("Get TempConv"),
        ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tempConv.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        if indexPath.section == 0 {
            let (versionName) = tempConv[indexPath.row]
            cell.textLabel?.text = versionName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "TempConv"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 213.0/255.0, green: 147.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        header.tintColor = UIColor(white: 1, alpha: 0)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "TempConv the only temperature converter ever to be found on the App Store that combines a sleek design, simplicity and a friendly user-experience together..."
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        footer.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        footer.tintColor = UIColor(white: 1, alpha: 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {
//
//            if let url = URL(string: "https://itunes.apple.com/us/app/tempconv/id1163432921?ls=1&mt=8") {
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    // Fallback on earlier versions
//                }
//            }
            
            activityIndicator("Loading")
            
            let storeVc = SKStoreProductViewController()
            storeVc.delegate = self
            
            let parameters = [SKStoreProductParameterITunesItemIdentifier: NSNumber(value: 1163432921)]
            
            storeVc.loadProduct(withParameters: parameters, completionBlock: { (result, error) in
                
                self.effectView.removeFromSuperview()
                
                if result {
                    self.present(storeVc, animated: true, completion: nil)
                } else {
                    if let unwrappedError = error {
                        self.animateInErrorView()
                        self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                    }
                }
            })
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 45))
        strLabel.text = title
        strLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        strLabel.textColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width / 2, y: view.frame.midY - strLabel.frame.height / 2 , width: 160, height: 45)
        effectView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.navigationController?.navigationBar.frame.height)!)
        effectView.layer.cornerRadius = 10
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        self.view.addSubview(effectView)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "More from the Developer"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        tableContent.backgroundColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableContent.delegate = self
        tableContent.dataSource = self
        
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 1
        errorView.layer.shadowOffset = CGSize.zero
        errorView.layer.shadowRadius = 10
        errorView.layer.shadowPath = UIBezierPath(rect: errorView.bounds).cgPath
        errorView.layer.cornerRadius = 10.0
        errorView.clipsToBounds = true
        okButton.layer.cornerRadius = 10.0
        okButton.clipsToBounds = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func dismissError(_ sender: Any) {
        animateOutErrorView()
    }
    
    @IBAction func goBack(_ sender: Any) {
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
