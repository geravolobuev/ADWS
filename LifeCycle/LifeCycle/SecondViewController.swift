//
//  SecondViewController.swift
//  LifeCycle
//
//  Created by MAC on 11/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

        override func viewDidLoad() {
             super.viewDidLoad()
             print("Second view controller - view did load")
         }

         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             print("Second view controller - view will appear")
         }

         override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
             print("Second view controller - view did appear")
         }
         
         override func viewWillDisappear(_ animated: Bool) {
             super.viewWillDisappear(animated)
             print("Second view controller - view will disappear")
         }
         
         override func viewDidDisappear(_ animated: Bool) {
             super.viewDidDisappear(animated)
             print("Second view controller - view did disappear")
         }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
