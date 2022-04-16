//
//  Movie+Stub.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import Foundation

extension Movie{
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJson(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie{
        stubbedMovies[0]
    }
}

extension Bundle{
    func loadAndDecodeJson<D: Decodable>(filename: String) throws -> D? {
        //load get url path for the json file
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        //Read the content of the json file
        let data = try Data(contentsOf: url)
        
        //Decode the json file
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        
        //Return decoded model
        return decodedModel
    }
}
