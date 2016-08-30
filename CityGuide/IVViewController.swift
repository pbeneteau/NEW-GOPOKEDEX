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
    
    let mySwitch = SevenSwitch()
    var powered: Bool = false
    var selectedPokemon = Pokemon(id: "", name: "")
    
    var pickerViewStardust = UIPickerView()
    var pickerViewLevel = UIPickerView()
    
    var levels = [String]()
    var IV: [String:[Double]]! = nil
    var hp = 53
    var cp = 504
    var stardust = 3000
    var level = "21.0"
    
    var hpOK: Bool! = true
    var cpOK: Bool! = true
    var stardustOK: Bool! = true
    var levelOK: Bool! = true
    var levelCanBePressed = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwitch()
        self.tableView.hidden = true
    }
    override func viewDidAppear(animated: Bool) {
        selectedPokemon = pokemonList[3]
        self.pokemonImage.hidden = true
        initStats()
        hideAllStats(true)
        getAllIV()
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initStats() {
        self.hpLabel.text = "\(self.hp)"
        self.cpLabel.text = "\(self.cp)"
        self.stardustLabel.text = "\(self.stardust)"
        self.levelLabel.text = level
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        self.tableView.hidden = false
        animateTable()
        self.navigationItem.title = "Choose your pokemon"
    }
    @IBAction func pokemonPressed(sender: AnyObject) {
        self.tableView.hidden = false
        
        
        self.navigationItem.title = "Choose your pokemon"
    }
    
    func hideAllStats(hide: Bool) {
        self.attackDefenseIv.hidden = hide
        self.staminaIv.hidden = hide
        self.battleRatingPerCent.hidden = hide
        self.cpRatingPerCent.hidden = hide
        self.hpPerCent.hidden = hide
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
    
    
    
    func getAllIV() {
        if (hpOK && cpOK && stardustOK && levelOK) {
            IV = getIV(selectedPokemon, cp: self.cp, hp: self.hp, stardust: self.stardust, powered: powered)
            self.hideAllStats(false)
        }
    }
    
    func loadIVForLevel() {
        if (IV != nil) {
            if IV[self.level]![0] != 1111.11111 {
                let stamina = Double(IV[self.level]![0])/15.0
                let attackDefense = Double(IV[self.level]![1])/30.0
                attackDefenseIv.text = "\(IV[self.level]![1])"
                staminaIv.text = "\(IV[self.level]![0])"
                battleRatingPerCent.text = "\(floor(((attackDefense)) * 100))%"
                hpPerCent.text = "\(floor((stamina) * 100))%"
                cpRatingPerCent.text = "\((floor((stamina) * 100) + floor(((attackDefense)) * 100)) / 2.0)%"
                self.noCombinaisonLabel.hidden = true
                self.noCombinaisonLabel2.hidden = true
            } else {
                self.resultsMainView.hidden = true
                self.noCombinaisonLabel.hidden = false
                self.noCombinaisonLabel2.hidden = false
            }
        }
    }
    
    func switchChanged(sender: SevenSwitch) {
        if powered {
            powered = false
            poweredLabel.layer.shadowColor = UIColor(red:0.60, green:0.58, blue:0.58, alpha:1.0).CGColor
            poweredLabel.layer.shadowRadius = 0
            poweredLabel.layer.shadowOpacity = 0
            poweredLabel.layer.masksToBounds = false
            poweredLabel.textColor = UIColor(red:0.60, green:0.58, blue:0.58, alpha:1.0)
            self.levelLabel.text = findLevels(self.stardust, powered: powered)[0]
            getAllIV()
            loadIVForLevel()
        } else {
            powered = true
            poweredLabel.layer.shadowColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0).CGColor
            poweredLabel.layer.shadowRadius = 4.0
            poweredLabel.layer.shadowOpacity = 0.9
            poweredLabel.layer.shadowOffset = CGSizeZero
            poweredLabel.layer.masksToBounds = false
            poweredLabel.textColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
            self.levelLabel.text = findLevels(self.stardust, powered: powered)[0]
            getAllIV()
            loadIVForLevel()
        }
        print(powered)
    }
    
    @IBAction func hpPressed(sender: AnyObject) {
        let view = HpModalView.instantiateFromNib()
        let window = UIApplication.sharedApplication().delegate?.window!
        let modal = PathDynamicModal()
        view.vc = self
        view.hpTextField.text = "\(self.hp)"
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
        view.cpTextField.text = "\(self.cp)"
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
        view.pickerView.selectRow(self.stardust, inComponent: 0, animated: true)
        view.stardustTextField.text = "\(self.stardust)"
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            self.selectedPokemon = pokemonList[indexPath.row]
            self.pokemonImage.hidden = false
            self.addButton.hidden = true
            self.pokemonImage.setImage(pokemonList[indexPath.row].img, forState: .Normal)
            self.tableView.hidden = true
            self.navigationItem.title = selectedPokemon.name
    }
    
    
    func passHp(hp: Int) {
        self.hp = hp
        self.hpLabel.text = "\(self.hp)"
        print(self.hp)
        print("hp sent")
        self.hpOK = true
        getAllIV()
        loadIVForLevel()
    }
    
    func passCp(cp: Int) {
        self.cp = cp
        self.cpLabel.text = "\(self.cp)"
        print(self.cp)
        print("cp sent")
        self.cpOK = true
        getAllIV()
        loadIVForLevel()
    }
    
    func passStardust(stardust: Int) {
        self.stardust = stardust
        self.stardustLabel.text = "\(self.stardust)"
        print(self.stardust)
        print("stardust sent")
        self.stardustOK = true
        self.levelCanBePressed = true
        self.levelLabel.text = findLevels(self.stardust, powered: powered)[0]
    }
    
    func passLevel(level: String) {
        self.level = level
        self.levelLabel.text = "\(self.level)"
        print(self.level)
        print("level sent")
        self.levelOK = true
        self.hideAllStats(false)
        getAllIV()
        loadIVForLevel()
    }
    
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn , animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
}
