//
//  ViewController.swift
//  Todoey
//
//  Created by Leo Francoeur on 10/30/18.
//  Copyright © 2018 Leo Francoeur. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var toDoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
        
      
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items //uses the local user default items (in a plist file on the device) to add strings to the array
//        }
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //Creates the table view data source methods  - specifies what the cell should display and how many rows in the table
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //allows you to insert data into the table
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)//creates a reusable cell for use by the array
        
        if let item = toDoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title //populates with text for the current row of the itemArray
            
            //Ternary Operator
            //Value = condition ? valueIftrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
        }
            
        else {
            cell.textLabel?.text = "No Items Added"
        }

        
        return cell
    }
    

    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //when you click on a cell in teh table view the below is done
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                   item.done = !item.done
                }
            }
            
            catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true) //when you select the row it flashes grey for a second then goes back to white
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) { //linked from the + button in the top right corner of Todoey table view controller
    
            var textField = UITextField()
        
            let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert) //creates the alert popup to add text into the box for input into the list
        
        
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in //The button you press when your done writing your item and want to add it to the list
            
            
                if let currentCategory = self.selectedCategory {
                    
                    do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                        }
                    }
                    catch {
                        print("There was an error \(error)")
                    }
            self.tableView.reloadData()
            }
            
            //create text box for user to input information
            alert.addTextField(configurationHandler: { (alertTextField) in
                alertTextField.placeholder = "Create New Item" //placeholder item that appears in grey before the user writes in it
                textField = alertTextField
            })
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil) //shows alert
            
                
        }
  //MARK - Model Manipulation Methods

        func loadItems() {
            
            toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            
            tableView.reloadData()
        }

    }

}

//MARK: - Search bar methods including DB queries

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
        toDoItems = toDoItems?.filter("title CONTAINS[cd} %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }

       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
