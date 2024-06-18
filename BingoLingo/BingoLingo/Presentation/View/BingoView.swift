//
//  BingoView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct BingoView: View {
    @Binding var game: BingoGame
    @Binding var bingoCount: Int
    @Binding var markedCount: Int
    @State private var selectedRow: Int? = nil
    @State private var selectedCol: Int? = nil
    @State private var showBingoCompletion = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { col in
                        NavigationLink(
                            destination: BingoDetailView(
                                game: $game,
                                bingoCount: $bingoCount,
                                markedCount: $markedCount,
                                row: row,
                                col: col
                            ),
                            isActive: Binding(
                                get: { selectedRow == row && selectedCol == col },
                                set: { isActive in
                                    if !isActive {
                                        selectedRow = nil
                                        selectedCol = nil
                                    }
                                }
                            )
                        ) {
                            BingoCellView(
                                game: $game,
                                bingoCount: $bingoCount,
                                markedCount: $markedCount,
                                row: row,
                                col: col,
                                selectedRow: $selectedRow,
                                selectedCol: $selectedCol,
                                showBingoCompletion: $showBingoCompletion
                            )
                            .buttonStyle(PlainButtonStyle())
                            .onTapGesture {
                                selectedRow = row
                                selectedCol = col
                            }
                        }
                    }
                }
            }
            .onAppear {
                showBingoCompletion = false
            }
        }
        .overlay(
            Group {
                if showBingoCompletion {
                    Image("imgBingo")
                }
            }
        )
    }
}

struct BingoCellView: View {
    @Binding var game: BingoGame
    @Binding var bingoCount: Int
    @Binding var markedCount: Int
    let row: Int
    let col: Int
    @Binding var selectedRow: Int?
    @Binding var selectedCol: Int?
    @Binding var showBingoCompletion: Bool
    
    @State private var isBingoPressed = false
    
    var body: some View {
        VStack {
            BingoCellImageView(game: $game, isBingoPressed: $isBingoPressed, row: row, col: col)
        }
        .frame(width: 71, height: 76)
        .onTapGesture {
            HapticManager.shared.notification(type: .success)
            selectedRow = row
            selectedCol = col
        }
        .onLongPressGesture(
            minimumDuration: 0.1,
            pressing: { pressing in
                withAnimation {
                    isBingoPressed = pressing
                }
            },
            perform: {
                print("Long press completed")
            }
        )
    }
}


struct BingoCellImageView: View {
    @Binding var game: BingoGame
    @Binding var isBingoPressed: Bool
    
    let row: Int
    let col: Int
    
    var body: some View {
        ZStack {
            Image(isBingoPressed ? "btnBingo3" : (game.board[row][col] ? "btnBingo2" : "btnBingo1"))
                .resizable()
                .frame(width: 71, height: 76)
            
            VStack(spacing: 0) {
                if game.board[row][col] {
                    Text("CLEAR")
                        .font(Font.custom("DungGeunMo", size: 12))
                        .foregroundStyle(Color.clearPink)
                        .padding(.bottom, 6)
                }
                
                Text(game.restaurants[row][col].name)
                    .font(Font.custom("DungGeunMo", size: 10))
                    .lineSpacing(3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(game.board[row][col] ? Color.white : Color.text)
                    .padding(.bottom, 2)
            }
        }
    }
}
