//
//  OrderConfirmationViewController.swift
//  Restaraunt
//
//  Created by MAC on 18/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) !"
    }

    


}
