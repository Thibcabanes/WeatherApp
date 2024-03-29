//
//  ViewController.swift
//  WeatherApp
//
//  Created by Cabanes on 14/09/2019.
//  Copyright © 2019 Cabanes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windDir: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rightSideMenu: UIView!
    @IBOutlet weak var rightSideTrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var leftSideMenu: UIView!
    @IBOutlet weak var leftSideLeadingAnchor: NSLayoutConstraint!

    var current = 0
    var hourlyForecast = [Hourly]()
    var dailyForecast = [Daily]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("App Started")

        updateLocation(location: "37.8267,-122.4233")
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGestureAction))
        rightSideMenu.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureAction(){
        leftSideLeadingAnchor.constant = -232
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.async {
            self.rightSideTrailingAnchor.constant = -182
        }
    }
    
    @IBAction func menuAction(_ sender: Any) {
        leftSideLeadingAnchor.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.rightSideTrailingAnchor.constant = 0
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.hourlyForecast.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let hour = Calendar.current.component(.hour, from: Date(timeIntervalSinceReferenceDate: self.hourlyForecast[row].time))

        print("\(hour)")
        print("\(hour)H")

        return NSAttributedString(string: "\(hour)H", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
//
//    func pickerView(_ pickerView: UIPickerView, p row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        return view
//    }
//
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.current = row
        print("OK?")
        self.updateFields()
    }
    
    func updateLocation(location: String) {
        API.forecast(withLocation: "37.8267,-122.4233") { (hourly: [Hourly], daily: [Daily]) in
            self.hourlyForecast = hourly
            self.dailyForecast = daily
            DispatchQueue.main.async {
                self.picker.delegate = self
                self.picker.dataSource = self
                self.updateFields()
            }
        }
    }
    
    func bearingToDistance(bearing: Int) -> String {
        if bearing > 330 || bearing < 30 {
            return "Nord"
        } else if bearing > 30 && bearing < 75 {
            return "Nord Est"
        } else if bearing > 75 && bearing < 120 {
            return "Est"
        } else if bearing > 120 && bearing < 150 {
            return "Sud Est"
        } else if bearing > 150 && bearing < 210 {
            return "Sud"
        } else if bearing > 210 && bearing < 240 {
            return "Sud Ouest"
        } else if bearing > 240 && bearing < 300 {
            return "Ouest"
        } else if bearing > 300 && bearing < 330 {
            return "Nord Ouest"
        }
        return "NUL/20"
    }

    func updateFields() {
        min.text = "❄️ \(Int(self.dailyForecast[0].temperatureLow)) °F"
        max.text = "🔥 \(Int(self.dailyForecast[0].temperatureHigh)) °F"
        icon.image = UIImage(named: self.hourlyForecast[self.current].icon)
        temp.text = "\(Int(self.hourlyForecast[self.current].temperature)) °F"
        windSpeed.text = "\(Int(self.hourlyForecast[self.current].windSpeed))km/h"
        windDir.text = "Vent \(bearingToDistance(bearing: Int(self.hourlyForecast[self.current].pressure)))"
        pressure.text = "\(Int(self.hourlyForecast[self.current].pressure))hPa"
        humidity.text = "\(Int(self.hourlyForecast[self.current].humidity * 100))%"
    }
}

