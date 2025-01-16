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
                            
                        }
                    
                    Image(.appleLogin)
                        .resizable()
                        .frame(maxWidth: 347, maxHeight: 54)
                        .asButton {
                            
                        }

                }
                .padding(.bottom, 70)
            }
        }
    }
}
