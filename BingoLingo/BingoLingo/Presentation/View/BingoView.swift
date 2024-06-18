//
//  BingoView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

struct BingoGame {
    var board: [[Bool]]
    var restaurants: [[Restaurant]]
    var showBingoCompletion: Bool
    
    init() {
        self.board = Array(repeating: Array(repeating: false, count: 5), count: 5)
        self.restaurants = [
            [
                Restaurant(name: "인드라", location: "경북 포항시 남구 형산강북로 93", phone: "0507-1429-1478", time: "매일 11:00 - 21:30", menu: "탄두리 치킨 18,000원\n야채커리small 8,500원\n갈릭버터 난 3,500원", latitude: 36.0048855653359, longitude: 129.337273615748, isPhotoVerified: false, images: ["1_1", "1_2", "1_3"]),
                Restaurant(name: "효자동곱닭 포항효자본점", location: "경북 포항시 남구 형산강북로 87-1 1층", phone: "0507-1342-4778", time: "매일 11:00 - 22:00\n15:00 - 17:00 브레이크타임\n21:10 라스트오더", menu: "우삼겹 곱창전골 (2인분) 30,000원\n얼큰 곱도리탕 (2인분) 30,000원\n닭도리탕 (한마리) 31,000원", latitude: 36.0049447907681, longitude: 129.33659262977, isPhotoVerified: false, images: ["2_1", "2_2", "2_3"]),
                Restaurant(name: "덕수파스타 포항 효자", location: "경북 포항시 남구 효자동길 2 1층", phone: "0507-1368-3193", time: "매일 10:30 - 21:00\n20:00 라스트오더 ", menu: "땡초 크림 파스타 9,900원\n버터 스테이크 38,000원\n치즈 불고기 필라프 13,900원", latitude: 36.007853673717, longitude: 129.330398930981, isPhotoVerified: false, images: ["3_1", "3_2", "3_3"]),
                Restaurant(name: "그릴리언트", location: "경북 포항시 남구 효자동길2번길 15 1층", phone: "054-251-0850", time: "매달 3번째 수요일 정기휴무\n11:30 - 22:00\n15:00 - 17:00 브레이크타임\n21:00 라스트오더", menu: "바베큐 런치(1인)\n15,900 - 17,900원\n바베큐 3인 플래터 61,000원\n바베큐 4인 플래터 78,000원", latitude: 36.008249399088, longitude: 129.331779438985, isPhotoVerified: false, images: ["4_1", "4_2", "4_3"]),
                Restaurant(name: "참뼈 효자점", location: "경북 포항시 남구 효자동길1번길 4", phone: "054-272-1254", time: "매일 06:00 - 02:00", menu: "뼈해장국 10,000원\n소고기 선지국 10,000원\n내장탕 13,000원", latitude: 36.0076656290006, longitude: 129.329875419326, isPhotoVerified: false, images: ["5_1", "5_2", "5_3"])
            ],
            [
                Restaurant(name: "어리 닭갈비", location: "경북 포항시 남구 효자동길6번길 11", phone: "054-281-9332", time: "매주 수요일 휴무\n평일 11:30 - 21:00\n14:00 - 16:30 브레이크타임\n주말 12:00 - 21:00\n20:00 라스트오더", menu: "철판양념닭갈비\n소(1~2인) 24,000원\n중(2~3인) 35,000원\n메밀막국수 7,000원", latitude: 36.0084863808862, longitude: 129.331245708637, isPhotoVerified: false, images: ["6_1", "6_2", "6_3"]),
                Restaurant(name: "원해물칼국수", location: "경북 포항시 남구 효자동길6번길 20-1 1층", phone: "054-272-3882", time: "매주 일요일 휴무\n11:20 - 20:30\n19:40 라스트오더", menu: "바지락칼국수 8,000원\n국산들깨칼국수 9,000원\n돌솥비빔밥 9,000원", latitude: 36.008500986905, longitude: 129.332176306923, isPhotoVerified: false, images: ["7_1", "7_2", "7_3"]),
                Restaurant(name: "테츠로라멘", location: "경북 포항시 남구 효자동길 1 , 1층 테츠로라멘", phone: "0507-1325-5882", time: "매주 일요일 정기휴무\n11:30 - 20:00\n15:00 17:30 브레이크타임\n19:30 라스트오더", menu: "블랙소유라멘 9,000원\n하카타돈코츠라멘 9,000원\n아라시돈코츠라멘 9,000원", latitude: 36.0077447593164, longitude: 129.330078241025, isPhotoVerified: false, images: ["8_1", "8_2", "8_3"]),
                Restaurant(name: "까오산쌀국수", location: "경북 포항시 남구 효자동길1번길 22 까오산쌀국수", phone: "0507-1306-5204", time: "매달 4,5번째 일요일 휴무\n11:00 - 20:00", menu: "까오산 쌀국수 10,000원\n돼지고기 쌀국수 9,500원\n소고기 쌀국수 10,000원", latitude: 36.0071277428733, longitude: 129.32813101816, isPhotoVerified: false, images: ["9_1", "9_2", "9_3"]),
                Restaurant(name: "해오름", location: "경상북도 포항시 남구 효자동길1번길 24 1층 좌측", phone: "0507-1368-2314", time: "매주 월요일 정기휴무\n10:00 - 22:00\n21:30 라스트오더", menu: "만두전골(순한맛) 13,000원\n만두전골(얼큰맛) 14,000원\n동죽칼국수 10,000원", latitude: 36.0070508442596, longitude: 129.327943014057, isPhotoVerified: false, images: ["10_1", "10_2", "10_3"])
            ],
            [
                Restaurant(name: "오춘봉막창", location: "경북 포항시 남구 효자동길5번길 24", phone: "054-275-2402", time: "매일 16:00 - 01:00", menu: "돼지막창 10,000원\n삼겹살 10,000원\n막창 주문시 칼국수 서비스", latitude: 36.0074386260298, longitude: 129.327776439801, isPhotoVerified: false, images: ["11_1", "11_2", "11_3"]),
                Restaurant(name: "일로식당", location: "경북 포항시 남구 효자동길5번길 20 1층", phone: "0507-1487-5518", time: "매일 11:00 - 22:00\n15:00 - 17:00 브레이크타임\n21:00 라스트오더 ", menu: "꽃삼겹살 11,000원\n숙성 생삼겹살 11,000원\n수제돼지갈비 12,500원\n점심특선 12,900원", latitude: 36.007579481396, longitude: 129.328104385888, isPhotoVerified: false, images: ["12_1", "12_2", "12_3"]),
                Restaurant(name: "승리양꼬치", location: "경북 포항시 남구 효자동길5번길 16", phone: "010-2791-9588", time: "매일 12:00 - 24:00", menu: "양꼬치 15,000원\n양념양꼬치 16,000원\n양갈비살 17,000원", latitude: 36.0076104305585, longitude: 129.328412909445, isPhotoVerified: false, images: ["13_1", "13_2", "13_3"]),
                Restaurant(name: "참서리", location: "경북 포항시 남구 효자동길10번길 11 조은마을빌라", phone: "054-273-2825", time: "매일 11:00 - 21:00", menu: "초벌 소 15,000원\n초벌 중 19,500원\n초벌 대 26,000원", latitude: 36.0086481943319, longitude: 129.330986550068, isPhotoVerified: false, images: ["14_1", "14_2", "14_3"]),
                Restaurant(name: "효자동 쌀국수미", location: "경북 포항시 남구 효자동길6번길 7 1층", phone: "054-278-8815", time: "매일 11:30 - 21:00\n15:00 - 17:30 브레이크타임\n라스트오더\n점심 - 14:30 저녁 - 20:30", menu: "모듬쌀국수 13,000원\n차돌양지쌀국수 10,000원\n아롱사태쌀국수 13,000원", latitude: 36.0083681703418, longitude: 129.330726687073, isPhotoVerified: false, images: ["15_1", "15_2", "15_3"])
            ],
            [
                Restaurant(name: "라멘베라보", location: "경북 포항시 남구 효자동길6번길 25-1 1층", phone: "0507-1348-3439", time: "매주 일요일 정기휴무\n11:30 - 19:20\n13:50 - 17:30 브레이크타임\n19:20 라스트오더", menu: "마제소바 10,000원\n베라보시오 9,000원\n베라보소유 9,000원", latitude: 36.0087671999432, longitude: 129.332761461306, isPhotoVerified: false, images: ["16_1", "16_2", "16_3"]),
                Restaurant(name: "홍운반점", location: "경북 포항시 남구 효자동길6번길 23 1층", phone: "0507-1329-2727", time: "매주 월요일 정기휴무\n10:30 - 21:00\n20:00 라스트오더", menu: "자장면 5,000원\n짬뽕 7,000원\n탕수육 12,000원", latitude: 36.0087180836111, longitude: 129.332544437547, isPhotoVerified: false, images: ["17_1", "17_2", "17_3"]),
                Restaurant(name: "토산전집", location: "경북 포항시 남구 효성로64번길 5 1층", phone: "054-285-0665", time: "매월 첫째,셋째 일요일 휴무\n매일 16:00 - 24:00", menu: "모듬전 25,000원\n모듬튀김 25,000원\n육전 15,000원", latitude: 36.005467217076, longitude: 129.340941899067, isPhotoVerified: false, images: ["18_1", "18_2", "18_3"]),
                Restaurant(name: "더착한아구찜", location: "경북 포항시 남구 효성로93번길 25", phone: "0507-1334-4700", time: "매주 수요일 정기휴무\n11:00 - 22:00", menu: "아구찜 2인 30,000원\n아구불고기 2인 40,000원\n대구뽈찜 40,000원", latitude: 36.0062259815003, longitude: 129.341733691002, isPhotoVerified: false, images: ["19_1", "19_2", "19_3"]),
                Restaurant(name: "효자동오륙도", location: "경북 포항시 남구 효성로 52-1", phone: "0507-1343-7117", time: "매주 월요일 휴무\n11:30 - 23:00\n14:50 - 16:00 브레이크타임\n22:00 라스트오더", menu: "모듬회 소/중/대/특대\n50,000 - 90,000원\n물회 15,000원\n자연산모듬 소/중/대\n60,000 - 100,000원", latitude: 36.0059455210265, longitude: 129.339268205681, isPhotoVerified: false, images: ["20_1", "20_2", "20_3"])
            ],
            [
                Restaurant(name: "담박집", location: "경북 포항시 남구 효자동길10번길 33 1F", phone: "054-275-1300", time: "매일 11:30 - 21:30\n15:30 - 17:30 브레이크타임", menu: "한돈 모듬카츠 14,000원\n한돈 모듬멘치카츠 15,000원\n한돈 로스카츠 13,000원", latitude: 36.009245999672, longitude: 129.333274929359, isPhotoVerified: false, images: ["21_1", "21_2", "21_3"]),
                Restaurant(name: "상해교자", location: "경북 포항시 남구 효자동길10번길 31-1 1층", phone: "0507-1333-3254", time: "매주 일요일 정기휴무\n11:30 - 20:00\n14:00 17:30 브레이크타임", menu: "동파육덮밥 11,500원\n우육면 10,000원\n참깨비빔탄탄면 9,500", latitude: 36.00917912426, longitude: 129.333123251232, isPhotoVerified: false, images: ["22_1", "22_2", "22_3"]),
                Restaurant(name: "순이", location: "경북 포항시 남구 효자동길7번길 5-1 1층", phone: "054-273-6686", time: "매주 월요일 정기휴무\n11:30 - 20:50\n14:30 - 17:30 브레이크타임", menu: "바지락라멘 10.000원\n카모소유 츠케멘 10,000원\n가지탕수덮밥 10,000원", latitude: 36.0079529582591, longitude: 129.329425672387, isPhotoVerified: false, images: ["23_1", "23_2", "23_3"]),
                Restaurant(name: "가정초밥 효자본점", location: "경북 포항시 남구 효자동길2번길 3", phone: "054-241-8383", time: "매일 11:30 - 21:00\n15:30 - 17:00 브레이크타임", menu: "(한정판매)가정특선스시 29,800원\n가정모듬스시 24,800원\n모듬스시 A 14,800원", latitude: 36.007932252101, longitude: 129.330579115467, isPhotoVerified: false, images: ["24_1", "24_2", "24_3"]),
                Restaurant(name: "맛나국시", location: "경북 포항시 남구 효자동길6번길 15", phone: "054-256-8480", time: "상시 변경 전화주세요", menu: "잔치국시 5,000원\n비빔국시 6,000원\n오징어부추전 7,000원", latitude: 36.0085525088484, longitude: 129.331621254388, isPhotoVerified: false, images: ["25_1", "25_2", "25_3"])
            ]
        ]
        self.showBingoCompletion = false
    }
    
