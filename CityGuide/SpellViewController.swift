//
//  SpellViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 02/09/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class SpellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chargeMovesTableView: UITableView!
    @IBOutlet weak var quickMovesTableView: UITableView!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 199 {
            return pokemon.quickMoves.count
        } else if tableView.tag == 299 {
            return pokemon.chargeMoves.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        if tableView.tag == 199 {
            cell = tableView.dequeueReusableCellWithIdentifier("quickCell", forIndexPath: indexPath)
            (cell.viewWithTag(202) as! UIImageView).image = UIImage(named: "\(pokemon.quickMoves[indexPath.row].type.name)move")
            (cell.viewWithTag(200) as! UILabel).text = pokemon.quickMoves[indexPath.row].trueDps
            (cell.viewWithTag(201) as! UILabel).text = pokemon.quickMoves[indexPath.row].name
        } else if tableView.tag == 299 {
            cell = tableView.dequeueReusableCellWithIdentifier("chargeCell", forIndexPath: indexPath)
            (cell.viewWithTag(402) as! UIImageView).image = UIImage(named: "\(pokemon.chargeMoves[indexPath.row].type.name)move")
            (cell.viewWithTag(400) as! UILabel).text = pokemon.chargeMoves[indexPath.row].trueDps
            (cell.viewWithTag(401) as! UILabel).text = pokemon.chargeMoves[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    // MARK: Table vie delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

}
