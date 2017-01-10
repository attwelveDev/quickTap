//
//  TutorialPageViewController.swift
//  Tap
//
//  Created by Aaron Nguyen on 27/12/16.
//  Copyright © 2016 Aaron Nguyen. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerArray: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let welcomePage = storyboard.instantiateViewController(withIdentifier: "welcomePage")
        let page1 = storyboard.instantiateViewController(withIdentifier: "firstPage")
        let page2 = storyboard.instantiateViewController(withIdentifier: "secondPage")
        let page3 = storyboard.instantiateViewController(withIdentifier: "thirdPage")
        let pageTMP = storyboard.instantiateViewController(withIdentifier: "trlModePage")
        let page4 = storyboard.instantiateViewController(withIdentifier: "fourthPage")
        let page5 = storyboard.instantiateViewController(withIdentifier: "fifthPage")
        let page6 = storyboard.instantiateViewController(withIdentifier: "lastPage")
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTimeLaunched") == nil {
            defaults.set("No", forKey:"isFirstTimeLaunched")
            defaults.synchronize()
            
            self.barBTN?.title = "Skip"
            self.barBTN.image = nil
            
            return [welcomePage, page1, page2, page3, pageTMP, page4, page5, page6]
            
        } else {
            
            self.barBTN.image = UIImage(named: "Back")
            
            return [page1, page2, page3, pageTMP, page4, page5, page6]
            
        }
        
    }()
    
    @IBOutlet weak var barBTN: UIBarButtonItem!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        self.navigationItem.title = "Instructions"
        navigationController?.navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 93.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 230.0/255.0, green: 224.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if let firstViewController = viewControllerArray.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "Start")
        ivc.modalPresentationStyle = .custom
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: { _ in })
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.index(of: viewController) else {return nil}
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerArray.count > previousIndex else {return nil}
        
        return viewControllerArray[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.index(of: viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        
        guard viewControllerArray.count != nextIndex else {return nil}
        
        guard viewControllerArray.count > nextIndex else {return nil}
        
        return viewControllerArray[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
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
