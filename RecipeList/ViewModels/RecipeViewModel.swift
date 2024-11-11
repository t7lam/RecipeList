//
//  RecipeViewModel.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/9/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var searchText = ""
    
    var filteredRecipes: [Recipe] {
        guard !searchText.isEmpty else { return recipes }
        return recipes.filter { recipe in
            recipe.name.localizedCaseInsensitiveContains(searchText) || recipe.cuisine.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    @MainActor
    func fetchRecipes() async {
        isLoading = true
        error = nil
        do {
            recipes = try await APIManager.shared.fetchRecipes()
        } catch {
            print("Retrieval error: \(error)")
            self.error = error
        }
        isLoading = false
    }
}
