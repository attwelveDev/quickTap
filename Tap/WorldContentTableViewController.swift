//
//  WorldContentViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 26/12/17.
//  Copyright © 2017 Aaron Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SystemConfiguration

class Reachability {
    func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var me: UILabel!
    @IBOutlet weak var highscore: UILabel!

}

struct userInfo {
    let profilePic: UIImage!
    let username: String!
    let tapedupStatus: String!
    let highscore: String!
}

class WorldContentTableViewController: UITableViewController, UITextFieldDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    var userInfoArray = [userInfo]()
    var filteredUsers = [userInfo]()
    var searchController: UISearchController! = nil
    var shouldShowSearchResults = false
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        }
        searchController.searchBar.placeholder = "Search Players"
        searchController.searchBar.delegate = self
        searchController.searchBar.isUserInteractionEnabled = false
        if #available(iOS 11.0, *) {
            
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {

                if let backgroundView = textfield.subviews.first {

                    backgroundView.backgroundColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
                    
                    backgroundView.layer.cornerRadius = 10
                    backgroundView.clipsToBounds = true
                    
                }
            }

            self.navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            searchController.searchBar.sizeToFit()
            tableContent.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: 204.0/255.0, green: 150.0/255.0, blue: 117.0/255.0, alpha: 1.0)]
        searchController.searchBar.barTintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        searchController.searchBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        filteredUsers = userInfoArray.filter({(username) -> Bool in
            
            return username.username.lowercased().contains(searchString!.lowercased())
        })
        
        tableView.reloadData()
    }
    
    @IBOutlet var logOutView: UIView!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    @IBAction func dismissLoggingOut(_ sender: Any) {
        animateOutLogOut()
    }
    @IBAction func logOut(_ sender: Any) {
        do {
            
            try Auth.auth().signOut()
            
            animateIn()
            errorTitle.text = "Success"
            errorDescription.text = "Successfully signed out"
            okButton.isHidden = true
            
            self.tableContent.isUserInteractionEnabled = false
            
            goBackBtn.isEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
                ivc.modalPresentationStyle = .custom
                ivc.modalTransitionStyle = .crossDissolve
                //        self.present(ivc, animated: true, completion: { _ in })
                self.present(ivc, animated: true, completion: nil)
            }
            
        } catch let signOutError as NSError {
            animateIn()
            errorDescription.text = "\(signOutError)"
        }
    }
    
    @IBAction func showLogOutView(_ sender: Any) {
        animateInLogOut()
    }
    
    func animateInLogOut() {
        self.view.addSubview(logOutView)
        if #available(iOS 11.0, *) {
            logOutView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.searchController.searchBar.frame.height -  (self.navigationController?.navigationBar.frame.height)!)
        } else {
            logOutView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.navigationController?.navigationBar.frame.height)!)
        }
        
        logOutView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        logOutView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.logOutView.alpha = 1
            self.logOutView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOutLogOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.logOutView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.logOutView.alpha = 0
            
        }) { (success: Bool) in
            self.logOutView.removeFromSuperview()
        }
    }
    
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var signOutBtn: UIBarButtonItem!
    
    @IBOutlet var tableContent: UITableView!

    @IBOutlet weak var goBackBtn: UIBarButtonItem!
    
    @IBAction func okAction(_ sender: Any) {
        animateOut()
        
        WorldContentTableViewController.isViewOtherUsers = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
    }
    
    func animateIn() {
        self.view.addSubview(self.errorView)
        if #available(iOS 11.0, *) {
            errorView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.searchController.searchBar.frame.height -  (self.navigationController?.navigationBar.frame.height)!)
        } else {
            errorView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.navigationController?.navigationBar.frame.height)!)
        }
        
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
    
    let reachability = Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tapedup World"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        configureSearchController()
        
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 1
        errorView.layer.shadowOffset = CGSize.zero
        errorView.layer.shadowRadius = 10
        errorView.layer.shadowPath = UIBezierPath(rect: errorView.bounds).cgPath
        errorView.layer.cornerRadius = 10.0
        errorView.clipsToBounds = true
        okButton.layer.cornerRadius = 10.0
        okButton.clipsToBounds = true
        
        logOutView.layer.shadowColor = UIColor.black.cgColor
        logOutView.layer.shadowOpacity = 1
        logOutView.layer.shadowOffset = CGSize.zero
        logOutView.layer.shadowRadius = 10
        logOutView.layer.shadowPath = UIBezierPath(rect: logOutView.bounds).cgPath
        logOutView.layer.cornerRadius = 10.0
        logOutView.clipsToBounds = true
        dismissBtn.layer.cornerRadius = 10.0
        dismissBtn.clipsToBounds = true
        logOutBtn.layer.cornerRadius = 10.0
        logOutBtn.clipsToBounds = true
        
        goBackBtn.isEnabled = true
        signOutBtn.isEnabled = false
        
        tableContent.backgroundColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        
        tableContent.delegate = self
        tableContent.dataSource = self

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if (tableContent.contentSize.height < tableContent.frame.size.height) {
            tableContent.isScrollEnabled = false
        } else {
            tableContent.isScrollEnabled = true
        }

