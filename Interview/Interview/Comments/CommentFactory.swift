//
//  CommentFactory.swift
//  Interview
//
//  Created by Sean Lintern on 29/01/2021.
//

import UIKit

struct CommentFactory {
    static func start(context: UINavigationController,
                      network: CommentRepository,
                      thread: String,
                      coordinator: CommentCoordinator) {
        let viewmodel = CommentsViewModel(network: network, thread: thread) { id in
            coordinator.loop(event: .didSelectComment(id: id))
        }
        let storyboard = UIStoryboard(name: "Comments", bundle: nil)
        let controller: CommentsViewController = storyboard.instantiateInitialViewController() as! CommentsViewController
        controller.viewModel = viewmodel
        context.pushViewController(controller, animated: true)
    }
}
