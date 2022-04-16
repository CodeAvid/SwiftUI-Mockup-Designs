//
//  MovieListView.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var nonPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    
                    Group{
                        if nonPlayingState.movie != nil {
                            MoviePosterCarousel(title: "Now Playing", movies: nonPlayingState.movie!)
                        } else{
                            LoadingView(isLoading: nonPlayingState.isLoading, error: nonPlayingState.error) {
                                self.nonPlayingState.loadMovies(with: .nowPlaying)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                    Group{
                        if upcomingState.movie != nil {
                            MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movie!)
                        } else {
                            LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                                self.upcomingState.loadMovies(with: .upcoming)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    Group{
                        if topRatedState.movie != nil {
                            MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movie!)
                        } else {
                            LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                                self.nonPlayingState.loadMovies(with: .topRated)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))

                    
                    Group{
                        if popularState.movie != nil {
                            MovieBackdropCarouselView(title: "Popular", movies: popularState.movie!)
                        } else {
                            LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                                self.popularState.loadMovies(with: .popular)
                            }
                        }
                    }
                   
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    
                    
                }
            }
            
            .navigationTitle("The MovieDb")
        }
        .onAppear{
            self.nonPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
