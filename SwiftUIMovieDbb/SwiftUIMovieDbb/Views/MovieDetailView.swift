//
//  MovieDetailView.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack{
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(with: self.movieId)
            }
            
            if movieDetailState.movie != nil{
                MovieDetailListView(movie: self.movieDetailState.movie!)
                   
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "BloodShare")
        .onAppear {
            self.movieDetailState.loadMovie(with: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    @State private var selectedTrailer: MovieVideo?
    
    var body: some View{
        ScrollView {
            MovieDetailImage(imageUrl: movie.backdropUrl)
                .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            LazyVStack{
            
                HStack{
                    Text(movie.genreText)
                    Text(".")
                    Text(movie.yearText)
                    Text(movie.durationText)
                }
                .frame( maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                
                Text(movie.overview)
                    .padding(.bottom, 10)
                HStack{
                    if (!movie.ratingText.isEmpty){
                        Text(movie.ratingText).foregroundColor(.yellow)
                    }
                    Text(movie.scoreText)
                }
                .padding(.bottom, 10)
                
                Divider()
                
                HStack(alignment: .top, spacing: 4) {
                    if movie.crew != nil && movie.crew!.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Starring").font(.headline)
                            ForEach(self.movie.cast!.prefix(9)){ cast in
                                Text(cast.name)
                                
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                    }
                    if movie.crew != nil && movie.crew!.count > 0 {
                        VStack(alignment: .leading, spacing: 4){
                            if movie.directors != nil && movie.directors!.count > 0{
                                Text("Director(s)").font(.headline)
                                ForEach(self.movie.directors!.prefix(2)){ crew in
                                    Text(crew.name)
                                }
                            }
                            
                            if movie.producers != nil && movie.producers!.count > 0{
                                Text("Producer(s)").font(.headline)
                                    .padding(.top)
                                ForEach(self.movie.producers!.prefix(2)){ crew in
                                    Text(crew.name)
                                }
                            }
                            
                            if movie.screenWriter != nil && movie.screenWriter!.count > 0{
                                Text("StoryWriter(s)").font(.headline)
                                    .padding(.top)
                                ForEach(self.movie.screenWriter!.prefix(2)){ crew in
                                    Text(crew.name)
                                }
                            }
                           
                        }
                    }
                }
                Divider()
                
                if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0{
                    Text("Trailer").font(.headline)
                    
                    ForEach(movie.youtubeTrailers!){ trailer in
                        Button(action: {
                            self.selectedTrailer = trailer
                        }){
                            LazyHStack{
                                Text(trailer.name)
                                Spacer()
                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(Color(UIColor(.secondary)))
                            }
                        }
                    }
                    
                }
            
               
            }
            .sheet(item: self.$selectedTrailer) { trailer in
                SafariView(url: trailer.youtubeURL!)
                
            }
            .padding()
        }
    }
}



struct MovieDetailImage: View{
    @ObservedObject private var imageLoader = ImageLoader()
    
    let imageUrl: URL
    
    var body: some View{
        ZStack{
            Rectangle().fill(Color.green.opacity(0.3))
            
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageUrl)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        MovieDetailView(movieId: Movie.stubbedMovie.id)
    
    }
}
