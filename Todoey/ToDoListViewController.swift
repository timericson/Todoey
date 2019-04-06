//
//  ViewController.swift
//  Todoey
//
//  Created by Tim Ericson on 4/4/19.
//  Copyright © 2019 Tim Ericson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Erik's Lunch", "Brush Teeth", "Stay Up!"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
          tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        // Deselects the cells once they've been pressed
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
  
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // What will happen once the user clicks the add button on our UIAlert
            print("Success!")
            print(textField.text)
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            print(alertTextField)
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        
    present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
}

