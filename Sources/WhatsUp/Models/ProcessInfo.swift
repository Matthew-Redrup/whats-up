import Foundation

struct ProcessInfo: Identifiable, Hashable {
    let id: Int32 // Process ID
    let name: String
    let bundleIdentifier: String?
    let bundlePath: String?
    let parentProcessID: Int32?
    let launchDate: Date?
    let isAppleProcess: Bool
    let processType: ProcessType
    
    // Resource usage
    var cpuUsage: Double = 0.0
    var memoryUsage: UInt64 = 0 // in bytes
    var threadCount: Int = 0
    
    // Educational content
    var description: String {
        if let bundleIdentifier = bundleIdentifier {
            return ProcessDescriptions.description(for: bundleIdentifier) ?? 
                   ProcessDescriptions.description(for: name) ?? 
                   defaultDescription
        }
        return ProcessDescriptions.description(for: name) ?? defaultDescription
    }
    
    private var defaultDescription: String {
        if isAppleProcess {
            return "A system process that helps your Mac function properly."
        } else {
            return "A third-party application or process."
        }
    }
    
    var whyRunning: String {
        if let bundleIdentifier = bundleIdentifier {
            return ProcessDescriptions.whyRunning(for: bundleIdentifier) ?? 
                   ProcessDescriptions.whyRunning(for: name) ?? 
                   defaultWhyRunning
        }
        return ProcessDescriptions.whyRunning(for: name) ?? defaultWhyRunning
    }
    
    private var defaultWhyRunning: String {
        if isAppleProcess {
            return "This process runs automatically as part of macOS to provide essential system functionality."
        } else {
            return "This process was likely started by user action or runs in the background for app functionality."
        }
    }
    
    var formattedMemoryUsage: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .memory
        return formatter.string(fromByteCount: Int64(memoryUsage))
    }
    
    var formattedCPUUsage: String {
        return String(format: "%.1f%%", cpuUsage)
    }
}

enum ProcessType: String, CaseIterable {
    case application = "Application"
    case daemon = "Daemon"
    case agent = "Agent"
    case helper = "Helper"
    case service = "Service"
    case unknown = "Unknown"
}