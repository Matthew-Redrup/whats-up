import XCTest
@testable import WhatsUp

final class WhatsUpTests: XCTestCase {
    func testSystemEventCreation() throws {
        let event = SystemEvent(
            source: .process,
            eventType: .processStart,
            details: ["name": "test"],
            educationalNote: "This is a test event"
        )
        
        XCTAssertEqual(event.source, .process)
        XCTAssertEqual(event.eventType, .processStart)
        XCTAssertEqual(event.details["name"], "test")
        XCTAssertEqual(event.educationalNote, "This is a test event")
        XCTAssertNotNil(event.id)
    }
    
    func testProcessInfoDescription() throws {
        let processInfo = ProcessInfo(
            id: 123,
            name: "Safari",
            bundleIdentifier: "com.apple.Safari",
            bundlePath: "/Applications/Safari.app",
            parentProcessID: 1,
            launchDate: Date(),
            isAppleProcess: true,
            processType: .application
        )
        
        XCTAssertEqual(processInfo.name, "Safari")
        XCTAssertEqual(processInfo.id, 123)
        XCTAssertTrue(processInfo.isAppleProcess)
        XCTAssertFalse(processInfo.description.isEmpty)
    }
}