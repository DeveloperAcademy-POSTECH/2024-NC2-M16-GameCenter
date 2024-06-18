//
//  GameCenterManager.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/19/24.
//

import GameKit

class GameCenterManager: NSObject, GKGameCenterControllerDelegate {
    static let shared = GameCenterManager()

    override init() {
        super.init()
        authenticateLocalPlayer()
    }

    func authenticateLocalPlayer() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let error = error {
                print("Authentication failed: \(error.localizedDescription)")
            } else if let viewController = viewController {
                // Show authentication view controller if needed
                // Example: UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true, completion: nil)
            } else if GKLocalPlayer.local.isAuthenticated {
                print("Player authenticated")
            } else {
                print("Player not authenticated")
            }
        }
    }

    func reportBingoCount(_ count: Int) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Player is not authenticated")
            return
        }

        let score = GKScore(leaderboardIdentifier: "your_leaderboard_identifier")
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
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = self
        viewController.viewState = .leaderboards
        viewController.leaderboardIdentifier = "001"
        // Example: UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
