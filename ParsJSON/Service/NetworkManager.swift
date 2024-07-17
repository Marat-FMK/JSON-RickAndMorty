//
//  NetworkManager.swift
//  ParsJSON
//
//  Created by Marat Fakhrizhanov on 17.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
   
    static let shared = NetworkManager()
   
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping(RickAndMorty) ->Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(rickAndMorty)
                }
            } catch let error {
                print( error )
            }
        }.resume()
    }


func fetchEpisode( from url: String, completion: @escaping(Result<Episode, NetworkError>) -> Void) {
    guard let url = URL(string: url) else {
        completion(.failure(.invalidUrl))
        return }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
            completion(.failure(.noData))
            print(error?.localizedDescription ?? " No description")
            return
        }
        
        do {
            let episode = try JSONDecoder().decode(Episode.self, from: data)
            DispatchQueue.main.async{
                completion(.success(episode))
            }
        } catch let error {
            completion(.failure(.decodingError))
        }
        
    }.resume()
}

func fetchCharacter(from url: String, completion: @escaping (Character) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
            print(error?.localizedDescription ?? "no description")
            return
        }
        
        do {
            let result = try JSONDecoder().decode(Character.self, from: data)
            DispatchQueue.main.async{
                completion(result)
            }
        } catch let error {
            print(error)
        }
    }.resume()
}
}

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage( from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
    
}
