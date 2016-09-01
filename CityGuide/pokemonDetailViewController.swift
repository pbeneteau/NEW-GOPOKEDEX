//
//  pokemonDetailViewController.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 01/09/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

class pokemonDetailViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        let controller : UIViewController = UIViewController(nibName: "infos", bundle: nil)
        controller.title = "INFO"
        controllerArray.append(controller)
        let controller2 : UIViewController = UIViewController(nibName: "Spell", bundle: nil)
        controller2.title = "SPELL"
        controllerArray.append(controller2)
        let controller3 : UIViewController = UIViewController(nibName: "AdvWeak", bundle: nil)
        controller3.title = "AD/WE"
        controllerArray.append(controller3)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor ( red: 0.2039, green: 0.2863, blue: 0.3686, alpha: 1.0 )),
            .BottomMenuHairlineColor(UIColor.whiteColor()),
            .MenuItemFont(UIFont(name: "OpenSans-Semibold", size: 19.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(screenWidth/3),
            .MenuMargin (CGFloat(0.0)),
            .MenuItemSeparatorColor (UIColor ( red: 0.5586, green: 0.5586, blue: 0.5586, alpha: 1.0 )),
            .MenuItemSeparatorWidth (0.7),
            .MenuItemSeparatorPercentageHeight (0.9),
            .SelectedMenuItemLabelColor (UIColor ( red: 0.2999, green: 0.2999, blue: 0.2999, alpha: 1.0 )),
            .UnselectedMenuItemLabelColor (UIColor ( red: 0.2999, green: 0.2999, blue: 0.2999, alpha: 1.0 ))
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: mainView.bounds, pageMenuOptions: parameters)
        pageMenu?.selectionIndicatorView.frame = CGRectMake((pageMenu?.menuItemWidth)!/2 - (pageMenu?.selectionIndicatorView.frame.width)!/2, 35, (pageMenu?.selectionIndicatorView.frame.width)!, (pageMenu?.selectionIndicatorView.frame.height)!)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.mainView.addSubview(pageMenu!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
