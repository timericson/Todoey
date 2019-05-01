//
//  ViewController.swift
//  Todoey
//
//  Created by Tim Ericson on 4/4/19.
//  Copyright © 2019 Tim Ericson. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    //var itemArray = ["Erik's Lunch", "Brush Teeth", "Stay Up!"]
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        
        // didSet executes code when the variable selectedCatergory gets a value
        didSet{
            loadItems()
        }
        
    }
    
//    // Data File Path
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // Core data
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

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
        
         //This reverses the current state
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
 
        saveItems()
        
        //Reversing the current state in a long winded way
        //        if itemArray[indexPath.row].done == false {
        //            itemArray[indexPath.row].done = true
        //        } else {
        //            itemArray[indexPath.row].done = false
        //        }
 
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
            
            
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            print(alertTextField)
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        
        
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
      
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
         itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
}


//MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        // Searchbar code to look for title non case or diacritic sensitive
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        
        print(searchBar.text!)
        
        let predicate = NSPredicate(format: "title CONTAINS[CD] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        
        //tableView.reloadData()
        
        
        
//        request.predicate = NSPredicate(format: "title CONTAINS[CD] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request)
      
    }
    
    // This method allows the user to dismiss the search list and go back to the original items
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            
            // Dismisses the seachbar and popup keyboard
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
            
        }
        
    }
    
}

