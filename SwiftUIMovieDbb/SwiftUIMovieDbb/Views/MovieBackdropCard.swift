//
//  MovieBackdropCard.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import Foundation
import SwiftUI


struct MovieBackDropCard: View{
    
    let movie: Movie
    
    @ObservedObject var imageLoader = ImageLoader()
    
    //    let movieStub = Movie.stubbedMovie
    
    var body: some View{
        VStack(alignment: .leading){
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil{
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow( radius: 4)
            Text(movie.title)
        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropUrl)
        }
    }
}

struct MovieBackDropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackDropCard(movie: Movie.stubbedMovie)
        
    }
}
