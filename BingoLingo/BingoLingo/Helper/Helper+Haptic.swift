//
//  Helper+Haptic.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/18/24.
//

import UIKit
import SwiftUI

final class HapticManager {
    static let shared = HapticManager()
    private init() {}

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

struct NavigationLinkWithHaptic<Label: View, Destination: View>: View {
    var destination: Destination
    var label: () -> Label
    
    @State private var isActive = false
    
    var body: some View {
        NavigationLink(destination: destination, isActive: $isActive) {
            label()
                .onTapGesture {
                    HapticManager.shared.notification(type: .success)
                    isActive = true
                }
        }
    }
}

struct LinkWithHaptic<Label: View>: View {
    var url: URL
    var label: () -> Label
    
    var body: some View {
        label()
            .onTapGesture {
                HapticManager.shared.notification(type: .success)
                UIApplication.shared.open(url)
            }
    }
}
