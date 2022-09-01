//
//  ContentView.swift
//  WeatherAppChallenge
//
//  Created by Juan Fanjul Bravo on 29/08/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

  @ObservedObject var viewModel: WeatherviewModel
  @State var desiredCity: String = ""
  
    var body: some View {
      NavigationView {
        VStack() {
            HStack {
              
              TextField("Enter a city name", text: $desiredCity)
                .padding()
                .frame(width: 250)
                .background(Color.gray.opacity(0.3).cornerRadius(20))
                .foregroundColor(.blue)
                .font(.headline)
              
              Button("Search") {
                viewModel.refresh(forCityName: desiredCity)
              }
              .padding()
              .background(Color.blue.cornerRadius(20))
              .foregroundColor(.white)
              .font(.headline)
            }
            .offset(y: -70)
          
          VStack(spacing: 10){
            
            Text(viewModel.cityName)
              .font(.largeTitle)
              .italic()
            
            Text(viewModel.temperature)
              .font(.system(size: 50))
              .bold()
            
            Text(viewModel.iconDescriptor)
              .font(.system(size: 30))
            
            Text(viewModel.weatherDescription)
            
            
            Button("London") {
              viewModel.refresh(forCityName: "London")
            }
            
            Button("Paris") {
              viewModel.refresh(forCityName: "Paris")
            }
            
            Button("Barcelona") {
              viewModel.refresh(forCityName: "Barcelona")
            }
            
            Button("Rome") {
              viewModel.refresh(forCityName: "Rome")
            }
            
            Button("Yerba Buena, Tucumán") {
              viewModel.refresh(forCityName: "Yerba Buena")
            }
          }
          .offset(y: -60)
        }
        .navigationTitle("Weather app de Juan")
      }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(viewModel: WeatherviewModel(weatherService: WeatherService())).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
