//
//  AuthView.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    @Perception.Bindable var store : StoreOf<AuthFeature>
    
    var body: some View {
        WithPerceptionTracking {
            Text("로그인 View")
        }
    }
}
