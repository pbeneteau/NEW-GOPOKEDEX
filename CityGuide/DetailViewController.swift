//
//  DetailViewController.swift
//  CityGuide
//
//  Created by Anna on 31/12/15.
//  Copyright © 2015 TastyApp. All rights reserved.
//

import UIKit
import MapKit
import GoogleMobileAds

class DetailViewController: UITableViewController, GADInterstitialDelegate {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var jumpsPerMinLabel: UILabel!
    @IBOutlet weak var jumpsDurationLabel: UILabel!
    
    @IBOutlet weak var spanRateLabel: UILabel!
    @IBOutlet weak var captureRateLabel: UILabel!
    
    @IBOutlet weak var typeViewC1: UIView!
    @IBOutlet weak var typeViewC2: UIView!
    
    @IBOutlet weak var typeViewC1Label: UILabel!
    
    @IBOutlet weak var typeViewC11: UIView!
    @IBOutlet weak var typeViewC12: UIView!
    @IBOutlet weak var typeViewC11Label: UILabel!
    @IBOutlet weak var typeViewC12Label: UILabel!
    
    @IBOutlet weak var maxCpProgress: UIProgressView!
    @IBOutlet weak var maxCpLabel: UILabel!
    
    
    @IBOutlet weak var minCpProgress: UIProgressView!
    @IBOutlet weak var minCpLabel: UILabel!
    
    @IBOutlet weak var attacjProgress: UIProgressView!
    @IBOutlet weak var defenseProgress: UIProgressView!
    @IBOutlet weak var staminaProgress: UIProgressView!
    
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var staminaLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GENERAL STATS
        initGeneralStats()
        // QUICK MOVES
        initQuickMoves()
        // CHARGE MOVES
        initChargeMoves()
    }
    

    
    override func viewWillAppear(animated: Bool) {
        // show the navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = pokemon.name
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont (name: "OpenSans-Semibold", size: 19)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 14)!], forState: UIControlState.Normal)
    }
    
    override func viewWillDisappear(animated: Bool) {
        // set the alpha of the navigation bar back to 1
        self.navigationController?.navigationBar.alpha = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initGeneralStats() {
        // IMAGE
        self.pokemonImage.image = pokemon.img
        self.pokemonImage.backgroundColor = pokemon.types[0].color
        // DESCRIPTION
        self.weightLabel.text = "Weight: \(pokemon.weight)"
        self.heightLabel.text = "Height: \(pokemon.height)"
        self.jumpsPerMinLabel.text = "Jumps/min: \(pokemon.jumps)"
        self.jumpsDurationLabel.text = "Jumps duration: \(pokemon.jumpDuration)"
        // RARETY
        self.spanRateLabel.text = pokemon.baseFlee
        self.captureRateLabel.text = pokemon.baseCatch
        // TYPES
        if pokemon.types.count == 1 {
            self.typeViewC1.hidden = false
            self.typeViewC2.hidden = true
            self.typeViewC1Label.text = pokemon.types[0].name
            self.typeViewC1.backgroundColor = pokemon.types[0].color
        } else if pokemon.types.count == 2 {
            self.typeViewC1.hidden = true
            self.typeViewC2.hidden = false
            self.typeViewC11Label.text = pokemon.types[0].name
            self.typeViewC11.backgroundColor = pokemon.types[0].color
            self.typeViewC12Label.text = pokemon.types[1].name
            self.typeViewC12.backgroundColor = pokemon.types[1].color
        }
        // CP
            // Label
        self.minCpLabel.text = "CP- \(pokemon.minCP)"
        self.maxCpLabel.text = "CP+ \(pokemon.maxCP)"
            // Progress
        self.minCpProgress.progress = 152/Float(pokemon.minCP)!
        self.maxCpProgress.progress = Float(pokemon.maxCP)!/4145
            // Color
        self.minCpProgress.progressTintColor = UIColor(red:0.94, green:0.28, blue:0.21, alpha:1.0)
        self.maxCpProgress.progressTintColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
        
        // STATS
            // Labels
        self.attackLabel.text = pokemon.attack
        self.defenseLabel.text = pokemon.defense
        self.staminaLabel.text = pokemon.stamina
            // Labels
        self.attacjProgress.progress = Float(pokemon.attack)!/284
        self.defenseProgress.progress = Float(pokemon.defense)!/242
        self.staminaProgress.progress = Float(pokemon.stamina)!/500
            // Color
        self.attacjProgress.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
        self.defenseProgress.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
        self.staminaProgress.progressTintColor = UIColor(red:0.96, green:0.14, blue:0.35, alpha:1.0)
    }
    
    func initQuickMoves() {
        performSegueWithIdentifier("quickMovesSegue", sender: nil)
    }
    
    func initChargeMoves() {
        performSegueWithIdentifier("chargeMovesSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "quickMovesSegue" {
            (segue.destinationViewController as! quickMovesViewController).pokemon = pokemon
        } else if segue.identifier == "chargeMovesSegue" {
            (segue.destinationViewController as! chargeMovesViewController).pokemon = pokemon
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return false
    }
    
}






