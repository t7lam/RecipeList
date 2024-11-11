//
//  CachedImageViewModelTests.swift
//  RecipeListTests
//
//  Created by Tommy Lam on 11/10/24.
//

import XCTest
@testable import RecipeList

final class CachedImageViewModelTests: XCTestCase {
    
    var viewModel: CachedImageViewModel!
    let testImageURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/51271127-2c5f-4b65-87d4-f56f8f9a9549/small.jpg")!
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = CachedImageViewModel(url: testImageURL, size: .small)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        // Clear the image cache
        try? FileManager.default.removeItem(at: ImageCacheManager.shared.cacheDirectory)
        try super.tearDownWithError()
    }
    
    
    func testLoadImage_InvalidURL() async {
        // Given
        viewModel = CachedImageViewModel(url: URL(string: "https://invalid-url.com/nonexistent.jpg")!, size: .small)
        
        // When
        let result = await viewModel.loadImage()
        
        // Then
        XCTAssertEqual(result, UIImage(systemName: "photo"), "Should return placeholder for invalid URL")
    }
    
}
