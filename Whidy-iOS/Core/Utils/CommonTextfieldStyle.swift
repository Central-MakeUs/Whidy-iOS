//
//  CommonTextfieldStyle.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI

struct CommonTextfieldStyle: TextFieldStyle {
    
    var radius : CGFloat
    var height : CGFloat
    var border : CGFloat = 1
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .stroke(lineWidth: border)
                .frame(maxHeight: height)
            
            // 텍스트필드
            configuration
                .font(.title)
                .padding()
        }
    }
}
