//
//  ViewController.swift
//  Swift100Milestone2
//
//  Created by Jay A. on 4/13/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let savedItems = defaults.object(forKey: "shoppingList") as? Data {
            
            shoppingList = NSKeyedUnarchiver.unarchiveObject(with: savedItems) as! [String]
            
        }
        
        title = "Shopping List"
        
        // Adding add button to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
        // Adding share button to nav bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Adding rows = number of items in array
        return shoppingList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Filling tableview cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Editing cell in tableview
        let ac = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields![0].text! = shoppingList[indexPath.row]
        
        // Saving textfield
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [unowned self] (action: UIAlertAction) in
            self.shoppingList[indexPath.row] = ac.textFields![0].text!
            self.tableView.reloadData()
            self.saveItems()
            
        })
        
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action: UIAlertAction) in
            self.shoppingList.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.saveItems()
        })
        
        present(ac, animated: true)
    }
    
   @objc func promptForItem() {
        let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [unowned self] (action: UIAlertAction) in
            self.shoppingList.append(ac.textFields![0].text!)
            self.tableView.reloadData()
            self.saveItems()
        })
        
        present(ac, animated: true)
    }
    
   @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        let initialText = "My shopping list: \n"
        
        let vc = UIActivityViewController(activityItems: [initialText, list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        
        present(vc, animated: true)
    }
    
    func saveItems() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: shoppingList)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "items")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
