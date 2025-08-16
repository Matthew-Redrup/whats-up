import Foundation

struct SystemEvent: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    let source: CollectorSource
    let eventType: EventType
    let details: [String: String]
    let parentEventID: UUID?
    let educationalNote: String?
    
    init(
        source: CollectorSource,
        eventType: EventType,
        details: [String: String] = [:],
        parentEventID: UUID? = nil,
        educationalNote: String? = nil
    ) {
        self.id = UUID()
        self.timestamp = Date()
        self.source = source
        self.eventType = eventType
        self.details = details
        self.parentEventID = parentEventID
        self.educationalNote = educationalNote
    }
}

enum CollectorSource: String, CaseIterable, Codable {
    case process = "Process"
    case network = "Network"
    case filesystem = "FileSystem"
    case resources = "Resources"
    case user = "User"
}

enum EventType: String, CaseIterable, Codable {
    case processStart = "Process Started"
    case processEnd = "Process Ended"
    case appLaunch = "App Launched"
    case fileAccess = "File Accessed"
    case networkConnection = "Network Connection"
    case memoryAllocation = "Memory Allocated"
    case cpuUsageSpike = "CPU Usage Spike"
}