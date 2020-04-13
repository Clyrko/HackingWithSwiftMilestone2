//
//  ViewController.swift
//  Swift100Milestone2
//
//  Created by Jay A. on 4/13/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding nav item button (add)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addShoppingListItems))
        
    }

    
    @objc func addShoppingListItems() {
        
        // Setting up alert to add shopping item
        let ac = UIAlertController(title: "Enter your item", message: nil, preferredStyle: .alert)
        // Addind a textfield to alert controller
        ac.addTextField()
        
    }
    

}

