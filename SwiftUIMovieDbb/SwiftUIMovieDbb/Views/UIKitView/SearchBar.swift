//
//  SearchBar.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 16/04/2022.
//

import SwiftUI

struct SearchBarView: UIViewRepresentable {
   

    typealias UIViewType = UISearchBar
    
    let placeholder: String
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text  = text
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text)
    }
    
    
    class Coordinator: NSObject, UISearchBarDelegate{
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}
