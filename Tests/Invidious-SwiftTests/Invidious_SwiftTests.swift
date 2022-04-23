import XCTest
@testable import Invidious_Swift

final class Invidious_SwiftTests: XCTestCase {
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
        if (await inv.channel(udid: "UCeEf90AEmmxaQs5BUkHqR3Q").author == "mitxela") {
            check += 1
        } else {
            issues.append("channel")
        }
        
        //MARK: - Verify
        let total = 5
        if check < total && issues.count != 0 {
            print("[InvTesting] Test failed, refer to issues caught below (\(check)/\(total)")
            print("[InvTesting] \(issues)")
        } else {
            print("[InvTesting] Test succeeded (\(check)/\(total))")
        }
    }
}
