//
//  ContentView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            TripsView()
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (_, _) in }
        }
    }
}

#Preview {
    ContentView()
}
