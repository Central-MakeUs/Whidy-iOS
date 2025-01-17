//
//  Loading.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 17/1/25.
//

//import SwiftUI
//import ComposableArchitecture
//import ActivityIndicatorView
//
//struct LoadingView: View {
//    @Binding var showLoadingIndicator : Bool
//    var isObdConnecting : Bool = false
//    var loadingType : ActivityIndicatorView.IndicatorType = .scalingDots()
//    var value : Double
//    var bg : Bool = true
//    
//    var body: some View {
//        VStack {
//            ZStack {
//                if bg {
//                    Color.black.opacity(value)
//                        .edgesIgnoringSafeArea(.all)
//                        .zIndex(0)
//                }
//                
//                VStack(spacing : 1) {
//                    if isObdConnecting {
//                        Text("OBD2에 연결중입니다 🌱")
//                            .fontModifier(fontSize: 19, weight: .heavy, color: ColorSystem.green5ea504.rawValue)
//                            .animation(.easeInOut(duration: 0.8), value: showLoadingIndicator)
//                            .zIndex(2)
//                    }
//                    
//                    ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .scalingDots())
//                        .frame(width: 40, height: 40)
//                        .foregroundColor(Color.init(hex: ColorSystem.green5ea504.rawValue))
//                        .zIndex(2)
//
//                }
//                .zIndex(1)
//            }
//        }
//    }
//}
//
////#Preview {
////    @State var testLoadingIndicator = true
////    LoadingView(showLoadingIndicator: $testLoadingIndicator, isObdConnecting: true, loadingType: .growingCircle, value: 0.6, bg: true)
////}
