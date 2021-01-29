//
//  Network.swift
//  Interview
//
//  Created by Sean Lintern on 28/01/2021.
//

import Foundation

enum NetworkError {
    case failure(code: Int)
    case timeout
}

protocol Network {
    func perform(urlRequest: URLRequest, completion: @escaping (Data?, NetworkError?) -> Void)
}

class NetworkManager: Network {
    private static let successRange = 200..<309

    func perform(urlRequest: URLRequest, completion: @escaping (Data?, NetworkError?) -> Void) {
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    let code = httpResponse.statusCode

                    if NetworkManager.successRange.contains(code) {
                        completion(data, nil)
                    } else {
                        completion(data, .failure(code: code))
                    }
                } else {
                    completion(nil, .timeout)
                }
            }
        }).resume()
    }
}
