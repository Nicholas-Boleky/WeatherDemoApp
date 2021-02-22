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
}
