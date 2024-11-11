//
//  WebVideoView.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/9/24.
//

import SwiftUI
import WebKit

struct WebVideoView: UIViewRepresentable {
    let videoURL: URL
    
    func makeUIView(context: Context) -> some WKWebView {
        let webVideoView = WKWebView()
        webVideoView.scrollView.isScrollEnabled = false
        webVideoView.load(URLRequest(url: videoURL))
        return webVideoView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
