//
//  ImageCacheManager.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/10/24.
//

import UIKit

enum ImageSize {
    case small
    case large
}

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    private let fileManager = FileManager.default
    internal let cacheDirectory: URL
    
    private init() {
        // Get cache directory url
        let directoryPath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = directoryPath[0].appendingPathComponent("ImageCache")
        
        // Create directory if it does not already exist
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    internal func getFileName(for url: URL, size: ImageSize) -> String {
        let name = url.pathComponents[url.pathComponents.count-2]
        let prefix = size == .small ? "small_" : "large_"
        return prefix + name
    }
    
    // Save image to disk to cache
    func saveImageToCache(_ image: UIImage, url: URL, size: ImageSize) throws {
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image to JPEG data")
            throw NSError(domain: "ImageCacheManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG data"])
        }
        let filename = getFileName(for: url, size: size)
        let fileURL = cacheDirectory.appendingPathComponent(filename)
        try? data.write(to: fileURL)
    }
    
    // Load image from cache on disk
    func loadImage(url: URL, size: ImageSize) -> UIImage? {
        let filename = getFileName(for: url, size: size)
        let fileURL = cacheDirectory.appendingPathComponent(filename)
        do {
            let data = try Data(contentsOf: fileURL)
            if let image = UIImage(data: data) {
                print("Image loaded successfully from: \(fileURL.path)")
                return image
            } else {
                print("Failed to create UIImage from data at: \(fileURL.path)")
                return nil
            }
        } catch {
            print("Error loading image: \(error)")
            return nil
        }
    }
}
