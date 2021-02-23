//
//  LocationService.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/5/21.
//

import Foundation

class LocationService: ObservableObject {
    @Published var searchResults = [Location]()
    @Published var selectedLocation: Location? {
        didSet {
            if let _ = selectedLocation {
                getCurrentCondition()
                getHourlyForecasts()
                getForcasts()
            }
        }
    }
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyForecasts = [CurrentWeatherHourly]()
    @Published var forecasts = [Forecast]()

    var searchQuery = "" {
        didSet {
            if searchQuery.isEmpty {
                searchResults.removeAll()
            }
            else {
            searchLocation()
        }
        }
    }

    private func searchLocation() {
        searchResults = []
        
        guard let query = searchQuery
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=\(Config.AccuWeather.apiKey)&q=\(query)")
        else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode([Location].self, from: data)
                
                DispatchQueue.main.async {
                    self?.searchResults = response
                }
            }
            catch let error {
                print("Error parsing location \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getCurrentCondition() {
        guard let query = selectedLocation,
              let url = URL (string: "http://dataservice.accuweather.com/currentconditions/v1/\(query.key)?apikey=\(Config.AccuWeather.apiKey)")
        else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode([CurrentWeather].self, from: data).first
                
                DispatchQueue.main.async {
                    self?.currentWeather = response
                }
            }
            catch let error {
                print("🔥 Error parsing current weather: \(error.localizedDescription)")
            }
        }.resume()
    }
    private func getHourlyForecasts() {
        guard let query = selectedLocation,
              let url = URL (string: "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(query.key)?apikey=\(Config.AccuWeather.apiKey)")
        else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode([CurrentWeatherHourly].self, from: data)
                
                DispatchQueue.main.async {
                    self?.hourlyForecasts = response
                }
            }
            catch let error {
                print("🔥 Error parsing current weather: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func getForcasts() {
        guard let query = selectedLocation,
              let url = URL (string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(query.key)?apikey=\(Config.AccuWeather.apiKey)")
        else { return }
        
        let request = URLRequest(url: url)
        print(url)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
                let forecasts = response.dailyForecasts
                
                DispatchQueue.main.async {
                    self?.forecasts = forecasts
                }
            }
            catch let error {
                print("🔥 Error parsing 5 day forcasts: \(error.localizedDescription)")
            }
        }.resume()
    }
}
