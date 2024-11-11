//
//  APIManager.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/9/24.
//

import Foundation

enum CustomError: Error {
    case decodeError
}

class APIManager {
    static var shared = APIManager()
    
    private init() {}
    
    internal var dataApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedDataApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyDataApi = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: dataApi) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let recipes = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return recipes.recipes
        } catch {
            print("Decode Error \(error)")
            throw CustomError.decodeError
        }
    }
}
