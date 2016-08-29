//
//  IVTableViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 28/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class IVTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var selectedPokemonId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

         (cell.viewWithTag(100) as! UIImageView).image = pokemonList[indexPath.row].img
        (cell.viewWithTag(101) as! UILabel).text = pokemonList[indexPath.row].name

        return cell
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPokemonId = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("IVViewController") as! IVViewController
        vc.buttonPressed.hidden = false
        vc.buttonPressed.setImage(pokemonList[selectedPokemonId].img, forState: .Normal)
        vc.selectionContainer.hidden = true
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        (segue.destinationViewController as! IVViewController).selectedPokemon = selectedPokemonId
    }

}
