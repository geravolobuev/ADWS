//
//  ViewController.swift
//  Login
//
//  Created by MAC on 09/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forgotUsernameButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        
        if sender == forgotUsernameButton {
            segue.destination.title = "Forgot user name"
        } else if sender == forgotPasswordButton {
            segue.destination.title = "Forgot password"
        } else {
            segue.destination.navigationItem.title = userName.text
        }
    }
    @IBAction func forgotUsernameTapped(_ sender: Any) {
        performSegue(withIdentifier: "showLanding", sender: forgotUsernameButton)
    }
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "showLanding", sender: forgotPasswordButton)
    }
    

}

