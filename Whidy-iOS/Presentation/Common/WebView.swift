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
            guard let url = navigationAction.request.url else { return decisionHandler(.cancel) }
            
            if url.isDeepLink { // 딥링크 URL 스킴
                UIApplication.shared.open(url) { isSuccess in
                    if isSuccess { Logger.debug("DeepLink: \(url.absoluteString)") }
                }
                decisionHandler(.cancel) // Redirect 중단
            } else {
                decisionHandler(.allow)
            }
        }
        
        //FIXME: - Error 타입에 따라 Action 정의 필요함
        /// 호출 시점: 네비게이션 중에 실패
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            Logger.error("Navigation error: \(error)")
        }
        
        /// 호출 시점: 초기 로드 요청 단계에서 실패
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            // 에러 URL 확인
            guard let url = (error as NSError).userInfo[NSURLErrorFailingURLStringErrorKey] as? String else {
                Logger.error("Provisional navigation error: \(error)")
                parent.store.send(.dismiss)
                return
            }

            // 딥링크 스킴 확인
            if let failingURL = URL(string: url), failingURL.isDeepLink {
                Logger.info("Redirect URL is a deep link, skipping error handling: \(failingURL.absoluteString)")
                return
            }
            
            // 일반적인 에러 로그 출력
            Logger.error("Provisional navigation error: \(error)")
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
