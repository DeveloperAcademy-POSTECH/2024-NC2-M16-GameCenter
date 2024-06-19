//
//  MainView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct MainView: View {
    @State private var isAuthenticated = false
    @State private var showLeaderboard = false
    
    @State var game = BingoGame()
    @State private var bingoCount = 0
    @State private var markedCount = 0
    
    @State private var isPressed = false
    @State private var isMapPressed = false
    @State private var isRankPressed = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    VStack(spacing: 0) {
                        NavigationLinkWithHaptic(destination: MapView()) {
                            Image(isMapPressed ? .btnMap2 : .btnMap)
                        }
                        .onLongPressGesture(
                            minimumDuration: 0.1,
                            pressing: { pressing in
                                withAnimation {
                                    isMapPressed = pressing
                                }
                            },
                            perform: {
                                print("Long press completed")
                            }
                        )
                        
                        Text("다른 맵")
                          .font(Font.custom("Galmuri11", size: 12))
                          .foregroundStyle(.button)
                          .padding(.top, 8)
                    }
                    
                    ZStack {
                        Image(.imgTitle)
                        
                        Text("Lv1. 혼돈의 효자동")
                            .font(Font.custom("DungGeunMo", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.title)
                            .frame(width: 168, alignment: .top)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 0) {
                        Button(action: {
                            HapticManager.shared.notification(type: .success)
                            GameCenterManager.shared.showLeaderboard()
                            
                        }) {
                            Image(isRankPressed ? .btnRank2 : .btnRank)
                        }
                        .onLongPressGesture(
                            minimumDuration: 0.1,
                            pressing: { pressing in
                                withAnimation {
                                    isRankPressed = pressing
                                }
                            },
                            perform: {
                                print("Long press completed")
                            }
                        )
                        
                        Text("순위표")
                          .font(Font.custom("Galmuri11", size: 12))
                          .foregroundStyle(.button)
                          .padding(.top, 8)
                    }
                }
                
                HStack {
                    Text("도장 깨기")
                      .font(Font.custom("DungGeunMo", size: 14))
                      .foregroundStyle(.info)
                      .onAppear {
                          bingoCount = game.bingoCount()
                      }
                    
                    Image(imageForBMarkedCount(markedCount))
                        .padding(.horizontal, 6)
                    
                    ZStack {
                        Image(.imgGauge1)
                        
                        Text("\(markedCount) / 25")
                            .font(Font.custom("Galmuri11", size: 10))
                            .foregroundStyle(.count)
                    }
                }
                .padding(.top, 53)
                
                HStack {
                    Text("빙고 개수")
                      .font(Font.custom("DungGeunMo", size: 14))
                      .foregroundStyle(.info)
                      .onAppear {
                          bingoCount = game.bingoCount()
                      }
                    
                    Image(imageForRMarkedCount(bingoCount))
                        .padding(.horizontal, 6)
                    
                    ZStack {
                        Image(.imgGauge1)
                        
                        Text("\(bingoCount) / 12")
                            .font(Font.custom("Galmuri11", size: 10))
                            .foregroundStyle(.count)
                    }
                }
                .padding(.top, 12)
                
                BingoView(game: $game, bingoCount: $bingoCount, markedCount: $markedCount)
                    .padding(.top, 26)
                
                Spacer()

                Text("나만 아는 맛집이 있다면!")
                  .font(Font.custom("Galmuri11", size: 12))
                  .multilineTextAlignment(.center)
                  .foregroundStyle(.alarm)
                
                LinkWithHaptic(url: URL(string: "https://forms.gle/fWAAdZQwx3x91jLD6")!) {
                    Image(isPressed ? "btnSuggest2" : "btnSuggest1")
                }
                .onLongPressGesture(
                    minimumDuration: 0.1,
                    pressing: { pressing in
                        withAnimation {
                            isPressed = pressing
                        }
                    },
                    perform: {
                        print("Long press completed")
                    }
                )
                .padding(.top, 4)
                .padding(.bottom, 20)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if let loadedGame = UserDefaults.standard.loadBingoGame() {
                game = loadedGame
                bingoCount = game.bingoCount()
                markedCount = game.markedCount()
            }
        }
    }
    
    private func imageForBMarkedCount(_ count: Int) -> String {
        return "imgBGauge\(min(count, 25))"
    }
    
    private func imageForRMarkedCount(_ count: Int) -> String {
        return "imgRGauge\(min(count, 12))"
    }
}

#Preview {
    MainView()
}
