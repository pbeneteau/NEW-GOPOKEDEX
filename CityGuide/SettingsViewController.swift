//
//  SettingsViewController.swift
//  Go Pokedex
//
//  Created by Paul Beneteau on 26/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var mailLink: UIButton!
    @IBOutlet weak var mailLinkLabel: UILabel!
    let email = "paulbeneteau@hotmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.tableView.allowsSelection = false
        
        self.mailLinkLabel.text = email
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mailPressed(sender: AnyObject) {
        let url = NSURL(string: "mailto:\(self.email)")
        UIApplication.sharedApplication().openURL(url!)
        
    }

}
