//
//  APIManagerTests.swift
//  RecipeListTests
//
//  Created by Tommy Lam on 11/10/24.
//

import XCTest
@testable import RecipeList

final class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiManager = APIManager.shared
    }
    
    override func tearDownWithError() throws {
        apiManager = nil
        try super.tearDownWithError()
    }
    
    func testFetchRecipes_Success() async throws {

        let recipes = try await apiManager.fetchRecipes()
        XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty")
        
        let firstRecipe = recipes[0]
        XCTAssertFalse(firstRecipe.id.isEmpty, "Recipe ID should not be empty")
        XCTAssertFalse(firstRecipe.name.isEmpty, "Recipe name should not be empty")
        XCTAssertFalse(firstRecipe.cuisine.isEmpty, "Recipe cuisine should not be empty")
        XCTAssertTrue(firstRecipe.photoUrlLarge.absoluteString.contains("large"))
        XCTAssertTrue(firstRecipe.photoUrlSmall.absoluteString.contains("small"))
    }
    
    func testFetchRecipes_MalformedData() async {
        // Given
        apiManager.dataApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        
        // When/Then
        do {
            _ = try await apiManager.fetchRecipes()
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertTrue(error is CustomError, "Error should be a CustomError")
            XCTAssertEqual(error as? CustomError, .decodeError, "Error should be CustomError.decodeError")
        }
    }
    
    func testFetchRecipes_EmptyData() async throws {
        // Given
        apiManager.dataApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        
        // When
        let recipes = try await apiManager.fetchRecipes()
        
        // Then
        XCTAssertTrue(recipes.isEmpty, "Recipes array should be empty")
    }
    
    func testFetchRecipes_InvalidURL() async {
        // Given
        apiManager.dataApi = " "
        
        // When/Then
        do {
            _ = try await apiManager.fetchRecipes()
            XCTFail("Expected URL error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
    func testFetchRecipes_AllFieldTypes() async throws {
        // When
        let recipes = try await apiManager.fetchRecipes()
        
        // Then
        guard let recipe = recipes.first else {
            XCTFail("No recipes returned")
            return
        }
        
        // Test required fields
        XCTAssertNotNil(recipe.id)
        XCTAssertNotNil(recipe.name)
        XCTAssertNotNil(recipe.cuisine)
        XCTAssertNotNil(recipe.photoUrlLarge)
        XCTAssertNotNil(recipe.photoUrlSmall)
        
        // Print recipe details for debugging
        print("Recipe ID: \(recipe.id)")
        print("Recipe Name: \(recipe.name)")
        print("Recipe Cuisine: \(recipe.cuisine)")
        print("Large Photo URL: \(recipe.photoUrlLarge)")
        print("Small Photo URL: \(recipe.photoUrlSmall)")
        print("Source URL: \(String(describing: recipe.sourceUrl))")
        print("YouTube URL: \(String(describing: recipe.youtubeUrl))")
    }
    
}
