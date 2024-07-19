//
//  RickAndMorty.swift
//  ParsJSON
//
//  Created by Marat Fakhrizhanov on 17.07.2024.
//






struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    
    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Gender: \(gender)
    Origin: \(origin.name)
    Location: \(location.name)
    """
    }
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
    let date: String
    let episode: String
    let characters: [String]
    
    var description: String {
        """
    Title: \(name)
    Date: \(date)
    """
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}

enum Link: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
}

//
//struct RickAndMorty: Decodable {
//    let info: Info
//    let results: [Character]
//}
//
//struct Info: Decodable {
////    let count: Int
//    let page : Int
//    let next: String?
//    let prev: String?
//}
//
//struct Character: Decodable {
//    let id: Int
//    let name: String
//    let status: String
//    let species: String
//    let gender: String
//    let origin: Location
//    let location: Location
//    let image: String
//    let episode: [String]
//    let url: String
//    
//    var description: String {
//        """
//Name: \(name)
//Statys: \(status)
//Species: \(species)
//Gender: \(gender)
//Origin: \(origin.name)
//Location: \(location.name)
//"""
//    }
//}
//
//struct Location: Decodable {
//    let name: String
//}
//
//struct Episode: Decodable {
//    let name: String
//    let data: String
//    let episode: String
//    let characters: [String]
//    
//    var description: String {
//        """
//Title: \(name)
//Data: \(data)
//"""
//    }
//        enum CodingKeys: String, CodingKey {
//            case name = "name"
//            case data = "air_date"
//            case episode = "episode"
//            case characters = "characters"
//        }
//    }
//
//enum Link: String {
//    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
//}
//
