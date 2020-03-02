//
//  ViewController.swift
//  CommonInputControls
//
//  Created by MAC on 28/02/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.addTarget(self, action: #selector(buttonTapped(_:)), for:  .touchUpInside)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        print("The button was tapped!")
        
        if toggle.isOn {
            print("the swith is on")
        } else {
            print("The switch is off")
        }
        
        print("the slider value is \(slider.value)")
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("The switch is on")
        } else {
            print("the switch is off")
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func keyboardReturnKeyTapped(_ sender: UITextField) {
          if let text = sender.text {
              print(text)
          }
      }
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print(location)
    }
    
}

