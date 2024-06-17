//
//  MapView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/17/24.
//

import SwiftUI

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isBackPressed = false
    
    var body: some View {
        ZStack {
            Color.background2.ignoresSafeArea()
            
            ScrollView(showsIndicators: false, content: {
                VStack(spacing: 20) {
                    Image(.imgLv1)
                        .padding(.top, 24)
                    
                    Image(.imgLv2)
                    
                    Image(.imgLv3)
                    
                    Image(.imgLv4)
                }
            })
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(isBackPressed ? .btnBack2 : .btnBack1)
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
                Text("빙고맵")
                    .font(Font.custom("DungGeunMo", size: 20))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    MapView()
}
