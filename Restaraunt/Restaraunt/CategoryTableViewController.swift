//
//  CategoryTableViewController.swift
//  Restaraunt
//
//  Created by MAC on 17/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: MenuController.menuUpdatedNotification, object: nil)
        
        updateUI()
    }
 

    
    @objc func updateUI() {
        categories = MenuController.shared.categories
        tableView.reloadData()
    }
    
    
    // MARK: - Passing dataa

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableVC = segue.destination as! MenuTableViewController
            let selectedCell = tableView.indexPathForSelectedRow!.row
            menuTableVC.category = categories[selectedCell]
        }
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)

        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }


}
