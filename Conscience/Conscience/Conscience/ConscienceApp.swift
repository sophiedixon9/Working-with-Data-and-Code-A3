//
//  ConscienceApp.swift
//  Conscience
//
//  Created by Sophie Dixon on 18/10/2022.
//

import SwiftUI

@main
struct ConscienceApp: App {
    @StateObject var dataModel = DataModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SplashScreenview()
                PhotoGridView()
            }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}
