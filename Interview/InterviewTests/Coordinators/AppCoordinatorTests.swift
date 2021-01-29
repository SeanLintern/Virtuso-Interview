import XCTest
@testable import Interview

class AppCoordinatorTests: XCTestCase {
    func testState() {
        XCTAssertEqual(AppCoordinator.state(event: .initial), .willShowComments)
    }
}
