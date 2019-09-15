//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gabriel on 14/09/2019.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("App Started")
        API.forecast(withLocation: "37.8267,-122.4233") { (hourly: [Hourly], daily: [Daily]) in
            print("\(hourly.count)\n\n")
            print("\(daily.count)\n\n")
        }
    }
}

