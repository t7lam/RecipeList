//
//  NoRecipesView.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/10/24.
//

import SwiftUI

struct NoRecipesView: View {
    let fetchRecipes: () async -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "fork.knife.circle")
            Text("There are no recipes at the moment.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button {
                Task {
                    await fetchRecipes()
                }
            } label: {
                HStack {
                    Text("Retry")
                    Image(systemName: "arrow.clockwise")
                }
            }
            .padding(4)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
    }
}

#Preview {
    NoRecipesView(fetchRecipes: {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch {
            
        }
        return
    })
}
