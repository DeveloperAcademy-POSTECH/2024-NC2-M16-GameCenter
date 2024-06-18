//
//  BingoDetailView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI
import Photos
import Vision

struct BingoDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isBackPressed = false
    @State private var isImagePressed = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var isButtonDisabled = false
    @State private var showToast = false
    @State private var showBingoCompletion = false
    @State private var ocrText: String = ""
    
    @Binding var game: BingoGame
    @Binding var bingoCount: Int
    @Binding var markedCount: Int
    var row: Int
    var col: Int
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Image("imgplace")
                        
                        Text(game.restaurants[row][col].location)
                            .font(Font.custom("Galmuri11", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.place)
                            .padding(.leading, 6)
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    
                    CustomMapView(markerLatitude: game.restaurants[row][col].latitude, markerLongitude: game.restaurants[row][col].longitude)
                        .frame(width: 353, height: 200)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.map, lineWidth: 1)
                        )
                    
                    HStack(spacing: 7) {
                        ForEach(game.restaurants[row][col].images, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 113, height: 113)
                                .clipped()
                                .overlay(
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(Color.map, lineWidth: 1)
                                )
                        }
                    }
                    .padding(.top, 8)
                    
                    HStack(spacing: 0) {
                        Image("imgPhone")
                        
                        Text(game.restaurants[row][col].phone)
                            .font(Font.custom("DungGeunMo", size: 16))
                            .underline()
                            .foregroundColor(.place)
                            .padding(.leading, 8)
                            .onTapGesture {
                                if let phoneURL = URL(string: "tel://\(game.restaurants[row][col].phone)") {
                                    if UIApplication.shared.canOpenURL(phoneURL) {
                                        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                                    }
                                }
                            }
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.leading, 20)
                    
                    HStack(spacing: 0) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Image("imgTime")
                                
                                Text("영업시간")
                                    .font(Font.custom("DungGeunMo", size: 16))
                                    .foregroundColor(.place)
                                    .padding(.leading, 8)
                            }
                            
                            Text(game.restaurants[row][col].time)
                                .font(Font.custom("Galmuri11", size: 12))
                                .lineSpacing(12)
                                .foregroundColor(.place)
                                .frame(width: 169, height: 130, alignment: .topLeading)
                                .padding(.top, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Image("imgMenu")
                                
                                Text("대표메뉴")
                                    .font(Font.custom("DungGeunMo", size: 16))
                                    .foregroundColor(.place)
                                    .padding(.leading, 8)
                            }
                            
                            Text(game.restaurants[row][col].menu)
                                .font(Font.custom("Galmuri11", size: 12))
                                .lineSpacing(12)
                                .foregroundColor(.place)
                                .frame(width: 169, height: 130, alignment: .topLeading)
                                .padding(.top, 8)
                        }
                        .padding(.leading, 16)
                    }
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    Button(action: {
                        HapticManager.shared.notification(type: .success)
                        requestPhotoLibraryPermission {
                            showImagePicker = true
                        }
                    }) {
                        Image(isButtonDisabled ? "btnDisabled" : (isImagePressed ? "btnImage2" : "btnImage1"))
                    }
                    .disabled(isButtonDisabled)
                    .onLongPressGesture(
                        minimumDuration: 0.1,
                        pressing: { pressing in
                            withAnimation {
                                isImagePressed = pressing
                            }
                        },
                        perform: {
                            print("Long press completed")
                        }
                    )
                    .padding(.bottom, 20)
                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        if let image = selectedImage {
                            performOCR(on: image) { text in
                                self.ocrText = text
                                if verifyAddressOrName(ocrText: text, storeAddress: game.restaurants[row][col].location, storeName: game.restaurants[row][col].name) {
                                    game.markNumber(row: row, col: col)
                                    isButtonDisabled = true
                                    showToast = true
                                    showBingoCompletion = true
                                    let newBingoCount = game.bingoCount()
                                    bingoCount = newBingoCount
                                    markedCount = game.markedCount()
                                    print("success")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showToast = false
                                    }
                                } else {
                                    print("fail")
                                }
                            }
                        }
                    }) {
                        ImagePicker(selectedImage: $selectedImage)
                            .ignoresSafeArea()
                    }
                }
                
                if showToast {
                    VStack {
                        Image("imgSaved")
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.5))
                    }
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    HapticManager.shared.notification(type: .success)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(isBackPressed ? "btnBack2" : "btnBack1")
                        .resizable()
                        .frame(width: 40, height: 41)
                }
                .onLongPressGesture(
                    minimumDuration: 0.1,
                    pressing: { pressing in
                        withAnimation {
                            isBackPressed = pressing
                        }
                    },
                    perform: {
                        print("Long press completed")
                    }
                )
            }
            ToolbarItem(placement: .principal) {
                Text(game.restaurants[row][col].name)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("DungGeunMo", size: 20))
                    .foregroundColor(.title)
            }
        }
    }
    
    private func requestPhotoLibraryPermission(completion: @escaping () -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        case .authorized, .limited:
            completion()
        default:
            break
        }
    }
    
    private func performOCR(on image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            print("Unable to get cgImage")
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Error in OCR: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var recognizedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                recognizedText += topCandidate.string + "\n"
            }
            
            completion(recognizedText)
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Failed to perform OCR: \(error.localizedDescription)")
        }
    }

    // Levenshtein Distance 계산 함수
    func levenshteinDistance(_ s1: String, _ s2: String) -> Int {
        let s1Array = Array(s1)
        let s2Array = Array(s2)
        let n = s1Array.count
        let m = s2Array.count
        var d = [[Int]](repeating: [Int](repeating: 0, count: m + 1), count: n + 1)

        for i in 0...n {
            d[i][0] = i
        }

        for j in 0...m {
            d[0][j] = j
        }

        for i in 1...n {
            for j in 1...m {
                let cost = s1Array[i - 1] == s2Array[j - 1] ? 0 : 1
                d[i][j] = min(d[i - 1][j] + 1, // Deletion
                              d[i][j - 1] + 1, // Insertion
                              d[i - 1][j - 1] + cost) // Substitution
            }
        }
        return d[n][m]
    }

    // 문자열 정규화 함수
    func normalizeString(_ text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    // 부분 일치 여부 확인 함수
    func isPartialMatch(_ text1: String, _ text2: String, threshold: Int) -> Bool {
        let normalizedText1 = normalizeString(text1)
        let normalizedText2 = normalizeString(text2)
        
        let distance = levenshteinDistance(normalizedText1, normalizedText2)
        let maxLength = max(normalizedText1.count, normalizedText2.count)
        
        // 정확도 계산: (1 - (편집 거리 / 최대 길이)) * 100
        let similarity = (1 - Double(distance) / Double(maxLength)) * 100
        return similarity >= Double(threshold)
    }

    // 주소 또는 가게 이름 검증 함수
    func verifyAddressOrName(ocrText: String, storeAddress: String, storeName: String) -> Bool {
        let threshold = 90 // 일치율 90% 이상을 요구
        
        // OCR 텍스트와 가게 주소 및 이름을 비교
        let isAddressMatch = isPartialMatch(ocrText, storeAddress, threshold: threshold)
        let isNameMatch = isPartialMatch(ocrText, storeName, threshold: threshold)
        
        // 주소 또는 이름 중 하나라도 일치하면 인증 성공
        if isAddressMatch || isNameMatch {
            print("OCR Text: \(ocrText)")
            print("Store Address: \(storeAddress)")
            print("Store Name: \(storeName)")
            return true
        } else {
            print("OCR Text: \(ocrText)")
            print("Store Address: \(storeAddress)")
            print("Store Name: \(storeName)")
            return false
        }
    }
}

struct BingoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BingoDetailView(
            game: .constant(BingoGame()),
            bingoCount: .constant(0),
            markedCount: .constant(0),
            row: 0,
            col: 0
        )
    }
}
