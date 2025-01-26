//
//  NormalTextLabelModifier.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/2/24.
//

import Foundation
import SwiftUI

struct NormalTextLabelModifier : ViewModifier {
    var fontSize : CGFloat
    var height : CGFloat
    
    func body(content: Content) -> some View {
        content
            .fontModifier(fontSize: fontSize, weight: .semibold, color: ColorSystem.tabbarUnactive.rawValue)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: height)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color(hex: ColorSystem.tabbarUnactive.rawValue))
                    .frame(maxWidth: .infinity, maxHeight: height)
            }
    }
}
