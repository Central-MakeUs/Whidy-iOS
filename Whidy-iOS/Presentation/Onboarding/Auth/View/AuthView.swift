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
            VStack {
                Spacer()
                
                VStack(spacing:8) {
                    Image(.kakaoLogin)
                        .resizable()
                        .frame(maxWidth: 347, maxHeight: 54)
                        .asButton {
                            store.send(.buttonTapped(.kakaoLogin))
                        }
                    
                    Image(.appleLogin)
                        .resizable()
                        .frame(maxWidth: 347, maxHeight: 54)
                        .asButton {
                            store.send(.buttonTapped(.appleLogin))
                        }
                }
                .padding(.bottom, 70)
            }
            .onAppear {
                store.send(.viewTransition(.onAppear))
            }
        }
    }
}
