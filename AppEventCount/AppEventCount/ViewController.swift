//
//  ViewController.swift
//  AppEventCount
//
//  Created by MAC on 22/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var didFinishLauching: UILabel!
    var finishCount = 0
    
    @IBOutlet var willResignActive: UILabel!
    var resingCount = 0
    
    @IBOutlet var didEnterBackground: UILabel!
    var enterBackgroundCount = 0
    
    @IBOutlet var willEnterForeground: UILabel!
    var enterForegroundCount = 0
    
    @IBOutlet var didBecomeActive: UILabel!
    var activeCount = 0
    
    @IBOutlet var willTerminate: UILabel!
    var terminateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        updateView()
    }

    func updateView() {
        
        didFinishLauching.text = "The app has launched \(finishCount) time(s)"
        willResignActive.text = "The app resign active \(resingCount) time(s)"
        didEnterBackground.text = "The app enter background \(enterBackgroundCount) time(s)"
        willEnterForeground.text = "The app enter foreground \(enterForegroundCount) time(s)"
        didBecomeActive.text = "The app become active \(activeCount) time(s)"
        willTerminate.text = "The app terminated \(terminateCount) time(s)"
        
    }
}

