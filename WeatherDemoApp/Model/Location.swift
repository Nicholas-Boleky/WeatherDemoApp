//
//  Location.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/5/21.
//

import Foundation

struct Location: Codable, Identifiable {
    var id: String? = UUID().uuidString
    let key: String
    let localizedName: String
    let country: Country
    let administrativeArea: State
    
    enum CodingKeys: String, CodingKey {
        case id
        case key = "Key"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
    
    
    struct Country: Codable {
        let localizedName: String
        
        enum CodingKeys: String, CodingKey {
            case localizedName = "LocalizedName"
        }
    }
    
    struct State: Codable {
        let localizedName: String
        
        enum CodingKeys: String, CodingKey {
            case localizedName = "LocalizedName"
        }
    }
}

extension Location {
    static func mock() -> Location {
        return Location(key: "999999", localizedName: "Denver", country: Location.Country(localizedName: "United States"), administrativeArea: Location.State(localizedName: "Colorado"))
    }
}
