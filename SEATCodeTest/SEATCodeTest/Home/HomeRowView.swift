//
//  HomeRowView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI

struct HomeRowView: View {
    let tripResult: TripModel
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .bottom) {
                Text(tripResult.description)
                    .font(.headline)
                Spacer()
                Text(tripResult.status.displayName())
                    .foregroundColor(tripResult.status.textColor())
                    .font(.footnote)
            }
            Text(String.localizedStringWithFormat(NSLocalizedString("driver", comment: ""), tripResult.driverName))
                .font(.footnote)
            Text("Schedule: \(dateFormatter.string(from: tripResult.startTime)) - \(dateFormatter.string(from: tripResult.endTime))")
                .font(.footnote)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeRowView(tripResult: .mock)
}
