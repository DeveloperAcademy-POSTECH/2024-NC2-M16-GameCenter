//
//  GameCenterManager.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/19/24.
//

import GameKit

class GameCenterManager: NSObject, GKGameCenterControllerDelegate, ObservableObject {
    static let shared = GameCenterManager()

    // 인증 상태를 관리하는 속성
    @Published var isAuthenticated = false
    private var authenticating = false

    override init() {
        super.init()
    }

    // 로컬 플레이어 인증 메서드
    func authenticateLocalPlayer() {
        // 이미 인증 중이면 중복 실행 방지
        guard !authenticating else { return }
        authenticating = true

        // 인증 핸들러 설정
        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, error in
            guard let self = self else { return }
            self.authenticating = false
            if let error = error {
                print("Authentication failed: \(error.localizedDescription)")
                self.isAuthenticated = false
            } else if let viewController = viewController {
                // 로그인 뷰 컨트롤러가 필요한 경우 표시
                print("Game Center login required")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(viewController, animated: true, completion: nil)
                }
            } else if GKLocalPlayer.local.isAuthenticated {
                // 인증 성공
                self.isAuthenticated = true
                print("Player authenticated")
            } else {
                // 인증 실패
                self.isAuthenticated = false
                print("Player not authenticated")
            }
        }
    }

    // (순위표를 위한) 게임센터 점수 저장 메서드
    func reportBingoCount(_ count: Int) {
        // 인증 여부 확인
        guard isAuthenticated else {
            print("Player is not authenticated")
            return
        }

        // 점수 객체 생성 및 설정
        let score = GKScore(leaderboardIdentifier: "001")
        score.value = Int64(count)

        // 점수 저장
        GKScore.report([score]) { error in
            if let error = error {
                print("Failed to report score: \(error.localizedDescription)")
            } else {
                print("Score reported successfully")
            }
        }
    }

    // 목표(업적) 달성 메서드
    func reportAchievement(identifier: String, percentComplete: Double) {
        // 인증 여부 확인
        guard isAuthenticated else {
            print("Player is not authenticated")
            return
        }

        // 목표 객체 생성 및 설정
        let achievement = GKAchievement(identifier: identifier)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = true

        // 목표 달성 보고
        GKAchievement.report([achievement]) { error in
            if let error = error {
                print("Failed to report achievement: \(error.localizedDescription)")
            } else {
                print("Achievement reported successfully")
            }
        }
    }

    // 순위표 보기 메서드
    func showLeaderboard() {
        let leaderboardID = "001"
        let viewController = GKGameCenterViewController(state: .leaderboards)
        viewController.gameCenterDelegate = self
        viewController.leaderboardIdentifier = leaderboardID

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.present(viewController, animated: true, completion: nil)
            }
        }
    }

    // 달성한 목표 보기 메서드
    func showAchievements() {
        let viewController = GKGameCenterViewController(state: .achievements)
        viewController.gameCenterDelegate = self

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.present(viewController, animated: true, completion: nil)
            }
        }
    }

    // Game Center 뷰 컨트롤러 닫기 핸들러
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
