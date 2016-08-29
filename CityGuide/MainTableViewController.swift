//
//  MainTableViewController.swift
//

import UIKit
import CloudKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableview: UITableView!
    let kCloseCellHeight: CGFloat = 85
    let kOpenCellHeight: CGFloat = 500
    
    var kRowsCount = 150
    
    var cellHeights = [CGFloat]()

    // selected pokemon index used to knpw which cell has been selected
    var selectedPokemon = 0
    
    // set the cursor
    var theCursor:CKQueryCursor!
    var loadMoreOk: Bool = false
    
    var activityIndicator: NVActivityIndicatorView! = nil
    var pokemonEvolutionList = [[Pokemon]]()
    
    var filteredPokemons = Array<Pokemon>()
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false
    
    var animated = false
    
    var needClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initActivityIndicator()
        searchBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        initPokemon()
        initSearch()
    }
    
    func initPokemon() {
        pokemonList = initAllPokemons()
        typeList = initAllTypes()
        quickMoveList = initAllQuickMoves()
        chargeMoveList = initAllChargeMoves()
        initAllPokemonInfos(pokemonList, quickMoveList: quickMoveList, chargeMoveList: chargeMoveList, typeList: typeList)
        addTypes(chargeMoveList, typeList: typeList)
        addTypes(quickMoveList, typeList: typeList)
        print(pokemonList[8].name)
        let IV = getIV(pokemonList[8], cp: 1554, hp: 111, stardust: 3500, powered: true)
        print("IV:")
        let levels = findLevels(3500, powered: true)
        for level in levels {
            let stamina = Double(IV[level]![0])/15.0
            let attackDefense = Double(IV[level]![1])/30.0
            print("For level \(level):")
            print("\(IV[level]![0])/15")
            print("\(IV[level]![1])/30")
            print("Stamina: \(round(((stamina)) * 100))%")
            print("Attack+Defense: : \(round(((attackDefense)) * 100))%")
            print("All stats: \(round(((stamina + attackDefense)/3.0) * 100))%")
        }
        
        kRowsCount = pokemonList.count
        createCellHeightsArray()
        tableview.reloadData()
        activityIndicator.stopAnimation()
        searchBar.hidden = false
    }
    
    func initSearch() {
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            tableview.reloadData()
        } else {
            inSearchMode = true
            let lowercaseString = searchBar.text!.lowercaseString
            filteredPokemons = pokemonList.filter({(($0.name).lowercaseString.rangeOfString(lowercaseString) != nil)})
            tableview.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        searchBar.showsCancelButton = false
        filteredPokemons = pokemonList
        tableview.reloadData()
    }
    

    func initActivityIndicator() {
        self.activityIndicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, 80, 80))
        self.activityIndicator.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2 - activityIndicator.frame.height/2)
        self.activityIndicator.type = NVActivityIndicatorType.BallClipRotatePulse
        self.activityIndicator.color = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
        self.tableview.addSubview(activityIndicator)
        self.activityIndicator.startAnimation()
    }
    
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemons.count
        } else {
            return pokemonList.count
        }
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard case let cell as DemoCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! DemoCell

        var pokemonCopy: Pokemon
        if inSearchMode {
            pokemonCopy = filteredPokemons[indexPath.row]
        } else {
            pokemonCopy = pokemonList[indexPath.row]
        }
        cell.initHeader(pokemonCopy)
        cell.initMidCell(pokemonCopy)
        cell.initEvolution(pokemonCopy)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table vie delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        selectedPokemon = indexPath.row
        if cell.isAnimating() {
            return
        }
        
        if needClose {
            cellHeights[indexPath.row] = kCloseCellHeight
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }

    
    // prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            if inSearchMode {
                (segue.destinationViewController as! DetailViewController).pokemon = filteredPokemons[selectedPokemon]
            } else {
                (segue.destinationViewController as! DetailViewController).pokemon = pokemonList[selectedPokemon]
            }
        }
    }
}
