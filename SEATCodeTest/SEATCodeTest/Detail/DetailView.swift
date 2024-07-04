//
//  DetailView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI

struct DetailView: View {
    let trip: TripModel
    
    var body: some View {
        VStack {
            Text("Detail")
            Text(trip.description)
        }
    }
}

#Preview {
    DetailView(trip: .mock)
}
