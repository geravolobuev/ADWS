//
//  ViewController.swift
//  TwoButtons
//
//  Created by MAC on 28/02/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func redPillTapped(_ sender: UIButton) {
        label.text = "You choose red pill."
    }
    
    @IBAction func bluePillTapped(_ sender: UIButton) {
        label.text = "You choose blue pill."
    }
    
}

