//
//  WeatherViewModel.swift
//  WeatherAppChallenge
//
//  Created by Juan Fanjul Bravo on 01/09/2022.
//

import Foundation

private let defaultIconIndicator: String = "🌡"
private let iconIndicatorMap = [
  "Drizzle" : "🌧",
  "Rain" : "🌧",
  "ThunderStorm" : "⛈",
  "Snow" : "❄️",
  "Clear" : "🔆",
  "Clouds" : "☁️"
]

class WeatherviewModel: ObservableObject {
  @Published var cityName: String = "City Name"
  @Published var temperature: String = "--"
  @Published var weatherDescription: String = "--"
  @Published var iconDescriptor: String = defaultIconIndicator
  
  public let weatherService: WeatherService
  
  init(weatherService: WeatherService) {
    self.weatherService = weatherService
  }
  
  func refresh(forCityName: String)  {
    weatherService.loadWeatherData(forCityName: forCityName) {  weather in
      DispatchQueue.main.async {
        self.cityName = weather.city
        self.temperature = "\(weather.temperature)ºC"
        self.weatherDescription = weather.description.capitalized
        self.iconDescriptor = iconIndicatorMap[weather.iconIndicator] ?? defaultIconIndicator
      }
    }
  }
}
