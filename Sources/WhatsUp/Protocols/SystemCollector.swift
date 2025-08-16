import Foundation

protocol SystemCollector: ObservableObject {
    var name: String { get }
    var description: String { get }
    var educationalContext: String { get }
    var isCollecting: Bool { get }
    
    func startCollecting()
    func stopCollecting()
    func getCurrentState() -> CollectorState
    func getHistoricalData(timeRange: DateInterval) -> [SystemEvent]
}

struct CollectorState {
    let timestamp: Date
    let isActive: Bool
    let dataPoints: [String: Any]
    let summary: String
    
    init(isActive: Bool, dataPoints: [String: Any] = [:], summary: String = "") {
        self.timestamp = Date()
        self.isActive = isActive
        self.dataPoints = dataPoints
        self.summary = summary
    }
}