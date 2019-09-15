//
//  DailyData.swift
//  WeatherApp
//
//  Created by Gabriel on 15/09/2019.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation

struct API {
    static let basePath = "https://api.darksky.net/forecast/0a92bb57b798e6b1f5cf84b93902de62/"

    static func forecast (withLocation location: String, completion: @escaping ([Hourly], [Daily]) -> ()) {
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)

        let call = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            var hourlyForecast: [Hourly] = []
            var dailyForecast: [Daily] = []

            func getHourly(json: [String:Any]) {
                if let hourly = json["hourly"] as? [String:Any] {
                    if let hourlyData = hourly["data"] as? [[String:Any]] {
                        for dataPoint in hourlyData {
                            if let hourlyObject = try? Hourly(json: dataPoint) {
                                let date = Date(timeIntervalSince1970: hourlyObject.time)
                                if (Calendar.current.isDateInToday(date)) {
                                    hourlyForecast.append(hourlyObject)
                                }
                            }
                        }
                    }
                }
            }
            
            func getDaily(json: [String:Any]) {
                if let daily = json["daily"] as? [String:Any] {
                    if let dailyData = daily["data"] as? [[String:Any]] {
                        for dataPoint in dailyData {
                            if let dailyObject = try? Daily(json: dataPoint) {
                                if (dailyForecast.count < 4) {
                                    dailyForecast.append(dailyObject)
                                }
                            }
                        }
                    }
                }
            }

            if let data = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data, options:[]) as?  [String:Any] {
                        getHourly(json: json)
                        getDaily(json: json)
                    }
                } catch {
                    print(error.localizedDescription)
                }

                completion(hourlyForecast, dailyForecast)
            }
        }
        call.resume()
    }
}
