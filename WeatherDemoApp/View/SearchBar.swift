//
//  SearchBar.swift
//  WeatherDemoApp
//
//  Created by Nicholas Boleky on 2/5/21.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var locationService: LocationService
    @State private var searchText: String = ""
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Enter location", text: $searchText, onEditingChanged: { _ in}, onCommit: {
                locationService.searchQuery = searchText
            })
            .onChange(of: searchText) {
                if $0.isEmpty {
                    locationService.searchQuery = ""
                }
            }
            .foregroundColor(.primary)
            
            Button(action: {
                self.searchText = ""
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchText == "" ? 0 : 1)
            })
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .foregroundColor(.gray)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(10.0)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(locationService: LocationService())
    }
}
