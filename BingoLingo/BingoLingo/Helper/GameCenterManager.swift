//
//  GameCenterManager.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/19/24.
//

import GameKit
import Combine

class GameCenterManager: NSObject, GKGameCenterControllerDelegate, ObservableObject {
    static let shared = GameCenterManager()

    @Published var isAuthenticated = false
    private var authenticating = false

    override init() {
        super.init()
        authenticateLocalPlayer()
    }

    func authenticateLocalPlayer() {
        guard !authenticating else { return }
        authenticating = true

        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, error in
            guard let self = self else { return }
            if let error = error {
                print("Authentication failed: \(error.localizedDescription)")
                self.isAuthenticated = false
            } else if let viewController = viewController {
                print("Game Center login required")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(viewController, animated: true, completion: nil)
                }
            } else if GKLocalPlayer.local.isAuthenticated {
                self.isAuthenticated = true
                print("Player authenticated")
            } else {
                self.isAuthenticated = false
                print("Player not authenticated")
            }
            self.authenticating = false
        }
    }

    func reportBingoCount(_ count: Int) {
        guard isAuthenticated else {
            print("Player is not authenticated")
            return
        }

        let score = GKScore(leaderboardIdentifier: "001")
        score.value = Int64(count)

        GKScore.report([score]) { error in
            if let error = error {
                print("Failed to report score: \(error.localizedDescription)")
            } else {
                print("Score reported successfully")
            }
        }
    }

    func showLeaderboard() {
        guard isAuthenticated else {
            print("Player is not authenticated")
            return
        }

        let viewController = GKGameCenterViewController(state: .leaderboards)
        viewController.gameCenterDelegate = self
        viewController.leaderboardIdentifier = "001"

        // Present the leaderboard view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(viewController, animated: true, completion: nil)
        }
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
