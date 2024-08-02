//
//  SplashView.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 07.06.24.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel = SplashViewModel()
    
    var body: some View {
        if viewModel.isDataLoaded {
            ContentView()
        }
        else {
            ZStack {
                Image(.splashIcon)
            }
            .background(.customBackground)
            .onAppear {
                viewModel.viewAppeared()
            }
        }
    }
}

#Preview {
    SplashView()
}
