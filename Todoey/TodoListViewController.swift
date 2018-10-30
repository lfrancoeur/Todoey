//
//  ViewController.swift
//  Todoey
//
//  Created by Leo Francoeur on 10/30/18.
//  Copyright © 2018 Leo Francoeur. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items //uses the local user default items (in a plist file on the device) to add strings to the array
        }
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //Creates the table view data source methods  - specifies what the cell should display and how many rows in the table
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //allows you to insert data into the table
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)//creates a reusable cell for use by the array
        
        cell.textLabel?.text = itemArray[indexPath.row] //populates with text for the current row of the itemArray
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //when you click on a cell in teh table view the below is done
        
        print(itemArray[indexPath.row]) //prints out the cell name
        
        
        //Allows you to check and uncheck the checkmark if you want
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark { //checks to see if the cell has a checkmark in it
            tableView.cellForRow(at: indexPath)?.accessoryType = .none //gets rid of the checkmark
        }
        
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //if there is no checkmark when it is selected add the checkmark
        }
        //End of uncheck and check the check mark
        
        
        tableView.deselectRow(at: indexPath, animated: true) //when you select the row it flashes grey for a second then goes back to white
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) { //linked from the + button in the top right corner of Todoey table view controller
    
            var textField = UITextField()
        
            let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert) //creates the alert popup to add text into the box for input into the list
        
        
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in //The button you press when your done writing your item and want to add it to the list
         
            
            self.itemArray.append(textField.text!) //adds what the user types into the alert popup into the array
            
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
    



