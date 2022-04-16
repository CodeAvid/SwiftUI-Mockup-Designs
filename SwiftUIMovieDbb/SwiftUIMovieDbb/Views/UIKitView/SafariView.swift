//
//  SafariView.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import SwiftUI
import SafariServices
struct SafariView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVc = SFSafariViewController(url: self.url)
        return safariVc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}


