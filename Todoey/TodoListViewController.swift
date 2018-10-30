//
//  ViewController.swift
//  Todoey
//
//  Created by Leo Francoeur on 10/30/18.
//  Copyright © 2018 Leo Francoeur. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
}

