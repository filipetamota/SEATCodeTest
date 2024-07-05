//
//  HomeTableView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit
import Polyline

struct TripsView: View {
    @ObservedObject var viewModel = TripsViewModel()
    @State private var selectedTrip: TripModel?
    @State private var showPopover = false
    @State private var position = MapCameraPosition.region(defaultRegion)
    
    private static let defaultRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.390205, longitude: 2.154007), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    var body: some View {
        VStack {
            mapView
            ZStack {
                LoadingIndicatorView()
                    .show(viewModel.showLoadingIndicator)
                List() {
                    ForEach(viewModel.tripsResult, id: \.self) { tripResult in
                        Button(action: {
                            self.selectedTrip = tripResult
                            centerInLocation(region: tripResult.tripRegion())
                        }) {
                            TripsTableRowView(tripResult: tripResult)
                        }
                        .listRowBackground(selectedTrip?.tripId == tripResult.tripId ? Color.gray : Color.white)
                    }
                }
                .listStyle(.plain)
                .overlay(Group {
                    if viewModel.tripsResult.isEmpty {
                        Text(NSLocalizedString("no_trips", comment: ""))
                            .multilineTextAlignment(.center)
                            .accessibilityIdentifier("PlaceholderText")
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(NSLocalizedString("my_trips_title", comment: ""))
                        .fontWeight(.bold)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: FormView()) {
                        Image(systemName: "exclamationmark.bubble")
                            .tint(Color.black)
                    }
                }
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image(systemName: "xmark.square")
                        .tint(Color.black)
                        .onTapGesture {
                            selectedTrip = nil
                            centerInLocation()
                        }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .alert(NSLocalizedString("error", comment: ""), isPresented: $viewModel.showError) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
            .onAppear(perform: {
                viewModel.getTrips()
            })
        }
    }
    
    var mapView: some View {
        Map(position: $position) {
            if let selectedTrip = selectedTrip {
                Annotation(NSLocalizedString("origin_text", comment: ""), coordinate: selectedTrip.origin.point.coordinate2D()) {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 30, height: 30)
                        Text("O")
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                }
                Annotation(NSLocalizedString("destination_text", comment: ""), coordinate: selectedTrip.destination.point.coordinate2D()) {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 30, height: 30)
                        Text("D")
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                }
                
                if let stops = selectedTrip.stops {
                    ForEach(stops, id: \.self) { stop in
                        if
                            let id = stop.id,
                            let point = stop.point
                        {
                            Annotation("Stop \(id)", coordinate: point.coordinate2D()) {
                                ZStack {
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 30, height: 30)
                                    Text("S")
                                        .bold()
                                        .foregroundStyle(Color.white)
                                }
                                .onTapGesture {
                                    showPopover.toggle()
                                }
                            }
                        }
                    }
                }
                if let polyline = Polyline(encodedPolyline: selectedTrip.route).mkPolyline {
                    MapPolyline(polyline)
                        .stroke(.blue, lineWidth: 5)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 450)
        .sheet(isPresented: $showPopover) {
            popupView
                .presentationDetents([.height(200)])
                .presentationDragIndicator(.visible)
        }
    }
    
    private var stopInfo: StopModel {
        viewModel.stopInfoResult
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    var popupView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(String.localizedStringWithFormat(NSLocalizedString("line_text", comment: ""), stopInfo.tripId))
                    .font(.headline)
                Spacer()
                Text(String.localizedStringWithFormat(NSLocalizedString("time_text", comment: ""), dateFormatter.string(from: stopInfo.stopTime)))
                    .font(.headline)
            }
            Text(stopInfo.address)
                .font(.title)
            Text(String.localizedStringWithFormat(NSLocalizedString("ticket_price_text", comment: ""), stopInfo.price.formatted(.currency(code: "EUR"))))
                .font(.footnote)
        }
        .padding()
        .onAppear {
            viewModel.getStopInfo()
        }
    }
    
    func centerInLocation(region: MKCoordinateRegion = TripsView.defaultRegion) {
        position = MapCameraPosition.region(region)
    }
    
}

#Preview {
    TripsView()
}
