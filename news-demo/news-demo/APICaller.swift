//
//  APICaller.swift
//  news-demo
//
//  Created by Johel Zarco on 13/06/22.
//

import Foundation

final class APICaller{
    
    static let shared = APICaller()
    let apiKey : String = ""
    let searchWord : String = ""
    
    lazy var urlString : String = "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + apiKey
    lazy var searchUrl : String = "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + apiKey + "&q="
    
    lazy var topHeadlinesURL = URL(string : urlString)
    
    
    private init(){}
    
    public func getTopStories(completion : @escaping(Result<[Article], Error>) -> Void){
        
        guard let url = topHeadlinesURL else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Something went really wrong :(")
            }
            else if let data = data{
                // decode json
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    } //getTopStories
    
    public func search(with query: String, completion : @escaping(Result<[Article], Error>) -> Void){
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        let urlAsString = searchUrl + query
        let searchURL = URL(string: urlAsString)
        guard let url = searchURL else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Something went really wrong :(")
            }
            else if let data = data{
                // decode json
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    } //search
    
    
}

// MARK: models
struct Source : Codable{
    let name : String
}
struct Article : Codable{
    let source : Source
    let title : String
    let description : String?
    let url : String
    let urlToImage : String?
    let publishedAt : String
}

struct APIResponse : Codable{
    let articles : [Article]
}
