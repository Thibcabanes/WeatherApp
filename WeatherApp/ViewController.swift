//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gabriel on 14/09/2019.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    var current = 0
    var hourlyForecast = [Hourly]()
    var dailyForecast = [Daily]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("App Started")
        updateLocation(location: "37.8267,-122.4233")
    }
    
    func updateLocation(location: String) {
        API.forecast(withLocation: "37.8267,-122.4233") { (hourly: [Hourly], daily: [Daily]) in
            self.hourlyForecast = hourly
            self.dailyForecast = daily
            DispatchQueue.main.async {
                self.updateFields()
            }
        }
    }

    func updateFields() {
        min.text = "❄️ \(Int(self.dailyForecast[0].temperatureLow)) °F"
        max.text = "🔥 \(Int(self.dailyForecast[0].temperatureHigh)) °F"
        icon.image = UIImage(named: self.hourlyForecast[self.current].icon)
        temp.text = "\(Int(self.hourlyForecast[self.current].temperature)) °F"
    }
}

