//
//  ContentView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI
import GameKit

struct ContentView: View {
    @State private var isAuthenticated = false
    @State private var showLeaderboard = false

    var body: some View {
        NavigationView {
            VStack {
                if isAuthenticated {
                    //OnboardingView()
                    MainView()
                } else {
                    Image(.launchScreen)
                        .ignoresSafeArea()
                }
            }
            .onAppear(perform: authenticateUser)
        }
    }

    func authenticateUser() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                isAuthenticated = true
            } else {
                isAuthenticated = false
                if let error = error {
                    print("Authentication failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct GameCenterViewControllerWrapper: UIViewControllerRepresentable {
    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        var parent: GameCenterViewControllerWrapper

        init(parent: GameCenterViewControllerWrapper) {
            self.parent = parent
        }

        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            let gameCenterViewController = GKGameCenterViewController()
            gameCenterViewController.gameCenterDelegate = context.coordinator
            gameCenterViewController.viewState = .leaderboards
            viewController.present(gameCenterViewController, animated: true, completion: nil)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // 업데이트 로직이 필요하지 않음
    }
}

#Preview {
    ContentView()
}
