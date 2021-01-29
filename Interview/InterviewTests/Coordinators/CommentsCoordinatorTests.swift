import XCTest
@testable import Interview

class CommentsCoordinatorTests: XCTestCase {
    func testState() {
        XCTAssertEqual(CommentCoordinator.state(event: .initial), .willShowCommentThread)
        XCTAssertEqual(CommentCoordinator.state(event: .didSelectComment(id: 1)), .willShowComment(id: 1))
    }
}
