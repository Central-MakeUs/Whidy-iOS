//
//  InfoView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 2/1/25.
//

import SwiftUI
import ComposableArchitecture

//TODO: - Place ID 기준으로 상세조회 API 적용해야됨

struct InfoView: View {
    
    @Perception.Bindable var store : StoreOf<InfoFeautre>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment:.top) {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                }
                
                Capsule()
                    .frame(width: 34, height: 3)
                    .foregroundColor(Color(hex: ColorSystem.graye8e9ed.rawValue))
                    .padding(.top, 6)
                
                ScrollView {
                    VStack(spacing:0) {
                        HStack {
                            Text(store.currentPlace.name)
                                .fontModifier(fontSize: 18, weight: .bold, color: ColorSystem.grayG900.rawValue)
                            
                            Text(store.currentPlace.placeType.caseTitle)
                                .fontModifier(fontSize: 12, weight: .medium, color: ColorSystem.grayG300.rawValue)
                            
                            Spacer()
                        }
                        
                        HStack {
                            VStack(spacing:0) {
                                Text(store.currentPlace.address)
                                    .fontModifier(fontSize: 14, weight: .medium, color: ColorSystem.grayG800.rawValue)
                                    .align(.leading)
                                
                                //FIXME: - businessHours 로 계산 필요함
                                HStack(alignment:.center){
                                    Text("영업중")
                                        .fontModifier(fontSize: 14, weight: .semibold, color: ColorSystem.grayG800.rawValue)
                                    
                                    Text("24:00 까지")
                                        .fontModifier(fontSize: 14, weight: .medium, color: ColorSystem.grayG800.rawValue)
                                    
                                    Spacer()
                                }
                                .padding(.top, 4)
                                
                                HStack(alignment:.center, spacing: 0) {
                                    Image(.star2)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                    
                                    Text(store.currentCafe.reviewScore)
                                        .fontModifier(fontSize: 12, weight: .bold, color: ColorSystem.grayG800.rawValue)
                                        .padding(.leading, 2)
                                    
                                    Image(.ellipse15)
                                        .resizable()
                                        .frame(width: 2, height: 2)
                                        .padding(.leading, 2)
                                    
                                    Text("후기 \(store.currentCafe.reviewNum)개")
                                        .fontModifier(fontSize: 12, weight: .bold, color: ColorSystem.grayG600.rawValue)
                                        .padding(.leading, 4)
                                    
                                    Spacer()
                                }
                                .padding(.top, 8.5)
                                
                                HStack {
                                    HStack(alignment: .center, spacing: 0) {
                                        Image(.coffeeSolid)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("\(store.currentCafe.beveragePrice)원")
                                            .fontModifier(fontSize: 12, weight: .medium, color: ColorSystem.grayG700.rawValue)
                                            .padding(.leading, 4)
                                        
                                        //TODO: - information image 필요
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .frame(height: 28, alignment: .topLeading)
                                    .background(Color(red: 0.95, green: 0.96, blue: 0.96))
                                    .cornerRadius(40)
                                    
                                    Spacer()
                                }
                                .padding(.top, 10)
                                
                            }
                            
                            Spacer()
                            
                            //TODO: - NaverAPI Image
                        }
                        .padding(.top, 4)
                    }
                    .padding(.horizontal, 14)
                }
                .padding(.top, 30)
            }
            .background(Color.white)
            .onAppear {
                store.send(.viewTransition(.onAppear))
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
