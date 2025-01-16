//
//  SafariView.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/16/25.
//

import SwiftUI
import SafariServices
import ComposableArchitecture
@preconcurrency import WebKit

//MARK: - WKWeb
struct WebView : UIViewRepresentable {
    @Perception.Bindable var store : StoreOf<WebFeature>
    var webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = store.url else { return webView }
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //Conform to WKNavigationDelegate protocol here and declare its delegate
    final class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
        
        /// RedirectURL Handler
        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            
            guard let urlString = webView.url?.absoluteString else { return }
            
            Logger.debug("redirectURL : \(urlString) 🐼🐼🐼🐼🐼")
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                // 딥링크인지 확인
                if url.isDeepLink { // 딥링크 URL 스킴
                    UIApplication.shared.open(url) { success in
                        if success {
                            Logger.debug("딥링크 실행 성공: \(url.absoluteString)")
                        } else {
                            Logger.debug("딥링크 실행 실패")
                        }
                    }
                    
                    decisionHandler(.cancel) // Redirect 중단
                    return
                }
            }
            decisionHandler(.allow) // Redirect 허용
        }
        
        //FIXME: - Error 타입에 따라 Action 정의 필요함
        /// 호출 시점: 네비게이션 중에 실패
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            Logger.error("Navigation error: \(error)")
        }
        
        /// 호출 시점: 초기 로드 요청 단계에서 실패
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            Logger.error("Provisional navigation error: \(error)")
            self.parent.store.send(.dismiss)
        }
        
    }
}

@Reducer
struct WebFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var url: URL?
        var errorMessage : String?
    }
    
    enum Action {
        case dismiss
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                Logger.debug("webView dismiss")
            }
            return .none
        }
    }
}
