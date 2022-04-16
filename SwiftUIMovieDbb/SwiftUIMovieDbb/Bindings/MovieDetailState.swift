//
//  MovieDetailState.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import SwiftUI

class MovieDetailState: ObservableObject {
    
    @Published var movie: Movie?
    @Published var isLoading =  false
    @Published var error: NSError?
    
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    
    func loadMovie(with id: Int){
        self.movie  = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
            
        }
        
    }
}

