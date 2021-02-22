//
//  CurrentWeather.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import Foundation

struct CurrentWeather: Codable {
    let weatherText: String
    let isDayTime: Bool
    let temperature: TemperatureUnit
    
    enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
    }
    struct TemperatureUnit: Codable {
        let metric: TemperatureValue
        let imperial: TemperatureValue
        
        enum CodingKeys: String, CodingKey {
            case metric = "Metric"
            case imperial = "Imperial"
        }
    }
}
extension CurrentWeather {
    static func mock() -> CurrentWeather {
        return CurrentWeather(weatherText: "Mostly Sunny",
                              isDayTime: true,
                              temperature: CurrentWeather.TemperatureUnit(metric: TemperatureValue(value: 55, unit: "F"),
                                                                          imperial: TemperatureValue(value: 12.8, unit: "C")))
    }
}

struct TemperatureValue: Codable {
    let value: Double
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}
