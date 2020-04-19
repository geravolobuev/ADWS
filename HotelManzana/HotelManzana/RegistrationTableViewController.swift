//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by MAC on 04/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    var registrations: [Registration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return registrations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        let guest = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = "\(guest.firstName) \(guest.lastName)"
        cell.detailTextLabel?.text = dateFormatter.string(from: guest.checkInDate) + " - " + dateFormatter.string(from: guest.checkOutDate) + ": " + guest.roomType.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editRegistration" {
            let indexPath = tableView.indexPathForSelectedRow!
            let guest = registrations[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addRegistrationTableViewController = navController.topViewController as! AddRegistrationTableViewController
            
            addRegistrationTableViewController.guest = guest
        }
    }
    

    @IBAction func unwindFromAddRegistration(_ unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController else { return }
        
        if let guest = addRegistrationTableViewController.registration {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                registrations[selectedIndexPath.row] = guest
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: registrations.count, section: 0)
                registrations.append(guest)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

}
