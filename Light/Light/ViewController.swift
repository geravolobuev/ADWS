//
//  ViewController.swift
//  Light
//
//  Created by MAC on 20/02/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var lightOn = true
    
    
    @IBOutlet weak var lightButton: UIButton!
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn = !lightOn
        updateUi()
    }
    
    func updateUi() {
        view.backgroundColor = lightOn ? .white : .black
        lightButton.setTitle("", for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

