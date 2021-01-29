//
//  CommentsCoordinator.swift
//  Interview
//
//  Created by Sean Lintern on 29/01/2021.
//

import UIKit

class CommentCoordinator: Coordinator {
    enum Event: Equatable {
        case initial

        case willShowCommentThread
        case didSelectComment(id: Int)

        case willShowComment(id: Int)
    }

    var children = [Coordinator]()

    var context: UINavigationController!

    var thread: String

    var repository: CommentRepository

    init(context: UINavigationController, thread: String, network: Network) {
        self.context = context
        self.thread = thread
        self.repository = CommentNetwork(network: network)
    }

    func start() {
        loop(event: .initial)
    }

    func loop(event: Event) {
        let next = Self.state(event: event)

        switch next {
        case .willShowCommentThread:
            CommentFactory.start(context: context,
                                 network: repository,
                                 thread: thread,
                                 coordinator: self)

        case .willShowComment(_):
            // Here we would have a individual comment factory initialised with either a comment or ID
            // then show the screen
            break

        default:
            fatalError("Unhandled state \(String(describing: self))")
        }
    }
}

extension CommentCoordinator {
    static func state(event: Event) -> Event {
        switch event {
        case .initial:
            return .willShowCommentThread

        case .didSelectComment(let id):
            return .willShowComment(id: id)

        default:
            fatalError("Unhandled state \(String(describing: self))")
        }
    }
}
