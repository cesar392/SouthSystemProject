//
//  APIRequest.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 01/08/22.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encondingProblem
}

struct APIRequest {
    let resourceURL: URL

    init(endpoint: Endpoints) {
        let resourceString = Constants.APIURL + endpoint.rawValue
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }

    func fetch(completion: @escaping (Result<[Event], APIError>) -> ()) {
        let urlRequest = URLRequest(url: resourceURL)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let messageData = try JSONDecoder().decode([Event].self, from: data)
                completion(.success(messageData))
            } catch {
                completion(.failure(.decodingProblem))
                return
            }
        }.resume()
    }

    func save(people: People, completion: @escaping(Result<Event, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            urlRequest.httpBody = try JSONEncoder().encode(people)

            let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let jsonData = data else {
                          print("StatusCode: \((response as? HTTPURLResponse)?.statusCode)")
                          completion(.failure(.responseProblem))
                          return
                      }
                do {
                    let messageData = try JSONDecoder().decode(Event.self, from: jsonData)
                    completion(.success(messageData))
                }
                catch {
                    completion(.failure(.decodingProblem))
                }
            })
            dataTask.resume()
        } catch {
            completion(.failure(.encondingProblem))
        }
    }

}
