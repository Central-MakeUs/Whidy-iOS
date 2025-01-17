//
//  MemberNicknameView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI
import ComposableArchitecture

struct MemberNicknameView: View {
    @Perception.Bindable var store: StoreOf<MemberNicknameFeature>
    
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
                
                Text("닉네임을 입력해주세요")
                    .fontModifier(fontSize: 20, weight: .bold, color: ColorSystem.black.rawValue)
                    .align(.leading)
                    .padding(.top, 50)
                    
                TextField("", text: $store.nickname)
                    .textFieldStyle(CommonTextfieldStyle(radius: 10, height: 59, border: 1))
                
                Spacer()
                
                Text("다음")
                    .fontModifier(fontSize: 15, weight: .semibold, color: ColorSystem.white.rawValue)
                    .frame(width: 120, height: 45)
                    .background(Color(hex: 0x437CFD))
                    .cornerRadius(15)
                    .align(.trailing)
                    .asButton {
                        store.send(.buttonTapped(.next))
                    }
//                    .padding(<#T##EdgeInsets#>)
            }
            .padding(.horizontal, 29)
            .padding(.vertical, 100)
            .toolbar(.hidden)
        }
    }
}

//#Preview {
//    MemberNicknameView(store: Store(initialState: MemberNicknameFeature.State(), reducer: {
//        MemberNicknameFeature()
//    }))
//}
