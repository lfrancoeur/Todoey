//
//  ViewController.swift
//  Todoey
//
//  Created by Leo Francoeur on 10/30/18.
//  Copyright © 2018 Leo Francoeur. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items //uses the local user default items (in a plist file on the device) to add strings to the array
        }
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //Creates the table view data source methods  - specifies what the cell should display and how many rows in the table
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //allows you to insert data into the table
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)//creates a reusable cell for use by the array
        
        let item = itemArray[indexPath.row]
       
        //Ternary Operator
        //Value = condition ? valueIftrue : valueIfFalse
        
        cell.textLabel?.text = item.title //populates with text for the current row of the itemArray
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    

    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //when you click on a cell in teh table view the below is done
        
       // print(itemArray[indexPath.row]) //prints out the cell name
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //Allows you to check and uncheck the checkmark if you want
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true) //when you select the row it flashes grey for a second then goes back to white
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) { //linked from the + button in the top right corner of Todoey table view controller
    
            var textField = UITextField()
        
            let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert) //creates the alert popup to add text into the box for input into the list
        
        
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in //The button you press when your done writing your item and want to add it to the list
         
            let newItem = Item()
            newItem.title = textField.text!
                
            self.itemArray.append(newItem) //adds what the user types into the alert popup into the array
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //saves user created array items to the user defaults
                
            self.tableView.reloadData() //reloads the data in the table view controller to show the new value of what the user types in 
            
        }
            
            //create text box for user to input information
            alert.addTextField(configurationHandler: { (alertTextField) in
                alertTextField.placeholder = "Create New Item" //placeholder item that appears in grey before the user writes in it
                textField = alertTextField
            })
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil) //shows alert
            
            
        }
        
    }
    



