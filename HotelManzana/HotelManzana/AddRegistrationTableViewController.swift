//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by MAC on 01/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var lastNameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    @IBOutlet var numberOfNightsLabel: UILabel!
    var numberOfNights = 1 {
        didSet {
            updateTotal()
        }
    }
    
    @IBOutlet var chargeRoomTypeLabel: UILabel!
    @IBOutlet var chargeRoomTotalLabel: UILabel!
    @IBOutlet var chargeWifiLabel: UILabel!
    @IBOutlet var chargeWifiTotalLabel: UILabel!
    @IBOutlet var chargeTotal: UILabel!
    
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    var roomType: RoomType?
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section:
        1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section:
        1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var registration: Registration? {
        
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextfield.text ?? ""
        let lastName = lastNameTextfield.text ?? ""
        let email = emailTextfield.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    }
    
    var guest:Registration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let guest = guest {
            firstNameTextfield.text = guest.firstName
            lastNameTextfield.text = guest.lastName
            emailTextfield.text = guest.emailAddress
            checkInDatePicker.date = guest.checkInDate
            checkOutDatePicker.date = guest.checkOutDate
            updateDateViews()
            numberOfAdultsStepper.value = Double(guest.numberOfAdults)
            numberOfChildrenStepper.value = Double(guest.numberOfChildren)
            updateNumberOfGuests()
            roomType = guest.roomType
            updateRoomType()
            updateTotal()
        }
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        numberOfNightsLabel.text = "1"
        updateDoneLabel()
    }
    
    func updateDoneLabel() {
        guard let roomLabel = roomTypeLabel.text else { return }
        guard let firstName = firstNameTextfield.text else { return }
        guard let lastName = lastNameTextfield.text else { return }
        if roomLabel != "Not Set" && firstName != "" && lastName != "" {
                doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
            
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateDoneLabel()
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        guard let diffInDays = Calendar.current.dateComponents([.day], from: checkInDatePicker.date, to: checkOutDatePicker.date).day else { return }
        numberOfNights = diffInDays
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
            chargeRoomTotalLabel.text = "$ \(roomType.price * Int(numberOfNightsLabel.text!)!)"
        } else {
            roomTypeLabel.text = "Not Set"
        }
        
        switch (roomTypeLabel.text) {
        case "Two Queens":
            chargeRoomTypeLabel.text = "Q"
        case "One King":
            chargeRoomTypeLabel.text = "K"
        case "Penthouse Suite":
            chargeRoomTypeLabel.text = "P"
        default:
            chargeRoomTypeLabel.text = "-"
        }
        updateTotal()
        updateDoneLabel()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            chargeWifiLabel.text = "Yes"
            
        } else {
            chargeWifiLabel.text = "No"
            chargeWifiTotalLabel.text = "0"
        }
        updateTotal()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }

    func updateTotal() {
        var wifi = 0
        var room = 0
        
        numberOfNightsLabel.text = "\(numberOfNights)"
        if wifiSwitch.isOn {
            chargeWifiTotalLabel.text = "\(numberOfNights * 10)"
            wifi = Int(chargeWifiTotalLabel.text!)!
        }
        if let roomType = roomType {
            chargeRoomTotalLabel.text = "\(roomType.price * numberOfNights)"
            room = Int(chargeRoomTotalLabel.text!)!
        }
        let total = wifi + room
        chargeTotal.text = "$ \(total)"
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
}