    mutating func markNumber(row: Int, col: Int) {
        guard row >= 0 && row < 5 && col >= 0 && col < 5 else {
            return
        }
        board[row][col] = true
    }
    
    func bingoCount() -> Int {
        return checkRows() + checkCols() + checkDiagonals()
    }
    
    private func checkRows() -> Int {
        var count = 0
        for row in 0..<5 {
            if board[row].allSatisfy({ $0 }) {
                count += 1
            }
        }
        return count
    }
    
    private func checkCols() -> Int {
        var count = 0
        for col in 0..<5 {
            var allMarked = true
            for row in 0..<5 {
                if !board[row][col] {
                    allMarked = false
                    break
                }
            }
            if allMarked {
                count += 1
            }
        }
        return count
    }
    
    private func checkDiagonals() -> Int {
        var count = 0
        var allMarked = true
        
        for i in 0..<5 {
            if !board[i][i] {
                allMarked = false
                break
            }
        }
        if allMarked {
            count += 1
        }
        
        allMarked = true
        for i in 0..<5 {
            if !board[i][4 - i] {
                allMarked = false
                break
            }
        }
        if allMarked {
            count += 1
        }
        
        return count
    }
    
    func markedCount() -> Int {
        return board.flatMap { $0 }.filter { $0 }.count
    }
}

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
                    .multilineTextAlignment(.center)
                    .foregroundStyle(game.board[row][col] ? Color.white : Color.text)
                    .padding(.bottom, 2)
            }
        }
    }
}
