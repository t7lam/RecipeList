//
//  RecipeRowView.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/9/24.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @State private var isExpanded = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    // Recipe Image, use cache image here
                    
                    CachedImageView(viewModel: CachedImageViewModel(url: recipe.photoUrlSmall, size: .small))
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .padding(.horizontal, 8)
                    // Recipe Details
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                        Text(recipe.cuisine)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                        .animation(.easeInOut, value: isExpanded)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expanded section
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    // video player here
                    if let youtubeUrl = recipe.youtubeUrl {
                        WebVideoView(videoURL: youtubeUrl)
                            .frame(height: 350)
                            .clipShape(.containerRelative)
                    }
                    // source link here
                    if let sourceUrl = recipe.sourceUrl {
                        Link(destination: sourceUrl) {
                            HStack {
                                Text("View Recipe Source")
                                Image(systemName: "link")
                            }
                            .font(.subheadline)
                        }
                        .foregroundStyle(.blue)
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
                .padding(.top, 8)
            }
        }
        .padding(8)
    }
}
