//
//  Forcast.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import Foundation

struct ForecastResponse: Codable {
    let dailyForecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct Forecast: Codable, Identifiable {
    var id: String? = UUID().uuidString
    let date: String
    let temperature: Temperature
    let day: WeatherPhrase
    let night: WeatherPhrase
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "Date"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
    }
    
    struct Temperature: Codable {
        let minimum: TemperatureValue
        let maximum: TemperatureValue
        
        enum CodingKeys: String, CodingKey {
            case minimum = "Minimum"
            case maximum = "Maximum"
        }
    }
    
    struct WeatherPhrase: Codable {
        let iconPhrase: String
        
        enum CodingKeys: String, CodingKey {
            case iconPhrase = "IconPhrase"
        }
    }
}

extension Forecast {
    static func mock() -> Forecast {
        return Forecast(date: "2020-11-23T07:00:00-08:00",
                        temperature: Forecast.Temperature(minimum: TemperatureValue(value: 71, unit: "F"),
                                                          maximum: TemperatureValue(value: 86, unit: "F")),
                        day: .init(iconPhrase: "Partly Sunny"),
                        night: .init(iconPhrase: "Partly Cloudy"))
    }
}
