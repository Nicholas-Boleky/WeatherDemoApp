//
//  Helper.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import Foundation
 
class Helper {
    static func temperatureDisplay(value: Double, unit: UnitTemperature) -> String {
        let measurement = Measurement(value: value, unit: unit)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .temperatureWithoutUnit
        
        return formatter.string(from: measurement)
    }
    
    static func day(from dateStr: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "EEEE"
            let day = formatter.string(from: date)
            
            return day
        }
        return ""
    }
    static func iconName(phrase: String) -> String {
        let iconName: String
        if let type = IconType(rawValue: phrase) {
            return type.rawValue
        }
        if phrase.lowercased().contains("sunny") {
            iconName = "partlySunny"
        }
        else if phrase.lowercased().contains("cloudy") {
            iconName = "partlyCloudy"
        }
        else if phrase.lowercased().contains("clear") {
            iconName = "clear"
        }
        else {
            iconName = phrase.lowercased()
        }
        if let type = IconType(rawValue: iconName) {
            return type.rawValue
        }
        return IconType.unknown.rawValue
    }
}
