//
//  ViewController.swift
//  SwiftExample1
//
//  Created by Brian Sterner on 6/5/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

import UIKit
//import SwiftClasses

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("Hello World")
        
        let car = Car()
        println("Car: \(car.description())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

