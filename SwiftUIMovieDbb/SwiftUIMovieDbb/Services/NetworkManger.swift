//
//  NetworkManager.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import Foundation


class MovieStore: MovieService{
    
    static let shared = MovieStore()
    
    private init() {}
    
    private let apiKey = "8e2215cbb051dfb5058d902188c1d276"
    private let baseAPIUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    
    
    func fetchMovie(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, params: ["append_to_response" : "video,credits"] ,completion: completion)
        
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, params: [
            "language" : "en-Us",
            "include_adult": "false",
            "region": "Us",
            "query": query
        ] ,completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()){
        
        //Create a url component
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        //Create a queryItems
        var queryItem = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItem.append(contentsOf: params.map{
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }
        //Add queryItems to urlComponent
        urlComponents.queryItems = queryItem
        
        
        //Extract url from urlComponent
        guard let finalURl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURl) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionMainThread(with: .success(decodedResponse), completion: completion)
                
            } catch  {
                self.executeCompletionMainThread(with: .failure(.serializationError), completion: completion)
            }

        }.resume()
        
    
    }
    
    private func executeCompletionMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()){
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
   
}
