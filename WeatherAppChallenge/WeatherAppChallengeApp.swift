//
//  WeatherAppChallengeApp.swift
//  WeatherAppChallenge
//
//  Created by Juan Fanjul Bravo on 29/08/2022.
//

import SwiftUI

@main
struct WeatherAppChallengeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
