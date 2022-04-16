//
//  MovieSearchView.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 16/04/2022.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    
    var body: some View {
        NavigationView {
            List{
                SearchBarView(placeholder: "Search movies", text:
                                self.$movieSearchState.query
                )
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if self.movieSearchState.movies != nil {
                    ForEach(self.movieSearchState.movies!){ movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            VStack(alignment: .leading){
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                        }
                    }
                }
            }
            .onAppear{
                self.movieSearchState.startObserve()
            }
            .navigationBarTitle("Search")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
