//
//  BingoDetailView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI
import PhotosUI

struct BingoDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isBackPressed = false
    @State private var isImagePressed = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var isButtonDisabled = false
    @State private var showToast = false
    @State private var showBingoCompletion = false
    
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
                    .padding(.bottom, 8)
                    .padding(.top, 30)
                    
                    CustomMapView(markerLatitude: game.restaurants[row][col].latitude, markerLongitude: game.restaurants[row][col].longitude)
                        .frame(width: 353, height: 200)
                        .overlay(
                            Rectangle()
                                .inset(by: 0.5)
                                .stroke(Color.map, lineWidth: 1)
                        )
                    
                    HStack(spacing: 7) {
                        Image("imgDummy2")
                            .resizable()
                            .frame(width: 113, height: 113)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.map, lineWidth: 1)
                            )
                        
                        Image("imgDummy2")
                            .resizable()
                            .frame(width: 113, height: 113)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.map, lineWidth: 1)
                            )
                        
                        Image("imgDummy2")
                            .resizable()
                            .frame(width: 113, height: 113)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.map, lineWidth: 1)
                            )
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
                                .foregroundColor(.place)
                                .frame(width: 169, height: 90, alignment: .topLeading)
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
                                .foregroundColor(.place)
                                .frame(width: 169, height: 90, alignment: .topLeading)
                                .padding(.top, 8)
                        }
                        .padding(.leading, 14)
                    }
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    Button(action: {
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
                    .padding(.bottom, 30)
                    
                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        if selectedImage != nil {
                            game.markNumber(row: row, col: col)
                            isButtonDisabled = true
                            showToast = true
                            showBingoCompletion = true
                            let newBingoCount = game.bingoCount()
                            bingoCount = newBingoCount
                            markedCount = game.markedCount()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showToast = false
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
                    .padding(.bottom, 110)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
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
