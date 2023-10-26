//
//  APIHelper.swift
//  GoonsDesignInterview
//
//  Created by TC Lee on 2023/10/26.
//

import Foundation
import UIKit
typealias completionHandler = (Data?, URLResponse?, Error?) -> Void

class communicator{
    static let shared = communicator()
    private init() {}
    
    
    let url = URL(string: "https://api.github.com/search/repositories")!
    var result : [Repo] = []
    
    private func doGet(url:URL,queryParams:[String:String],completion:@escaping completionHandler){
        //Convert
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let finalURL = components?.url else {
            completion(nil, nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request,completionHandler: completion)
        task.resume()
    }
    
    private func decodeJSONToStruct<T: Decodable>(_ jsonData: Data, as type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(type, from: jsonData)
            return object
        } catch {
            print("Failed to decode JSON to struct: \(error)")
            return nil
        }
    }
    
    func searchRepo(keyword:String,completion:@escaping (Result<[Repo], Error>) -> Void){
        //Convert
        let query = ["q":keyword,]
        
        doGet(url: url, queryParams: query) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  let data = data else {
                let customError = NSError(domain: "NetworkError", code: 0, userInfo:[NSLocalizedDescriptionKey: "Failed to retrive data"] )
                completion(.failure(customError))
                return
            }
            
            let statusCode = response.statusCode
            
            switch statusCode{
            case 200:
                // ok
                guard let result = self.decodeJSONToStruct(data, as: GitHubGetResult.self) else{
                    let customError = NSError(domain: "DecodingError", code: 0,userInfo:[NSLocalizedDescriptionKey: "Failed to convert data"])
                    completion(.failure(customError))
                    return
                }
                completion(.success(result.items))
            case 304:
                // Not modified
                let customError = NSError(domain: "RequestError", code: 304,userInfo:[NSLocalizedDescriptionKey: "Not modified"])
                completion(.failure(customError))
            case 422:
                let customError = NSError(domain: "RequestError", code: 422,userInfo:[NSLocalizedDescriptionKey: "Validation failed, or the endpoint has been spammed."])
                completion(.failure(customError))
            case 503:
                //Service unavailable
                let customError = NSError(domain: "RequestError", code: 503,userInfo:[NSLocalizedDescriptionKey: "Service unavailable"])
                completion(.failure(customError))
            default:
                break
            }
            
            
            
        }
    }
    
    func getIcon(url:URL,completion:@escaping(Result<UIImage,Error>)->Void){
        doGet(url: url, queryParams: [:]) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  let data = data ,
                  let image = UIImage(data: data)else{
                let customError = NSError(domain: "NetworkError", code: 0, userInfo:[NSLocalizedDescriptionKey: "Failed to retrive data"] )
                completion(.failure(customError))
                return
            }
            
            completion(.success(image))
            
            
        }
        
        
    }
    
}
