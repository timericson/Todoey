//
//  ViewController.swift
//  Todoey
//
//  Created by Tim Ericson on 4/4/19.
//  Copyright © 2019 Tim Ericson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Erik's Lunch", "Brush Teeth", "Stay Up!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
    
}

