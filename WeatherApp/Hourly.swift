//
//  Weather.swift
//  WeatherApp
//
//  Created by Cabanes on 14/09/2019.
//  Copyright © 2019 Cabanes. All rights reserved.
//

import Foundation

struct Hourly {
    let icon: String
    let time: Double
    let temperature: Double
    let windSpeed: Double
    let windBearing: Int
    let humidity: Double
    let pressure: Double

    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }

    init(json: [String:Any]) throws {
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("The key icon is missing")}
        guard let time = json["time"] as? Double else {throw SerializationError.missing("The key time is missing")}
        guard let temperature = json["temperature"] as? Double else {throw SerializationError.missing("The key temperature is missing")}
        guard let windSpeed = json["windSpeed"] as? Double else {throw SerializationError.missing("The key windSpeed is missing")}
        guard let windBearing = json["windBearing"] as? Int else {throw SerializationError.missing("The key windBearing is missing")}
        guard let humidity = json["humidity"] as? Double else {throw SerializationError.missing("The key humidity is missing")}
        guard let pressure = json["pressure"] as? Double else {throw SerializationError.missing("The key pressure is missing")}

        self.icon = icon
        self.time = time
        self.temperature = temperature
        self.windSpeed = windSpeed
        self.windBearing = windBearing
        self.humidity = humidity
        self.pressure = pressure
    }
}
