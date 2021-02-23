//
//  CurrentWeather.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import Foundation

enum IconType: String {
    case sunny
    case partlySunny
    case partlyCloudy
    case rain
    case clear
    case snow
    case unknown
}

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

struct CurrentWeatherHourly: Codable, Identifiable {
    var id: String? = UUID().uuidString
    let dateTime: String
    let iconPhrase: String
    let temperature: TemperatureValue
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateTime = "DateTime"
        case iconPhrase = "IconPhrase"
        case temperature = "Temperature"
    }
    
    var timeStr: String {
        let dateTime = self.toDate(from: self.dateTime)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        
        let hourString = formatter.string(from: dateTime)
        
        return hourString
    }
    
    func toDate(from dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date = formatter.date(from: String(dateStr.dropLast(6)))
        
        return date ?? Date()
    }
    
    static func mock() -> CurrentWeatherHourly {
        return CurrentWeatherHourly(dateTime: "2020-11-23T07:00:00-8:00", iconPhrase: "Clear", temperature: TemperatureValue(value: 62, unit: "F"))
    }
}
