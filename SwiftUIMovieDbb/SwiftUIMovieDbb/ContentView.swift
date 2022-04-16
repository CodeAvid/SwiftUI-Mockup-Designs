//
//  ContentView.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            MovieListView()
                .tabItem{
                    VStack{
                        Image(systemName: "tv")
                            Text("movies")
                    }
                }
                .tag(0)
            
            MovieSearchView()
                .tabItem {
                    VStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
        }
       
    }
}
struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}




