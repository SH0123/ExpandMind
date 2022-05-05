//
//  ActivityIndicator.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/04.
//

import SwiftUI
import WebKit

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        self.shouldAnimate ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

