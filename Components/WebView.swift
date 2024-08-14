//
//  WebView.swift
//  AutoInsight
//
//  Created by Quercy on 06.08.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        // Set autoresizing mask to handle different screen sizes
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Modify the User-Agent to reflect a more modern browser, e.g., Safari on iPad
        webView.customUserAgent = "Mozilla/5.0 (iPad; CPU OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

#Preview {
    WebView(url: URL(string: "https://www.google.com")!)
}




