//
//  Daily.swift
//  WeatherApp
//
//  Created by Gabriel on 15/09/2019.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation

struct Daily {
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let time: Double
    
    enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
    }

    init(json: [String:Any]) throws {
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("The key icon is missing")}
        guard let temperatureHigh = json["temperatureHigh"] as? Double else {throw SerializationError.missing("The key temperatureHigh is missing")}
        guard let temperatureLow = json["temperatureLow"] as? Double else {throw SerializationError.missing("The key temperatureLow is missing")}
        guard let time = json["time"] as? Double else {throw SerializationError.missing("The key time is missing")}

        self.icon = icon
        self.temperatureHigh = temperatureHigh
        self.temperatureLow = temperatureLow
        self.time = time
    }
}
