//
//  webViewBack.swift
//  AircraftInspection
//
//  Created by Роман on 16.05.2024.
//

import Foundation
import WebKit
import SwiftUI

struct WebViewBack: UIViewRepresentable {
    
    let request: URLRequest
    private var webView: WKWebView?
    
    init(request: URLRequest) {
        self.request = request
        self.webView = WKWebView()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    func goBack() {
        webView?.goBack()
    }
}
