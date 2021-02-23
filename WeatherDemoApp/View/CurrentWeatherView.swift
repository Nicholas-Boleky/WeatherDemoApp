//
//  CurrentWeatherView.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import SwiftUI

struct CurrentWeatherView: View {
    var city: String
    var weather: CurrentWeather
    var hiLoForecast: Forecast?
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(city)
                .font(.custom("Helvetica-Neue", size: 30))
            Text(weather.weatherText)
                .font(.callout)
            
            Spacer()
            
            Text(Helper.temperatureDisplay(value: weather.temperature.imperial.value, unit: .fahrenheit) + weather.temperature.imperial.unit)
                .font(.custom("HelveticaNeue-Light", size: 60))
            
            if let forecast = hiLoForecast {
                Text("H:\(Helper.temperatureDisplay(value: forecast.temperature.maximum.value, unit: .fahrenheit)) L: \(Helper.temperatureDisplay(value: forecast.temperature.minimum.value, unit: .fahrenheit))")
                    .font(.callout)
            }
            Spacer()
        }
        .frame(height: 160)
        
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(city: "Denver", weather: CurrentWeather.mock())
    }
}
