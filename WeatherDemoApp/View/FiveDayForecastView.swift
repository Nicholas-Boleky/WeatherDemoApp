//
//  FiveDayForecastView.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/22/21.
//

import SwiftUI

struct FiveDayForecastView: View {
    var forecasts: [Forecast]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(forecasts, id: \.date) { forecast in
                HStack(alignment: .center, spacing: 10) {
                    Text(Helper.day(from: forecast.date))
                        .font(.title3)
                        .frame(width: 110, alignment: .leading)
                    Spacer()
                    
                    Image(Helper.iconName(phrase: forecast.day.iconPhrase))
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Text("\(Int(forecast.temperature.maximum.value))")
                            .frame(width: 30, alignment: .leading)
                        Text("\(Int(forecast.temperature.minimum.value))")
                            .frame(width: 30, alignment: .leading)
                            .opacity(0.5)
                    }
                    .frame(width: 100, alignment: .trailing)
                }
            }
        }
        .padding()
    }
}

struct FiveDayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        FiveDayForecastView(forecasts: [Forecast.mock()])
    }
}
