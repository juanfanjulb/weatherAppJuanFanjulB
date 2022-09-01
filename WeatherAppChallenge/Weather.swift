//
//  Weather.swift
//  WeatherAppChallenge
//
//  Created by Juan Fanjul Bravo on 29/08/2022.
//

import Foundation

public struct Weather {
  let city: String
  let temperature: String
  let description: String
  let iconIndicator: String
  
  init(response: ApiResponse) {
    city = response.name
    temperature = "\(Int(response.main.temperature))"
    description = response.weather.first?.description ?? ""
    iconIndicator = response.weather.first?.iconIndicator ?? ""
  }
}
