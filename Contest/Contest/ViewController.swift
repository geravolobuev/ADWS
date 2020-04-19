//
//  ViewController.swift
//  Contest
//
//  Created by MAC on 11/04/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        if let email = emailTextfield.text {
            if email.isEmpty {
                animateEmail()
            } else {
                performSegue(withIdentifier: "submitEmail", sender: self)
            }
        }
    }
    
    func animateEmail() {
        UIView.animate(withDuration: 0.25, animations:  {
            self.emailTextfield.transform = CGAffineTransform(translationX: 10.0, y: 0)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.25) {
            self.emailTextfield.transform = CGAffineTransform.identity
            }
        })
    }
}

