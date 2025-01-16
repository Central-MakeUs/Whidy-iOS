//
//  MemberView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI
import ComposableArchitecture

struct MemberView: View {
    @Perception.Bindable var store: StoreOf<MemberFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("Member View")
            }
        }
    }
}
//#Preview {
//    MemberView()
//}
