//
//  NoRecipeFoundView.swift
//  RecipeList
//
//  Created by Tommy Lam on 11/10/24.
//

import SwiftUI

struct NoRecipeFoundView: View {
    var body: some View {
        HStack {
            Image(systemName: "fork.knife.circle")
            
            Text("No Recipes Found")
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding(8)
    }
}

#Preview {
    NoRecipeFoundView()
}
