//
//  DynamicFontSizeModifier.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 10/14/24.
//

import SwiftUI

struct DynamicFontSizeModifier: ViewModifier {
    var lineLimit : Int
    var scaleFactor : CGFloat
    
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(scaleFactor)
    }
}
