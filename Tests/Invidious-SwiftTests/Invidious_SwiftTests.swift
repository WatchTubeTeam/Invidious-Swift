import XCTest
@testable import Invidious_Swift

final class Invidious_SwiftTests: XCTestCase {
    func testStr() async throws {
        let str = await inv.captions(id: "eTcVLqKpZJc").captions[0]
        print("[InvTesting] \(str.downloadURL())")
    }
    func testMain() async throws {
        //idk how to do tests
        var issues: [String] = []
        var check = 0
        
        //MARK: - Tests
        
        if (await inv.stats().software.name == "invidious") {
            check += 1
        } else { issues.append("stats") }
        
        if (await inv.video(id: "eTcVLqKpZJc").title == "Dangerous Code Hidden in Plain Sight for 12 years") {
            check += 1
        } else { issues.append("video") }
        
        if (await inv.comments(id: "eTcVLqKpZJc").comments.count != 0) {
            check += 1
        } else { issues.append("comments") }
        
        let str = await inv.captions(id: "eTcVLqKpZJc").captions[0].createCaptions()
        if (str!.label == "English (auto-generated)") {
            check += 1
        } else {
            issues.append("captions")
        }
        
        //MARK: - Verify
        
        if check != 4 {
            print("[InvTesting] Test failed, refer to issues caught below")
            print("[InvTesting] \(issues)")
        } else {
            print("[InvTesting] Test succeeded")
        }
    }
}
