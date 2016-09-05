//
//  AdvWeak.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 01/09/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class AdvWeak: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var attackContainer: UIView!
    @IBOutlet weak var defenseContainer: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func nextButtonPushed(sender: AnyObject) {
        self.defenseContainer.hidden = false
        self.attackContainer.hidden = true
        self.backButton.hidden = false
        self.nextButton.hidden = true
    }
    @IBAction func backButtonPushed(sender: AnyObject) {
        self.attackContainer.hidden = false
        self.defenseContainer.hidden = true
        self.nextButton.hidden = false
        self.backButton.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "attackStrongSegue" {
            (segue.destinationViewController as! AdvWeakTableViewController).pokemon = self.pokemon
        }
        if segue.identifier == "defenseStrongSegue" {
            (segue.destinationViewController as! AdvWeakDefenseTableViewController).pokemon = self.pokemon
        }
    }
}
