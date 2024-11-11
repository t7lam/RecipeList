//
//  ImageCacheManagerTests.swift
//  RecipeListTests
//
//  Created by Tommy Lam on 11/10/24.
//

import UIKit
import XCTest
@testable import RecipeList

final class ImageCacheManagerTests: XCTestCase {
    var imageCacheManager: ImageCacheManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        imageCacheManager = ImageCacheManager.shared
        
    }
    
    override func tearDownWithError() throws {
        let fileManager = FileManager.default
        let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ImageCache")
        try? fileManager.removeItem(at: cacheURL)
        imageCacheManager = nil
        try super.tearDownWithError()
    }
    
    func testSharedInstanceExists() {
        XCTAssertNotNil(ImageCacheManager.shared)
    }
    
    
    
    func testGetFileName() {
        let urlSmall = URL(string: "https://example.com/recipes/pasta/image.jpg")!
        let smallFileName = imageCacheManager.getFileName(for: urlSmall, size: .small)
        XCTAssertEqual(smallFileName, "small_pasta")
        
        let urlLarge = URL(string: "https://example.com/food/pizza/photo.jpg")!
        let largeFileName = imageCacheManager.getFileName(for: urlLarge, size: .large)
        XCTAssertEqual(largeFileName, "large_pizza")
    }
    
    func testSaveAndLoadImage() {
        guard let testImage = UIImage(named: "test") else {
            XCTFail("Failed to load TestImage from asset catalog")
            return
        }
        
        let url = URL(string: "https://example.com/recipes/salad/image.jpg")!
        
        do {
            try imageCacheManager.saveImageToCache(testImage, url: url, size: .small)
        } catch {
            XCTFail("Failed to save image")
        }
        
        let loadedImage = imageCacheManager.loadImage(url: url, size: .small)
        XCTAssertNotNil(loadedImage, "Loaded image should not be nil")
    }
    
    func testLoadNonExistentImage() {
        let url = URL(string: "https://example.com/recipes/nonexistent/image.jpg")!
        let loadedImage = imageCacheManager.loadImage(url: url, size: .large)
        XCTAssertNil(loadedImage, "Loading non-existent image should return nil")
    }
    
    func testSaveAndLoadBothSizes() {
        guard let testImage = UIImage(named: "test") else {
            XCTFail("Failed to load TestImage from asset catalog")
            return
        }
        
        let url = URL(string: "https://example.com/recipes/burger/image.jpg")!
        
        do {
            try imageCacheManager.saveImageToCache(testImage, url: url, size: .small)
        } catch {
            XCTFail("Failed to save image")
        }
        let loadedSmallImage = imageCacheManager.loadImage(url: url, size: .small)
        XCTAssertNotNil(loadedSmallImage, "Small image should load")
        
        do {
            try imageCacheManager.saveImageToCache(testImage, url: url, size: .large)
        } catch {
            XCTFail("Failed to save image")
        }
        let loadedLargeImage = imageCacheManager.loadImage(url: url, size: .large)
        XCTAssertNotNil(loadedLargeImage, "Large image should load")
        XCTAssertNotEqual(
            imageCacheManager.getFileName(for: url, size: .small),
            imageCacheManager.getFileName(for: url, size: .large),
            "Small and large image filenames should be different"
        )
    }
}
