//
//  CommentsCoordinator.swift
//  Interview
//
//  Created by Sean Lintern on 29/01/2021.
//

import UIKit

protocol Coordinator {
    var children: [Coordinator] {get}
    func start()
}

class AppCoordinator: Coordinator {
    enum Event {
        case initial

        //Comments
        case willShowComments
    }

    var children = [Coordinator]()

    var context: UINavigationController

    var network = NetworkManager()

    init(context: UINavigationController) {
        self.context = context
    }

    func start() {
        loop(event: .initial)
    }

    private func loop(event: Event) {
        let next = Self.state(event: event)

        switch next {
        case .willShowComments:
            let coordinator = CommentCoordinator(context: context,
                                                 thread: "1",
                                                 network: network)
            children.append(coordinator)
            coordinator.start()
        default:
            fatalError("Unhandled state \(String(describing: self))")
        }
    }
}

extension AppCoordinator {
    static func state(event: Event) -> Event {
        switch event {
        case .initial:
            return .willShowComments

        default:
            fatalError("Unhandled state \(String(describing: self))")
        }
    }
}
