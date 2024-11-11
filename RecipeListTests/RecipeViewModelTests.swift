//
//  RecipeViewModelTests.swift
//  RecipeListTests
//
//  Created by Tommy Lam on 11/10/24.
//

import XCTest
@testable import RecipeList

final class RecipeViewModelTests: XCTestCase {
    
    var viewModel: RecipeViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = RecipeViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Filtering Tests
    
    func testFilteredRecipes_EmptySearchText_ReturnsAllRecipes() {
        viewModel.recipes = createMockRecipes()
        viewModel.searchText = ""
        let filteredRecipes = viewModel.filteredRecipes
        XCTAssertEqual(filteredRecipes.count, 3)
    }
    
    func testFilteredRecipes_SearchByName_ReturnsMatchingRecipes() {
        viewModel.recipes = createMockRecipes()
        viewModel.searchText = "pasta"
        let filteredRecipes = viewModel.filteredRecipes
        XCTAssertEqual(filteredRecipes.count, 1)
        XCTAssertEqual(filteredRecipes.first?.name, "Pasta Carbonara")
    }
    
    func testFilteredRecipes_SearchByCuisine_ReturnsMatchingRecipes() {
        viewModel.recipes = createMockRecipes()
        viewModel.searchText = "italian"
        let filteredRecipes = viewModel.filteredRecipes
        XCTAssertEqual(filteredRecipes.count, 2)
        XCTAssertTrue(filteredRecipes.contains(where: { $0.name == "Pasta Carbonara" }))
        XCTAssertTrue(filteredRecipes.contains(where: { $0.name == "Pizza" }))
    }
    
    func testFilteredRecipes_CaseInsensitiveSearch() {
        viewModel.recipes = createMockRecipes()
        viewModel.searchText = "PASTA"
        let filteredRecipes = viewModel.filteredRecipes
        XCTAssertEqual(filteredRecipes.count, 1)
        XCTAssertEqual(filteredRecipes.first?.name, "Pasta Carbonara")
    }
    
    // MARK: - Fetch Recipes Tests
    
    func testFetchRecipes_Success() async {
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.count, 63)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchRecipes_Error() async {
        APIManager.shared.dataApi = "https://invalid-url-for-testing.com"
        await viewModel.fetchRecipes()
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    // MARK: - Mock Recipe Creation
    
    private func createMockRecipes() -> [Recipe] {
        return [
            Recipe(id: "1",
                   name: "Pasta Carbonara",
                   cuisine: "Italian",
                   photoUrlLarge: URL(string: "https://example.com/large/pasta.jpg")!,
                   photoUrlSmall: URL(string: "https://example.com/small/pasta.jpg")!,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "2",
                   name: "Pizza",
                   cuisine: "Italian",
                   photoUrlLarge: URL(string: "https://example.com/large/pizza.jpg")!,
                   photoUrlSmall: URL(string: "https://example.com/small/pizza.jpg")!,
                   sourceUrl: nil,
                   youtubeUrl: nil),
            Recipe(id: "3",
                   name: "Sushi",
                   cuisine: "Japanese",
                   photoUrlLarge: URL(string: "https://example.com/large/sushi.jpg")!,
                   photoUrlSmall: URL(string: "https://example.com/small/sushi.jpg")!,
                   sourceUrl: nil,
                   youtubeUrl: nil)
        ]
    }
    
}
