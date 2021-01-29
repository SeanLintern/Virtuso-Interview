import Foundation

protocol CommentsViewModelProtocol {
    var inputs: CommentsViewModelInputsProtocol {get}
    var outputs: CommentsViewModelOutputsProtocol {get set}
}

protocol CommentsViewModelInputsProtocol {
    func viewDidLoad()
    func commentTap(comment: CommentCellViewModel)
}

protocol CommentsViewModelOutputsProtocol {
    var commentsHandler: CommentsHandler? {get set}
    var loadingHandler: isLoadingHandler? {get set}

    var title: String {get}
}

typealias CommentsHandler = (_ comments: [CommentCellViewModel]) -> Void
typealias isLoadingHandler = (_ isLoading: Bool) -> Void

class CommentsViewModel: CommentsViewModelProtocol {
    let inputs: CommentsViewModelInputsProtocol
    var outputs: CommentsViewModelOutputsProtocol

    private var network: CommentRepository
    private var thread: String

    init(network: CommentRepository, thread: String, onComment: @escaping (_ id: Int) -> Void) {
        self.network = network
        self.thread = thread

        let outputs = Outputs(title: NSLocalizedString("Comments", comment: "comment list title"))
        self.outputs = outputs

        let inputs = Inputs(onLoad: {
            outputs.loadingHandler?(true)

            network.getComments(thread: thread) { (comments) in
                outputs.loadingHandler?(false)
                outputs.commentsHandler?(comments)
            }
        }, commentTap: { comment in
            onComment(comment.id)
        })

        self.inputs = inputs
    }
}

extension CommentsViewModel {
    class Inputs: CommentsViewModelInputsProtocol {
        let onLoad: () -> Void
        let commentTap: (_ comment: CommentCellViewModel) -> Void

        init(onLoad: @escaping () -> Void,
             commentTap: @escaping (_ comment: CommentCellViewModel) -> Void) {
            self.onLoad = onLoad
            self.commentTap = commentTap
        }

        func viewDidLoad() {
            onLoad()
        }

        func commentTap(comment: CommentCellViewModel) {
            commentTap(comment)
        }
    }
}

extension CommentsViewModel {
    class Outputs: CommentsViewModelOutputsProtocol {
        var commentsHandler: CommentsHandler?
        var loadingHandler: isLoadingHandler?

        var title: String

        init(title: String) {
            self.title = title
        }
    }
}
