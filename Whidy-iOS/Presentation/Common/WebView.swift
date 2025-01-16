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
        
        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            
            guard let urlString = webView.url?.absoluteString else { return }
            
            Logger.debug("redirectURL : \(urlString) 🐼🐼🐼🐼🐼")
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let requestURL = navigationAction.request.url {
                //TODO: - 확실한 조건이 필요할 듯.. 현재는 error가 contain 되었을 때
                if requestURL.absoluteString.contains("error") {
                    decisionHandler(.cancel) // 요청 취소
                    return
                }
            }
            decisionHandler(.allow) // 요청 허용
        }
        
        /// 호출 시점: 네비게이션 중에 실패
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            Logger.error("Navigation error: \(error)")
        }
        
        /// 호출 시점: 초기 로드 요청 단계에서 실패
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            
            self.parent.store.send(.kakoLoginCancel)
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
    }
    
    enum Action {
        
    }

}


//MARK: - Safari
struct SafariView: UIViewControllerRepresentable {

    @State var store : StoreOf<SafariFeature>

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        
        return SFSafariViewController(url: store.url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}

@Reducer
struct SafariFeature {
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        var url = URL(string: "")!
    }
    
    enum Action {
        
    }
    
}
