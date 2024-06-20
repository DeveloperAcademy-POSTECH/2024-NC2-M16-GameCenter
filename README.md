# 2024-NC2-M16-Game-Center
![게임센터](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/71c9566b-02d0-411b-913b-35783ac5ec6e)
</br>

##  Authors 
|[강희주(Rad)](https://github.com/heejukang)|[김유빈(Nini)](https://github.com/ubeeni)|
|:---:|:---:|
|🎨 **디자인** 🎨| 🍎 **테크** 🍎|
|![래드](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/dae1a14a-3e95-40f4-bd9f-e88ac52b9aab)|![니니](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-M10-Sandwich/assets/69234788/5c9f8054-dd60-4a9d-a2fa-af6649023428)|
</br>

## 🎥 Youtube Link

</br>

## 💡 About Game Center
![Game Center 소개](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/297d7f39-882a-4297-8fc1-69108af643f1)

</br>

## 🎯 What we focus on?
#### 멀티 플레이어(친구), 순위표(리더보드), 목표 달성(업적)
![Focus on](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/a24583cd-e4f8-493f-8cd4-e455dc321b03)

</br>

## 💼 Use Case
#### 맛집 탐방이라는 주제를 게이미피케이션을 적용한 빙고를 통해 서비스를 제공하며, 게임센터의 기능을 통해 서버를 대신하여 사용자간의 경쟁과 재참여를 유도한다.
![Use Case](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/683683dc-f45d-4d6c-8e47-ad9afd83a0dc)
![Use Case2](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/d2879046-491a-44a3-9173-89dd17a68a71)

</br>

## 🖼️ Prototype
</div>
<div style="display: flex; flex-direction: column;" align="center" >
  <a href="https://apps.apple.com/kr/app/%EB%B9%99%EA%B3%A0%EB%A7%81%EA%B3%A0/id6504380885">
    <img src="https://user-images.githubusercontent.com/81340603/204947353-18c33fe9-c49b-443a-b1e2-7cf9a85bb91b.png" width=180px />
  </a>
  <p3>&nbsp;&nbsp;&nbsp;</p3>
</div>
<img width="2169" alt="프로토타입_메인" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/1b088c77-d24e-4d3e-9266-cc064e6298fe">
<img width="2169" alt="프로토타입_빙고" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/bb8400ae-8107-49a2-ba2f-ac4ee4c5a268">
<img width="2169" alt="프로토타입_게임센터" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/585aa602-3daa-45db-a546-33ba756d7df8">

</br>

## 🕹️ Demo Video
https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M16-GameCenter/assets/69234788/112ef59a-924f-41be-9d6f-18b7b3188c5e

</br>

## 🛠️ About Code
#### 1️⃣ `GameKit`을 사용하여 현재 디바이스의 게임 센터 플레이어 인증 
-> 인증되지 않은 경우, 게임 센터 로그인 화면을 표시하여 플레이어가 로그인할 수 있도록 해줌

```swift
import GameKit
```

```swift
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
                print("Authentication failed: \\(error.localizedDescription)")
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
```

#### 2️⃣ Game Center 순위표(리더보드)에 사용자의 점수 보내기

```swift
// (순위표를 위한) 게임센터 점수 저장 메서드
    func reportBingoCount(_ count: Int) {
        // 인증 여부 확인
        guard isAuthenticated else {
            print("Player is not authenticated")
            return
        }

        let score = GKLeaderboardScore()
        score.leaderboardID = "순위표 ID"
        // 순위표에 부여해야 하는 영숫자 식별자 - 이 ID는 100자로 제한, 영구적으로 설정되며 나중에 변경할 수 없음
        score.value = Int(count)

        // 점수 저장
        GKLeaderboard.submitScore(score.value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [score.leaderboardID]) { error in
            if let error = error {
                print("Failed to report score: \\(error.localizedDescription)")
            } else {
                print("Score reported successfully")
            }
        }
    }
```

#### 3️⃣ 목표 달성을 확인하기 위한 데이터 전달
```swift
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
                print("Failed to report achievement: \\(error.localizedDescription)")
            } else {
                print("Achievement reported successfully")
            }
        }
    }
```

#### 4️⃣ Game Center 순위표 보기
```swift
// 순위표 보기 메서드
    func showLeaderboard() {
        let leaderboardID = "순위표 ID"
        let viewController = GKGameCenterViewController(leaderboardID: leaderboardID, playerScope: .friendsOnly, timeScope: .allTime)
        viewController.gameCenterDelegate = self

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.present(viewController, animated: true, completion: nil)
            }
        }
    }
```
