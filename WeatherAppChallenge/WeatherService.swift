//
//  WeatherService.swift
//  WeatherAppChallenge
//
//  Created by Juan Fanjul Bravo on 29/08/2022.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
  
  private let API_KEY = "66e5400346aff5a9b8896a515941262b"
  private var completionHandler: ((Weather) -> Void)?
  
  public func loadWeatherData(forCityName: String, _ completionHandler: @escaping((Weather) -> Void)) {
    self.completionHandler = completionHandler
    makeDataRequest(forCityName: forCityName)
  }
  //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
  private func makeDataRequest(forCityName: String) {
    guard let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(forCityName)&appid=66e5400346aff5a9b8896a515941262b&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
    guard let url = URL(string: urlString) else {return}
    print(urlString)
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil, let data = data else {return}

      if let response = try? JSONDecoder().decode(ApiResponse.self, from: data) {
        let weather = Weather(response: response)
        self.completionHandler?(weather)
      }
    }.resume()
  }
}


struct ApiResponse: Decodable  {
  let name: String
  let main: ApiMain
  let weather: [APIWeather]
}

struct ApiMain: Decodable {
  let temperature: Double
  
  enum CodingKeys: String, CodingKey {
    case temperature = "temp"
  }
}

struct APIWeather: Decodable {
  let description: String
  let iconIndicator: String
  
  
  enum CodingKeys: String, CodingKey {
    case description
    case iconIndicator = "main"
  }
}
