//
//  IVViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 28/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit
import QuartzCore


class IVViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, hpModalViewProtocol, cpModalViewProtocol {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var pokemonImage: UIButton!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var stardustLabel: UILabel!
    @IBOutlet weak var cpLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    @IBOutlet weak var resultsMainView: UIView!
    @IBOutlet weak var noCombinaisonLabel2: UILabel!
    @IBOutlet weak var noCombinaisonLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var poweredLabel: UILabel!

    @IBOutlet weak var poweredSwitchView: UIView!
    @IBOutlet weak var attackDefenseIv: UILabel!
    @IBOutlet weak var staminaIv: UILabel!
    @IBOutlet weak var battleRatingPerCent: UILabel!
    @IBOutlet weak var cpRatingPerCent: UILabel!
    @IBOutlet weak var hpPerCent: UILabel!
    var booooooooooooo = 1
    var hetal = 4
    //ddfdfdgdfdfds
    gevisvsvsdvdx
    
    let mySwitch = SevenSwitch()
    var powered: Bool = false
    var selectedPokemon = Pokemon(id: "", name: "")
    
    var pickerViewStardust = UIPickerView()
    var pickerViewLevel = UIPickerView()
    
    var levels = [String]()
    var IV: [String:[Double]]! = nil
    var hp: Int!
    var cp: Int!
    var stardust:Int!
    var level: String!
    
    var hpOK: Bool! = false
    var cpOK: Bool! = false
    var stardustOK: Bool! = false
    var levelOK: Bool! = false
    var levelCanBePressed = false
    
    // Initials
    var startForStardust = 5
    var starterForHp = 53
    var starterForCp = 504
    var starterForLevel: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwitch()
        //self.tableView.hidden = true
    }
    override func viewDidAppear(animated: Bool) {
        selectedPokemon = pokemonList[3]
        //self.tableView.reloadData()
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

//    
//    func findLevel() {
//        if (stardustTextField.text != nil) {
//            levels = findLevels(Int(stardustTextField.text!)!, powered: powered)
//        }
//    }
//    
//    func allStatsEntered()->Bool {
//        if (cpTextFiels.text != nil) {
//            if (hpTextField.text != nil) {
//                if (levelTextView.text != nil) {
//                    return true
//                }
//            }
//        }
//        return false
//    }
//    
//    func getAllIV() {
//        if (cpTextFiels.text != nil) {
//            if (hpTextField.text != nil) {
//                if (levelTextView.text != nil) {
//                    IV = getIV(selectedPokemon, cp: Int(cpTextFiels.text!)!, hp: Int(hpTextField.text!)!, stardust: Int(stardustTextField.text!)!, powered: powered)
//                }
//            }
//        }
//    }
//    
//    
//    func reloadIV() {
//        if (IV != nil) {
//            if IV[levelTextView.text!]![0] != 1111.11111 {
//                let stamina = Double(IV[levelTextView.text!]![0])/15.0
//                let attackDefense = Double(IV[levelTextView.text!]![1])/30.0
//                attackDefenseIv.text = "\(IV[levelTextView.text!]![1])"
//                staminaIv.text = "\(IV[levelTextView.text!]![0])"
//                battleRatingPerCent.text = "\(floor(((attackDefense)) * 100))%"
//                hpPerCent.text = "\(floor((stamina) * 100))%"
//                cpRatingPerCent.text = "\((floor((stamina) * 100) + floor(((attackDefense)) * 100)) / 2.0)%"
//                self.noCombinaisonLabel.hidden = true
//                self.noCombinaisonLabel2.hidden = true
//            } else {
//                self.resultsMainView.hidden = true
//                self.noCombinaisonLabel.hidden = false
//                self.noCombinaisonLabel2.hidden = false
//            }
//        }
//    }
    
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
    
    @IBAction func hpPressed(sender: AnyObject) {
        let view = HpModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.hpTextField.text = "\(starterForHp)"
        modal.showMagnitude = 200.0
        modal.closeMagnitude = 130.0
        view.closeButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        modal.show(modalView: view, inView: window!)
    }
    @IBAction func cpPressed(sender: AnyObject) {
        let view = CpModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.cpTextField.text = "\(starterForCp)"
        modal.showMagnitude = 200.0
        modal.closeMagnitude = 130.0
        view.closeButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        modal.show(modalView: view, inView: window!)
    }
    @IBAction func stardustPressed(sender: AnyObject) {
        let view = StardustModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.pickerView.selectRow(startForStardust, inComponent: 0, animated: true)
        view.stardustTextField.text = stardustOption[startForStardust]
        modal.showMagnitude = 200.0
        modal.closeMagnitude = 130.0
        view.closeButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        view.bottomButtonHandler = {[weak modal] in
            modal?.closeWithLeansRandom()
            return
        }
        modal.show(modalView: view, inView: window!)
    }
    @IBAction func levelPressed(sender: AnyObject) {
        if  levelCanBePressed {
            let view = LevelModalView.instantiateFromNib()
            let window = UIApplication.sharedApplication().delegate?.window!
            let modal = PathDynamicModal()
            view.vc = self
            view.levelsToPick = findLevels(self.stardust, powered: powered)
            view.levelTextField.text = (findLevels(self.stardust, powered: powered))[0]
            view.pickerView.selectRow(0, inComponent: 0, animated: true)
            modal.showMagnitude = 200.0
            modal.closeMagnitude = 130.0
            view.closeButtonHandler = {[weak modal] in
                modal?.closeWithLeansRandom()
                return
            }
            view.bottomButtonHandler = {[weak modal] in
                modal?.closeWithLeansRandom()
                return
            }
            modal.show(modalView: view, inView: window!)
        } else {
            print("Can't choose level now")
        }
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
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if !self.tableView.hidden {
//            self.selectedPokemon = pokemonList[indexPath.row]
//            self.buttonPressed.hidden = false
//            self.addButton.hidden = true
//            self.buttonPressed.setImage(pokemonList[indexPath.row].img, forState: .Normal)
//            self.tableView.hidden = true
//            self.pokemonName.text = selectedPokemon.name
//        }
//    }
//
    
    func passHp(hp: Int) {
        self.hp = hp
        print(self.hp)
        print("hp sent")
        self.hpOK = true
    }
    
    func passCp(cp: Int) {
        self.cp = cp
        print(self.cp)
        print("cp sent")
        self.cpOK = true
    }
    
    func passStardust(stardust: Int) {
        self.stardust = stardust
        print(self.stardust)
        print("stardust sent")
        self.stardustOK = true
        self.levelCanBePressed = true
    }
    
    func passLevel(level: String) {
        self.level = level
        print(self.level)
        print("level sent")
        self.levelOK = true
    }

}
