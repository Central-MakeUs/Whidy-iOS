//
//  OnboardingCoordinatorView.swift
//  Whidy-iOS
//
//  Created by Namuplanet on 1/14/25.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

//MARK: - CoordinatorView
struct OnboardingCoordinatorView : View {
    @Perception.Bindable var store : StoreOf<OnboardingCoordinator>
    
    var body: some View {
        WithPerceptionTracking {
            TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
                switch screen.case {
                case let .auth(store):
                    AuthView(store: store)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case let .memberNickname(store):
                    MemberNicknameView(store: store)
                case let .memberEmail(store):
                    MemberEmailView(store: store)
                case let .web(store):
                    WebView(store: store)
                }
            }
            .accentColor(Color(hex: ColorSystem.black.rawValue))
            .alert(isPresented: $store.isSignUpError) {
                Alert(title: Text("알림"), message: Text(store.errorMessage),
                      dismissButton: .default(Text("확인")))
            }
            .onAppear {
                store.send(.viewTransition(.onAppear))
            }
            .onDisappear {
                store.send(.viewTransition(.onDisappear))
            }
            .onOpenURL { url in
                Logger.debug("Redirect Url : \(url), isDeepLink : \(url.isDeepLink), url.deeplinkComponent : \(String(describing: url.queryParameters)), host : \(url.pageIdentifier) 🐼🐼🐼🐼🐼🐼🐼🐼🐼")
                
                if url.isDeepLink {
                    store.send(.deepLink(.handler(url.pageIdentifier)))
                }
            }
        }
    }
}
