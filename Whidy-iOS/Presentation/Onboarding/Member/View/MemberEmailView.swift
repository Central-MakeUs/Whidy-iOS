//
//  MemberEmailView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI
import ComposableArchitecture

struct MemberEmailView: View {
    @Perception.Bindable var store: StoreOf<MemberEmailFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("Where Your Study Begins")
                    .align(.leading)
                    .fontModifier(fontSize: 25, weight: .bold, color: ColorSystem.black.rawValue)
                
                Text("Whidy")
                    .fontModifier(fontSize: 64, weight: .bold, color: ColorSystem.black.rawValue)
                    .align(.leading)
                    .padding(.top, 35)
                                
                Text("이메일을 입력해주세요")
                    .fontModifier(fontSize: 20, weight: .bold, color: ColorSystem.black.rawValue)
                    .align(.leading)
                    .padding(.top, 10)
                    
                TextField("", text: $store.email)
                    .textFieldStyle(CommonTextfieldStyle(radius: 10, height: 59, border: 1))
                
                Spacer()
                
                Text("완료")
                    .fontModifier(fontSize: 15, weight: .semibold, color: ColorSystem.white.rawValue)
                    .frame(width: 120, height: 45)
                    .background(Color(hex: 0x437CFD))
                    .cornerRadius(15)
                    .align(.trailing)
                    .asButton {
                        store.send(.buttonTapped(.complete))
                    }
//                    .padding(<#T##EdgeInsets#>)
            }
            .padding(.horizontal, 29)
            .padding(.vertical, 100)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton {
                        store.send(.viewTransition(.goToBack))
                    }
                }
            }
        }
    }
}

#Preview {
    MemberEmailView(store: Store(initialState: MemberEmailFeature.State(), reducer: {
        MemberEmailFeature()
    }))
}
