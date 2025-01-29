//
//  BackButton.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 17/1/25.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.back) // 화살표 Image
                .aspectRatio(contentMode: .fit)
        }
    }
}
