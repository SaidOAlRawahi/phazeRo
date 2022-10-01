//
//  Extentions.swift
//  Marvel App
//
//  Created by Said Al Rawahi
//

import Foundation
import UIKit




//The code is used to load the images within the tableviews from the given urls.
//This code is brought by the help of Pushpendra Saini video in YouTube
//Check the link for Further information: https://www.youtube.com/watch?v=6smmGjep75s&t=4s

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadFrom(URLAddress: String) {
        
        if let loadedImage = imageCache.object(forKey: URLAddress as NSString) as? UIImage{
            self.image = loadedImage
            return
        }
        
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageCache.setObject(loadedImage, forKey: URLAddress as NSString)
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
}
