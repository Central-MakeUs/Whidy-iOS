//
//  NormalTextLabelModifier2.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/2/24.
//

import SwiftUI

struct NormalTextLabelModifier2: ViewModifier {
    let fontSize : CGFloat
    let width : CGFloat
    let height : CGFloat
    let alignment : Alignment
    let bgColor : UInt
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(hex: ColorSystem.tabbarUnactive.rawValue))
            .font(.system(size: fontSize, weight: .bold))
            .background(Color(hex: bgColor))
            .frame(width: width, height: height, alignment: alignment)
    }
}
