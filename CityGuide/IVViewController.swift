//
//  IVViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 28/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class IVViewController: UIViewController {
    
    @IBOutlet weak var selectionContainer: UIView!
    @IBOutlet weak var poweredLabel: UILabel!
    @IBOutlet weak var pokemonName: UILabel!

    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var cpTextFiels: UITextField!
    @IBOutlet weak var stardustTextField: UITextField!
    @IBOutlet weak var poweredSwitchView: UIView!
    @IBOutlet weak var attackDefenseIv: UILabel!
    @IBOutlet weak var staminaIv: UILabel!
    @IBOutlet weak var battleRatingPerCent: UILabel!
    @IBOutlet weak var cpRatingPerCent: UILabel!
    @IBOutlet weak var hpPerCent: UILabel!
    @IBOutlet weak var buttonPressed: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let mySwitch = SevenSwitch()
    var powered: Bool = false
    var selectedPokemon = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwitch()
        self.buttonPressed.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initSwitch() {
        mySwitch.addTarget(self, action: #selector(IVViewController.switchChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        mySwitch.offImage = UIImage(named: "cross.png")
        mySwitch.onImage = UIImage(named: "check.png")
        mySwitch.thumbImage = UIImage(named: "thumb.png")
        mySwitch.offLabel.text = ""
        mySwitch.onLabel.text = ""
        mySwitch.thumbTintColor = UIColor(red: 0.19, green: 0.23, blue: 0.33, alpha: 1)
        mySwitch.activeColor =  UIColor(red: 0.07, green: 0.09, blue: 0.11, alpha: 1)
        mySwitch.inactiveColor =  UIColor(red: 0.07, green: 0.09, blue: 0.11, alpha: 1)
        mySwitch.onTintColor =  UIColor(red: 0.45, green: 0.58, blue: 0.67, alpha: 1)
        mySwitch.borderColor = UIColor.clearColor()
        mySwitch.shadowColor = UIColor.blackColor()
        
        mySwitch.frame = poweredSwitchView.bounds
        mySwitch.isRounded = false
        poweredSwitchView.addSubview(mySwitch)
    }
    
    func switchChanged(sender: SevenSwitch) {
        if powered {
            powered = false
        } else {
            powered = true
        }
        print(powered)
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        self.selectionContainer.hidden = false
        self.addButton.hidden = true
    }
    @IBAction func addPressed(sender: AnyObject) {
        self.selectionContainer.hidden = false
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
