//
//  RecipeListView.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/9/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading && viewModel.recipes.isEmpty {
                ProgressView("Loading recipes...")
            } else if viewModel.recipes.isEmpty {
                NoRecipesView(fetchRecipes: viewModel.fetchRecipes)
            } else {
                List {
                    ForEach(viewModel.filteredRecipes) { recipe in
                        RecipeRowView(recipe: recipe)
                            .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Recipe List")
                .refreshable {
                    await viewModel.fetchRecipes()
                }
                .searchable(text: $viewModel.searchText, prompt: "Search Recipes")
                .overlay {
                    if viewModel.filteredRecipes.isEmpty && !viewModel.searchText.isEmpty {
                        NoRecipeFoundView()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    RecipeListView()
}
