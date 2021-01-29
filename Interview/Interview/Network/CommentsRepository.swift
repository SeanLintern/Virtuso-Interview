//
//  CommentsRepository.swift
//  Interview
//
//  Created by Sean Lintern on 28/01/2021.
//

import Foundation

protocol CommentRepository {
    func getComments(thread: String, completion: @escaping (_ comments: [Comment]) -> Void)
}

class CommentNetwork: CommentRepository {
    private enum Endpoints {
        case commmentThread(id: String)

        var url: URL? {
            switch self {
            case .commmentThread(let id):
                return URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)/comments")
            }
        }
    }

    private var network: Network

    init(network: Network) {
        self.network = network
    }

    func getComments(thread: String, completion: @escaping ([Comment]) -> Void) {
        guard let url = Endpoints.commmentThread(id: thread).url else {
            completion([])
            return
        }

        let request = URLRequest(url: url)

        network.perform(urlRequest: request) { (data, error) in
            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let commments = try decoder.decode([Comment].self, from: data)
                    completion(commments)
                } catch {
                    // return malformed JSON error?
                    completion([])
                }
            } else {
                completion([])
            }
        }
    }
}
