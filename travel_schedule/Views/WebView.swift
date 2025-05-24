//
//  WebView.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import SwiftUI
import WebKit

// MARK: - WebView

struct WebView: UIViewRepresentable {
    
    // MARK: - Properties
    
    let url: URL
    
    // MARK: - Public methods
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


// MARK: - Preview

#Preview {
    WebView(url: URL(string: "https://sarunw.com/posts/swiftui-webview/")!)
}
