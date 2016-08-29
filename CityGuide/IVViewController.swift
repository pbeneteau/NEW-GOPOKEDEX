//
//  IVViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 28/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import QuartzCore


class IVViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
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
    var selectedPokemon = Pokemon(id: "", name: "")
    
    var pickerViewStardust = UIPickerView()
    var pickerViewLevel = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwitch()
        self.buttonPressed.hidden = true
        self.tableView.hidden = true
    }
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
        initPickerView(pickerViewStardust, textField: stardustTextField)
        pickerViewStardust.selectedRowInComponent(5)
        stardustTextField.inputView = pickerViewStardust
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
    
    func initPickerView(picker: UIPickerView, textField: UITextField) {
        picker.showsSelectionIndicator = true
        picker.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(IVViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    func donePicker() {
        self.view.endEditing(true)
    }
    
    func searchIV() {
        
    }
    
    func switchChanged(sender: SevenSwitch) {
        if powered {
            powered = false
            poweredLabel.layer.shadowColor = UIColor(red:0.60, green:0.58, blue:0.58, alpha:1.0).CGColor
            poweredLabel.layer.shadowRadius = 0
            poweredLabel.layer.shadowOpacity = 0
            poweredLabel.layer.masksToBounds = false
            poweredLabel.textColor = UIColor(red:0.60, green:0.58, blue:0.58, alpha:1.0)
        } else {
            poweredLabel.layer.shadowColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0).CGColor
            poweredLabel.layer.shadowRadius = 4.0
            poweredLabel.layer.shadowOpacity = 0.9
            poweredLabel.layer.shadowOffset = CGSizeZero
            poweredLabel.layer.masksToBounds = false
            poweredLabel.textColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
            powered = true
        }
        print(powered)
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        self.tableView.hidden = false
        print("pokemon Pressed")
    }
    @IBAction func addPressed(sender: AnyObject) {
        self.tableView.hidden = false
        print("add button pressed")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        (cell.viewWithTag(100) as! UIImageView).image = pokemonList[indexPath.row].img
        (cell.viewWithTag(101) as! UILabel).text = pokemonList[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !self.tableView.hidden {
            self.selectedPokemon = pokemonList[indexPath.row]
            self.buttonPressed.hidden = false
            self.addButton.hidden = true
            self.buttonPressed.setImage(pokemonList[indexPath.row].img, forState: .Normal)
            self.tableView.hidden = true
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stardustOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stardustOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stardustTextField.text = stardustOption[row]
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
