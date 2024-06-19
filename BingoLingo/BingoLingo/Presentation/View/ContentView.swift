//
//  ContentView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameCenterManager = GameCenterManager.shared

    var body: some View {
        NavigationView {
            VStack {
                if gameCenterManager.isAuthenticated {
                    OnboardingView()
                } else {
                    Image("LaunchScreen")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            gameCenterManager.authenticateLocalPlayer()
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
