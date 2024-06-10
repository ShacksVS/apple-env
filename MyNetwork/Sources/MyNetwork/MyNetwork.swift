// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Kingfisher
import FirebasePerformance

enum NetworkErrors: Error {
    case invalidURL
    case invalidAnimal
}

let animalNames = ["Whiskers", "Shadow", "Luna", "Oliver", "Leo", "Milo", "Charlie", "Simba", "Max", "Oreo", "Bella", "Lucy", "Molly", "Chloe", "Tiger"]

@available(iOS 14.0, *)
public struct Animal: Codable, Hashable {
    public let url: String
    
    public var photo: KFImage {
        let traceAnimalImage = Performance.startTrace(name: "loading_animal_image")
        let animalImage = KFImage(URL(string: url))
        traceAnimalImage?.stop()
        
        return animalImage
    }
    
    public var animalName: String {
        let hash = url.hashValue
        let index = abs(hash) % animalNames.count
        return animalNames[index]
    }
    
    public static func mock() -> Animal {
        return Animal(url: "https://cdn2.thecatapi.com/images/4s8.jpg")
    }
}

@available(iOS 14.0, *)
public func getAnimals() async throws -> [Animal] {
    guard let animalName = (Bundle.main.object(forInfoDictionaryKey: "Animal") as? String) else {
        throw NetworkErrors.invalidAnimal
    }
    
    var targetAnimal: String
    
    if animalName == "CATS" {
        targetAnimal = "cat"
    } else {
        targetAnimal = "dog"
    }
    
    let endPoint = "https://api.the\(targetAnimal)api.com/v1/images/search?limit=10"
    
    guard let componentURL = URLComponents(string: endPoint) else {
        throw NetworkErrors.invalidURL
    }
    do {
        let (apiData, _) = try await URLSession.shared.data(from: componentURL.url!)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode([Animal].self, from: apiData)
        
        return response
    }
}
