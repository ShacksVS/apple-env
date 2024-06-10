//
//  CatDetails.swift
//  Cats App
//
//  Created by Viktor Sovyak on 5/18/24.
//

import SwiftUI
import MyNetwork

struct CatDetails: View {
    let animal: Animal
    
    var body: some View {
        VStack {
            Text("Hi, my name is \(animal.animalName)")
                .font(.title3)
            
            animal.photo
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    CatDetails(animal: Animal.mock())
}
