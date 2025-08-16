import Foundation

enum SidebarItem: String, CaseIterable, Identifiable {
    case processes = "Processes"
    case dashboard = "Dashboard"  
    case timeline = "Timeline"
    case settings = "Settings"
    
    var id: String { rawValue }
    
    var systemImage: String {
        switch self {
        case .processes:
            return "cpu"
        case .dashboard:
            return "chart.pie"
        case .timeline:
            return "timeline.selection"
        case .settings:
            return "gear"
        }
    }
    
    var description: String {
        switch self {
        case .processes:
            return "View running processes and their details"
        case .dashboard:
            return "System overview and resource usage"
        case .timeline:
            return "Activity timeline and event correlation"
        case .settings:
            return "App preferences and monitoring settings"
        }
    }
}