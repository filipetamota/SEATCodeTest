//
//  HomeTableView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import Foundation
import SwiftUI

struct HomeTableView: View {
    @ObservedObject var viewModel = TripsViewModel()
    
    var body: some View {
        ZStack {
            LoadingIndicatorView()
                .show(viewModel.showLoadingIndicator)
            List() {
                ForEach(viewModel.tripsResult.trips, id: \.self) { tripResult in
                 //   NavigationLink(destination: DetailView(trip: tripResult)) {
                    Button(action: {
                        self.viewModel.selectTrip(tripId: tripResult.tripId)
                        self.viewModel.getStopInfo()
                    }) {
                        HomeRowView(tripResult: tripResult)
                    }
                    .listRowBackground(viewModel.tripsResult.selectedTrip == tripResult.tripId ? Color.gray : Color.white)
                        
                  //  }
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(NSLocalizedString("my_trips_title", comment: ""))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
            .toolbarBackground(Color(UIColor.darkGray), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .alert(NSLocalizedString("error", comment: ""), isPresented: $viewModel.showError) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
            .overlay(Group {
                if viewModel.tripsResult.trips.isEmpty {
                    Text(NSLocalizedString("no_trips", comment: ""))
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("PlaceholderText")
                }
            })
            .onAppear(perform: {
                viewModel.getTrips()
            })
        }
    }
}

#Preview {
    HomeTableView()
}
