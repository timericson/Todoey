//
//  ViewController.swift
//  Todoey
//
//  Created by Tim Ericson on 4/4/19.
//  Copyright © 2019 Tim Ericson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //var itemArray = ["Erik's Lunch", "Brush Teeth", "Stay Up!"]
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Erik's Lunch"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Brush Teeth"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Stay Up!"
        itemArray.append(newItem3)
        
        
                if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
                    itemArray = items
                }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        // These lines replaced by the Ternary operator
//        if item.done == true {
//
//            cell.accessoryType = .checkmark
//
//        } else {
//
//            cell.accessoryType = .none
//
//        }
        
        return cell
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        // This reverses the value
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
 
        //Reversing the value in a long winded way
//        if itemArray[indexPath.row].done == false {
//
//            itemArray[indexPath.row].done = true
//
//        } else {
//
//            itemArray[indexPath.row].done = false
//
//        }
        
        tableView.reloadData()
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
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
