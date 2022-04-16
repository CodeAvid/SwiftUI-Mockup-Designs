//
//  MovieSearchState.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 16/04/2022.
//

import SwiftUI
import Combine
import Foundation

class MovieSearchState: ObservableObject {
    
    @Published var query = ""
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    
    let movieServices: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieServices = movieService
    }
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map{ [weak self] text  in
                self?.movies = nil
                self?.error = nil
                return text
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink{[weak self] in self?.search(query: $0)}
    }
    
    func search(query: String){
        //Reset the values
        self.movies = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.movieServices.searchMovie(query: query) { [weak self] result in
            guard let self = self, self.query == query else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit{
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}

