//
//  WhidySplashView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI

struct WhidySplashView: View {
    var body: some View {
        Text("Whidy")
            .fontModifier(fontSize: 64, weight: .bold, color: ColorSystem.black.rawValue)
    }
}

#Preview {
    WhidySplashView()
}
