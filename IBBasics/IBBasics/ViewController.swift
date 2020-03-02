//
//  ViewController.swift
//  IBBasics
//
//  Created by MAC on 19/02/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("The button was pressed!")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myButton.setTitleColor(.red, for: .normal)
    }


}

