//
//  NormalTextField.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 8/31/24.
//

import SwiftUI

struct NormalTextFieldModifier: ViewModifier {
    var height: CGFloat
    var fontSize: CGFloat
    var weight : Font.Weight
    var fontColor : UInt
    var bgColorHex : UInt
    var alignment : TextAlignment
    
    func body(content: Content) -> some View {
        content
            .fontModifier(fontSize: fontSize, weight: weight, color: fontColor)
            .multilineTextAlignment(alignment)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .frame(maxWidth: .infinity, minHeight: height)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color(hex: bgColorHex))
                    .frame(maxWidth: .infinity, minHeight: height)
            }
    }
}
