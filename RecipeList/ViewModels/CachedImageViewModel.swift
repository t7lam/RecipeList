//
//  CachedImageViewModel.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/10/24.
//

import SwiftUI
import Combine

struct CachedImageViewModel {
    let url: URL
    let size: ImageSize
    
    func loadImage() async -> UIImage? {
        
        // Load from cache
        if let cachedImage = ImageCacheManager.shared.loadImage(url: url, size: size) {
            return cachedImage
        }
        
        // If not in cache, fetch then save to cache
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let downloadedImage = UIImage(data: data) else {
                return UIImage(systemName: "photo")
            }
            
            try ImageCacheManager.shared.saveImageToCache(downloadedImage, url: url, size: size)
            return downloadedImage
        } catch {
            print("Error loading image: \(error)")
            return UIImage(systemName: "photo")
        }
        
    }
}
