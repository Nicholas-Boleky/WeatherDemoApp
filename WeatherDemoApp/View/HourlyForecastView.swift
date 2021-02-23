//
//  HourlyForecastView.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import SwiftUI

struct HourlyForecastView: View {
    var hourlyForcasts: [CurrentWeatherHourly]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(hourlyForcasts, id: \.dateTime) { hourly in
                    VStack(alignment: .center, spacing: 5.0) {
                        Text(hourly.timeStr)
                        Image(Helper.iconName(phrase: hourly.iconPhrase))
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                        Text(Helper.temperatureDisplay(value: hourly.temperature.value, unit: .fahrenheit))
                    }
                }
            }
        }
        .frame(height: 100)
        .padding(.horizontal, 15)
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView(hourlyForcasts: [CurrentWeatherHourly.mock()])
    }
}
