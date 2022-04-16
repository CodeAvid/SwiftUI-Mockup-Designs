//
//  ImageLoader.swift
//  SwiftUIMovieDbb
//
//  Created by Benjamin Akhigbe on 15/04/2022.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject{
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache
    
    //load image from memory
    
    func loadImage(with url: URL){
        //get the image raw string value
        let urlString = url.absoluteString
        
        //Retrieve the image from memory(cache)
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            
            //Published the image
            self.image = imageFromCache
            return
        }
        
        //if failed to image from memory, store the image in background thread
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                //Retrieve the image data
                let data = try Data(contentsOf: url)
                
                //create a new image
                guard let image = UIImage(data: data) else {
                    return
                }
                
                //Store the image in memory
                self?.imageCache.setObject(image, forKey: urlString as AnyObject)
                
                //Update the image in the main thread
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
                        
                
            } catch{
                print(error.localizedDescription)
            }
            
        }
        
    }
}
