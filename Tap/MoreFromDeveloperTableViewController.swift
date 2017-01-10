//
//  MoreFromDeveloperTableViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 27/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

class MoreFromDeveloperTableViewController: UITableViewController {

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
            return "TempConv is the simplest temperature converter you will ever find on the App Store yet allows you to convert from Celsius, Fahrenheit and Kelvin with one swipe, no text-fields or complicated things so hard to explain..."
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
            
            if let url = URL(string: "https://itunes.apple.com/us/app/tempconv/id1163432921?ls=1&mt=8") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "More from the Developer"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        tableContent.backgroundColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableContent.delegate = self
        tableContent.dataSource = self
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "More")
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
