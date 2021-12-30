//
//  WebView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 28.12.2021.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    var image: String
    
    func makeUIView(context: Context) -> WKWebView {
        
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.contentMode = .scaleAspectFit
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        DispatchQueue.main.async {
            webView.loadHTMLString(image, baseURL: nil)
        }
    }
}
