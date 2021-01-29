import XCTest
@testable import Interview

class CommentsViewModelTests: XCTestCase {

    var sut: CommentsViewModel!

    var network: CommentNetwork!

    override func setUp() {
        let mockNetwork: Network = MockNetwork(type: .comments)

        self.network = CommentNetwork(network: mockNetwork)

        super.setUp()
    }

    func testCopy() throws {
        sut = CommentsViewModel(network: network,
                                thread: "1",
                                onComment: { (_) in

                                })

        XCTAssertEqual(sut.outputs.title,
                       NSLocalizedString("Comments", comment: "comment list title"))
    }

    func testFlow() throws {
        let testComment = Comment(name: "",
                                  email: "",
                                  body: "",
                                  id: 3)

        sut = CommentsViewModel(network: network,
                                thread: "1",
                                onComment: { id in
                                    XCTAssertEqual(id, testComment.id)
                                })

        sut.inputs.commentTap(comment: testComment)
    }

    func testCellModel() throws {
        sut = CommentsViewModel(network: network,
                                thread: "1",
                                onComment: {_ in})

        sut.outputs.commentsHandler = { comments in
            XCTAssertEqual(comments.count, 5)

            let expectedTestComment = comments.first

            XCTAssertNotNil(expectedTestComment)

            XCTAssertEqual(expectedTestComment?.name, "id labore ex et quam laborum")
            XCTAssertEqual(expectedTestComment?.email, "Eliseo@gardner.biz")
            XCTAssertEqual(expectedTestComment?.body, "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
            XCTAssertEqual(expectedTestComment?.id, 1)
        }

        sut.inputs.viewDidLoad()
    }
}
