//
//  AlignmentModifier.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI

struct AlignmentModifier: ViewModifier {
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        HStack {
            if alignment == .leading {
                content
                Spacer()
            } else if alignment == .center {
                Spacer()
                content
                Spacer()
            } else if alignment == .trailing {
                Spacer()
                content
            }
        }
    }
}
