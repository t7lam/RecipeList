//
//  CachedImageView.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/10/24.
//

import SwiftUI

struct CachedImageView: View {
    let viewModel: CachedImageViewModel
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "photo")
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        isLoading = true
        if let loadingImage = await viewModel.loadImage() {
            image = loadingImage
            isLoading = false
        }
    }
}

#Preview {
    CachedImageView(viewModel: CachedImageViewModel(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg")!, size: .small))
}
