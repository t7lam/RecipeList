//
//  Recipe.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/9/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let photoUrlLarge: URL
    let photoUrlSmall:URL
    let sourceUrl: URL?
    let youtubeUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}
