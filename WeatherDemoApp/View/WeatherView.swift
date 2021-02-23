//
//  WeatherView.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/2/21.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var locationService = LocationService()
    @State private var toggleSearchLocation = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack(alignment: .center) {
                    Image(locationService.currentWeather?.isDayTime ?? true ? "bgDay" : "bgNight")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)
                    VStack {
                        if let location = locationService.selectedLocation,
                           let weather = locationService.currentWeather {
                            CurrentWeatherView(city: location.localizedName,
                                               weather: weather,
                                               hiLoForecast: locationService.forecasts.first)
                            
                            Divider()
                                .background(Color.white)
                            
                            HourlyForecastView(hourlyForcasts: locationService.hourlyForecasts)
                            
                            Divider()
                                .background(Color.white)
                            
                            FiveDayForecastView(forecasts: locationService.forecasts)
                            
                            Spacer()
                        }
                        else {
                            VStack(alignment: .center, spacing: 20) {
                                Image(systemName: "thermometer")
                                    .resizable()
                                    .frame(width: 60, height: 100, alignment: .center)
                                
                                Text("Search for a city to display the weather")
                            }
                            .frame(width: geo.size.width)
                            
                            Spacer()
                        }
                    } //VStack
                    .foregroundColor(.white)
                    .navigationBarItems(trailing: Button(action: {
                        self.toggleSearchLocation.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }))//navigationBarItems search button
                }//NavigationView
                .sheet(isPresented: $toggleSearchLocation, content: {
                    SearchView(locationService: locationService)
                })
            }//NavigationView
        } //geoReader
    } //body View
} //View

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView()
        }
    }
}
