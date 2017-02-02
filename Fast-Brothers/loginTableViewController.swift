//
//  loginTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 01/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class loginTableViewController: UITableViewController {

    @IBOutlet var loginTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func loginFacebook(_ sender: Any) {
        let loggedPage = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        let loggedPageNav = UINavigationController (rootViewController: loggedPage)
        let appDelegate   = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loggedPageNav
    }
    
    @IBAction func login(_ sender: Any) {
        
        let loggedPage = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        let loggedPageNav = UINavigationController (rootViewController: loggedPage)
        let appDelegate   = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loggedPageNav
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

}
