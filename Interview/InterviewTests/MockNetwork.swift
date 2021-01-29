import Foundation
import XCTest
@testable import Interview

class MockNetwork: Network {
    enum MockingType {
        case comments
    }

    private var type: MockingType

    init(type: MockingType) {
        self.type = type
    }

    func perform(urlRequest: URLRequest, completion: @escaping (Data?, NetworkError?) -> Void) {
        switch type {
        case .comments:
            completion(json(name: "Comments"), nil)
        }
    }

    private func json(name: String) -> Data? {
        if let path = Bundle.main.path(forResource: name, ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
            return jsonData
        }
        return nil
    }
}
