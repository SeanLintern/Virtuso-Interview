import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet private weak var commentsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: CommentsViewModelProtocol!

    var comments = [CommentCellViewModel]() {
        didSet {
            commentsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let commentCellId = String(describing: CommentTableViewCell.self)
        commentsTableView.register(UINib(nibName: commentCellId, bundle: nil), forCellReuseIdentifier: commentCellId)

        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        setupBindings()
    }

    private func setupBindings() {
        viewModel.outputs.loadingHandler = { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }

        viewModel.outputs.commentsHandler = { [weak self] comments in
            self?.comments = comments
        }

        navigationItem.title = viewModel.outputs.title
        
        viewModel.inputs.viewDidLoad()
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentTableViewCell.self), for: indexPath) as? CommentTableViewCell {
            cell.setup(comment: comments[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = comments[indexPath.row]
        viewModel.inputs.commentTap(comment: comment)
    }
}
