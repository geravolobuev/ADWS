//
//  ViewController.swift
//  InerfaceBuilderBasics
//
//  Created by MAC on 19/02/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: Any) {
        myLabel.text = "This app rocks!"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