//        let connectedRef = Database.database().reference(withPath: ".info/connected")
//
//        connectedRef.observe(.value) { (connected) in
//            if let boolean = connected.value as? Bool, boolean == true {
        
        if reachability.isInternetAvailable() {
            
                Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                    if let value = snapshot.value as? NSDictionary {
                        
                        self.activityIndicator("Loading")
                        
                        let username = value["username"] as? String? ?? ""
                        let status = value["tapedupStatus"] as? String? ?? ""
                        let Highscore = value["Highscore"] as! Int?
                        let profileImageUrl = value["profileImageUrl"] as? String? ?? ""

                        if snapshot.hasChild("profileImageUrl") {

                            Storage.storage().reference(forURL: profileImageUrl!).downloadURL(completion: { (url, error) in
                                let session = URLSession(configuration: .default)
                                let getImageFromUrl = session.dataTask(with: url!) { (data, response, error) in
                                    
                                    if error != nil {
                                        self.effectView.removeFromSuperview()
                                        self.animateIn()
                                        if let unwrappedError = error {
                                            self.errorDescription.text = "\(unwrappedError.localizedDescription)"
                                        }
                                    } else {
                                        if response as? HTTPURLResponse != nil {
                                            if let imageData = data {
                                                
                                                if let image = UIImage(data: imageData) {
                                                    if let highscore = Highscore {
        //                                                if username != nil && status != nil && Highscore != nil && profileImageUrl != nil {
                                                            self.userInfoArray.insert(userInfo(profilePic: image, username: username, tapedupStatus: status, highscore: String(highscore)), at: 0)
                                                            DispatchQueue.main.async(execute: {
                                                                self.tableView.reloadData()
                                                                self.effectView.removeFromSuperview()
                                                                self.searchController.searchBar.isUserInteractionEnabled = true
                                                                
                                                            })
        //                                                } else {
        //                                                    self.animateIn()
        //                                                    self.errorDescription.text = "Couldn't retrieve user info"
        //                                                }
                                                    } else {
                                                        self.effectView.removeFromSuperview()
                                                        self.animateIn()
                                                        self.errorDescription.text = "Couldn't retrieve user info"
                                                    }
                                                } else {
                                                    self.effectView.removeFromSuperview()
                                                    self.animateIn()
                                                    self.errorDescription.text = "Couldn't retrieve user info"
                                                }
                                            } else {
                                                self.effectView.removeFromSuperview()
                                                self.animateIn()
                                                self.errorDescription.text = "Couldn't retrieve user info"
                                            }
                                        } else {
                                            self.effectView.removeFromSuperview()
                                            self.animateIn()
                                            self.errorDescription.text = "Couldn't retrieve user info"
                                        }
                                    }
                                }
                                
                                getImageFromUrl.resume()
                            })
                            
                        }
                    } else {
                        self.effectView.removeFromSuperview()
                        self.animateIn()
                        self.errorDescription.text = "Couldn't find user info"
                    }
                
                }, withCancel: { (error) in
                    self.effectView.removeFromSuperview()
                    self.animateIn()
                    self.errorDescription.text = "\(error.localizedDescription)"
                })
        } else {
            self.effectView.removeFromSuperview()
            self.animateIn()
            self.errorDescription.text = "Network error. Please try again later."
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        effectView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.searchController.searchBar.frame.height -  (self.navigationController?.navigationBar.frame.height)!)
        effectView.layer.cornerRadius = 10
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        self.view.addSubview(effectView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
        if shouldShowSearchResults {
            return filteredUsers.count
        } else {
            return userInfoArray.count
        }
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell

        if shouldShowSearchResults {
            
            let imageView = cell.profilePic
            imageView?.layer.cornerRadius = (imageView?.frame.size.width)! / 2
            imageView?.clipsToBounds = true
            imageView?.layer.borderWidth = 5.0
            imageView?.layer.borderColor = UIColor.white.cgColor
            imageView?.image = self.filteredUsers[indexPath.row].profilePic
            
            let label1 = cell.username
            label1?.text = self.filteredUsers[indexPath.row].username
            
            let label2 = cell.status
            label2?.text = self.filteredUsers[indexPath.row].tapedupStatus
            
            let label3 = cell.highscore
            label3?.text = self.filteredUsers[indexPath.row].highscore
            
        } else {
            
            let imageView = cell.profilePic
            imageView?.layer.cornerRadius = (imageView?.frame.size.width)! / 2
            imageView?.clipsToBounds = true
            imageView?.layer.borderWidth = 5.0
            imageView?.layer.borderColor = UIColor.white.cgColor
            imageView?.image = self.userInfoArray[indexPath.row].profilePic
            
            let label1 = cell.username
            label1?.text = self.userInfoArray[indexPath.row].username
            view.bringSubview(toFront: cell.username)
            
            let label2 = cell.status
            label2?.text = self.userInfoArray[indexPath.row].tapedupStatus
            view.bringSubview(toFront: cell.status)
            
            let label3 = cell.highscore
            label3?.text = self.userInfoArray[indexPath.row].highscore
            view.bringSubview(toFront: cell.highscore)
        }
        
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                
                self.signOutBtn.isEnabled = true
                
                let username = value["username"] as? String ?? ""
                NSUbiquitousKeyValueStore.default.set(username, forKey: "usernameDefault")
                
                AccountViewController.usernameForRef = username
                
                if cell.username.text == AccountViewController.usernameForRef {
                    cell.me.isHidden = false
                    cell.isUserInteractionEnabled = false
                    cell.selectionStyle = .none
                } else {
                    cell.me.isHidden = true
                    cell.isUserInteractionEnabled = true
                    cell.selectionStyle = .default
                }
            } else {
                let username = NSUbiquitousKeyValueStore.default.object(forKey: "usernameDefault")
                
                self.signOutBtn.isEnabled = true
                
                AccountViewController.usernameForRef = username as! String
                
                if cell.username.text == AccountViewController.usernameForRef {
                    cell.me.isHidden = false
                    cell.isUserInteractionEnabled = false
                    cell.selectionStyle = .none
                } else {
                    cell.me.isHidden = true
                    cell.isUserInteractionEnabled = true
                    cell.selectionStyle = .default
                }
            }
        }) { (error) in
            let username = NSUbiquitousKeyValueStore.default.object(forKey: "usernameDefault")
            
            self.signOutBtn.isEnabled = true
            
            AccountViewController.usernameForRef = username as! String
            
            if cell.username.text == AccountViewController.usernameForRef {
                cell.me.isHidden = false
                cell.isUserInteractionEnabled = false
                cell.selectionStyle = .none
            } else {
                cell.me.isHidden = true
                cell.isUserInteractionEnabled = true
                cell.selectionStyle = .default
            }
        }
    
        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    static var isViewOtherUsers = false
    static var nameOfUserViewing: String?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
        
        WorldContentTableViewController.nameOfUserViewing = selectedCell.username?.text
        
        WorldContentTableViewController.isViewOtherUsers = true
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        //        self.present(ivc, animated: true, completion: { _ in })
        self.present(ivc, animated: true, completion: nil)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        WorldContentTableViewController.isViewOtherUsers = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "accountVC")
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
