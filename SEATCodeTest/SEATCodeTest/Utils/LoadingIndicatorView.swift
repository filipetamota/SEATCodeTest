//
//  LoadingIndicatorView.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    var body: some View {
        ProgressView()
            .controlSize(.extraLarge)
            .progressViewStyle(CircularProgressViewStyle())
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.black.opacity(0.2))
            .edgesIgnoringSafeArea(.all)
    }
}
