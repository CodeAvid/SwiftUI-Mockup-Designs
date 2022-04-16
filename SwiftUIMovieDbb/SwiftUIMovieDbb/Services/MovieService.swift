//
//  MovieService.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import Foundation

protocol MovieService{
    func fetchMovie(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieListEndPoint: String {
    case nowPlaying  = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String{
        switch self{
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}


enum MovieError: Error, CustomNSError{
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String{
        
        switch self{
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
        
    }
    
    
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey: localizedDescription ]
    }
    
}

