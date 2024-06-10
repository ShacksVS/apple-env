//
//  CatCell.swift
//  Cats App
//
//  Created by Viktor Sovyak on 5/18/24.
//

import SwiftUI
import MyNetwork

struct CatCell: View {
    let animal: Animal
    
    var body: some View {
        VStack {
            animal.photo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
            
            Text(animal.animalName)
                .font(.title3)
                .foregroundStyle(Color(UIColor.systemMint))
            
            Divider()
        }
    }
}



#Preview {
    CatCell(animal: Animal.mock())
}
