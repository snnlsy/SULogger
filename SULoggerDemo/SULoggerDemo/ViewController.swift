//
//  ViewController.swift
//  SULoggerDemo
//
//  Created by SUlusoy on 21.08.2024.
//

import UIKit
import SULogger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SULogger.debug("test message")
    }


}

