//
//  FontModifier.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/4/24.
//

import SwiftUI

struct FontModifier: ViewModifier {
    var fontSize : CGFloat
    var weight : Font.Weight
    var color : Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize, weight: weight))
            .foregroundStyle(color)
    }
}
