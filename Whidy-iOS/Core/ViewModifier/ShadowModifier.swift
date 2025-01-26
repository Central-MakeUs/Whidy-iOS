//
//  ShadowModifier.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/4/24.
//

import SwiftUI

struct ShadowModifier : ViewModifier {
    
    var cornerRadius : CGFloat
    var bgColor : UInt
    var radius : CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func body(content : Content) -> some View {
        content
            .background(Color(hex: bgColor))
            .cornerRadius(cornerRadius)
            .shadow(color: Color(hex: ColorSystem.tabbarUnactive.rawValue).opacity(0.3), radius: radius, x: x, y: y)
    }
}
