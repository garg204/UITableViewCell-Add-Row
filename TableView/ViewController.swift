//
//  ViewController.swift
//  TableView
//
//  Created by Ankit on 24/09/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        //Allow to add row on clicking cell during editing mode
        tableView.allowsSelectionDuringEditing = true
        array = ["One","Two","Three"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        if editing {
            super.setEditing(true, animated: true)
            //tableView.beginUpdates()
            
            let indexPath = IndexPath(row: array.count, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            //tableView.endUpdates()
            tableView.setEditing(true, animated: true)
        }
        else{
            
            super.setEditing(false, animated: false)
            tableView.beginUpdates()
            
            let indexPath = IndexPath(row: array.count, section: 0)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            tableView.setEditing(true, animated: true)
            tableView.setEditing(false, animated: false)
            
        }
    }
    
    
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row >= array.count && isEditing{
            cell.textLabel?.text = "Add Icon"
        }
        else{
            cell.textLabel?.text = array[indexPath.row]
        }
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let adjustment = isEditing ? 1 : 0
        print(array.count +  adjustment)
        return array.count +  adjustment
    }
    
    //Return the editing style insert if the number of index row are more then count of the data array
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row >= array.count && isEditing{
            return .insert
        }
        else {
            return .delete
        }
        
        
    }
    
    // Insert the row on click either Plus icon or selecting the cell
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert{
            tableView.beginUpdates()
            array.append("Fourth")
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    // Add the row on clicking cell
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row < array.count{
            return nil
        }
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row >= array.count && isEditing {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        }
    }
    
    
}

