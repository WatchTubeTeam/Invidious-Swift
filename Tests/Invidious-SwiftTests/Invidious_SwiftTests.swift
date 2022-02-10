import XCTest
@testable import Invidious_Swift

final class Invidious_SwiftTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        Inv.getJson(url: URL(string: "https://invidious.osi.kr/api/v1/stats")!) { json in
            XCTAssertEqual((json!["software"] as! Dictionary<String,Any>)["name"] as! String, "egg")
        }
    }
}
