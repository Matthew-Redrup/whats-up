import Foundation
import AppKit

class ProcessCollector: SystemCollector {
    let name = "Process Monitor"
    let description = "Monitors running processes and their resource usage"
    let educationalContext = "Processes are programs running on your Mac. Every app you open, system service, and background task is a process."
    
    @Published var isCollecting = false
    @Published var processes: [ProcessInfo] = []
    
    private var timer: Timer?
    private var eventHistory: [SystemEvent] = []
    private var lastProcessCount = 0
    
    init() {
        // Initial process scan
        refreshProcesses()
    }
    
    func startCollecting() {
        guard !isCollecting else { return }
        
        isCollecting = true
        
        // Set up periodic updates every 2 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.refreshProcesses()
        }
        
        // Listen for app launch/terminate notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidLaunch),
            name: NSWorkspace.didLaunchApplicationNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidTerminate),
            name: NSWorkspace.didTerminateApplicationNotification,
            object: nil
        )
    }
    
    func stopCollecting() {
        isCollecting = false
        timer?.invalidate()
        timer = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func getCurrentState() -> CollectorState {
        return CollectorState(
            isActive: isCollecting,
            dataPoints: [
                "processCount": processes.count,
                "appleProcesses": processes.filter { $0.isAppleProcess }.count,
                "thirdPartyProcesses": processes.filter { !$0.isAppleProcess }.count,
                "totalMemoryUsage": processes.reduce(0) { $0 + $1.memoryUsage },
                "averageCPUUsage": processes.isEmpty ? 0 : processes.reduce(0) { $0 + $1.cpuUsage } / Double(processes.count)
            ],
            summary: "\(processes.count) processes running (\(processes.filter { $0.isAppleProcess }.count) Apple, \(processes.filter { !$0.isAppleProcess }.count) third-party)"
        )
    }
    
    func getHistoricalData(timeRange: DateInterval) -> [SystemEvent] {
        return eventHistory.filter { timeRange.contains($0.timestamp) }
    }
    
    @objc private func appDidLaunch(_ notification: Notification) {
        guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else { return }
        
        let event = SystemEvent(
            source: .process,
            eventType: .appLaunch,
            details: [
                "name": app.localizedName ?? "Unknown",
                "bundleIdentifier": app.bundleIdentifier ?? "",
                "processIdentifier": String(app.processIdentifier)
            ],
            educationalNote: "An application was launched by the user or system."
        )
        
        eventHistory.append(event)
        
        // Refresh processes to include the new one
        DispatchQueue.main.async {
            self.refreshProcesses()
        }
    }
    
    @objc private func appDidTerminate(_ notification: Notification) {
        guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication else { return }
        
        let event = SystemEvent(
            source: .process,
            eventType: .processEnd,
            details: [
                "name": app.localizedName ?? "Unknown",
                "bundleIdentifier": app.bundleIdentifier ?? "",
                "processIdentifier": String(app.processIdentifier)
            ],
            educationalNote: "An application was terminated."
        )
        
        eventHistory.append(event)
        
        // Refresh processes to remove the terminated one
        DispatchQueue.main.async {
            self.refreshProcesses()
        }
    }
    
    private func refreshProcesses() {
        let runningApps = NSWorkspace.shared.runningApplications
        var newProcesses: [ProcessInfo] = []
        
        for app in runningApps {
            let processInfo = ProcessInfo(
                id: app.processIdentifier,
                name: app.localizedName ?? "Unknown Process",
                bundleIdentifier: app.bundleIdentifier,
                bundlePath: app.bundleURL?.path,
                parentProcessID: nil, // NSRunningApplication doesn't provide parent PID
                launchDate: app.launchDate,
                isAppleProcess: isAppleProcess(bundleIdentifier: app.bundleIdentifier, name: app.localizedName),
                processType: determineProcessType(app: app)
            )
            
            newProcesses.append(processInfo)
        }
        
        // Detect new processes for educational events
        let currentProcessCount = newProcesses.count
        if lastProcessCount > 0 && currentProcessCount != lastProcessCount {
            let event = SystemEvent(
                source: .process,
                eventType: currentProcessCount > lastProcessCount ? .processStart : .processEnd,
                details: [
                    "previousCount": String(lastProcessCount),
                    "currentCount": String(currentProcessCount),
                    "delta": String(currentProcessCount - lastProcessCount)
                ],
                educationalNote: currentProcessCount > lastProcessCount ?
                    "New processes have started. This usually happens when you open apps or the system starts background tasks." :
                    "Some processes have ended. This is normal when apps are closed or background tasks complete."
            )
            eventHistory.append(event)
        }
        
        lastProcessCount = currentProcessCount
        
        DispatchQueue.main.async {
            self.processes = newProcesses.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
    }
    
    private func isAppleProcess(bundleIdentifier: String?, name: String?) -> Bool {
        if let bundleId = bundleIdentifier {
            return bundleId.hasPrefix("com.apple.") || bundleId.hasPrefix("com.Apple.")
        }
        
        // Fallback to name-based detection for system processes without bundle IDs
        let systemProcessNames = [
            "kernel_task", "launchd", "WindowServer", "loginwindow",
            "SystemUIServer", "Dock", "Finder", "Activity Monitor"
        ]
        
        return systemProcessNames.contains(name ?? "")
    }
    
    private func determineProcessType(app: NSRunningApplication) -> ProcessType {
        switch app.activationPolicy {
        case .regular:
            return .application
        case .accessory:
            return .service
        case .prohibited:
            return .daemon
        @unknown default:
            return .unknown
        }
    }
    
    deinit {
        stopCollecting()
    }
}