import SwiftUI

struct DashboardView: View {
    @StateObject private var processCollector = ProcessCollector()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                
                // Process count card
                MetricCard(
                    title: "Running Processes",
                    value: "\(processCollector.processes.count)",
                    subtitle: "Active on your Mac",
                    icon: "cpu",
                    color: .blue
                ) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                            Text("Apple: \(processCollector.processes.filter { $0.isAppleProcess }.count)")
                                .font(.caption)
                        }
                        HStack {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 8, height: 8)
                            Text("Third-party: \(processCollector.processes.filter { !$0.isAppleProcess }.count)")
                                .font(.caption)
                        }
                    }
                }
                
                // Memory usage card
                MetricCard(
                    title: "Memory Usage",
                    value: formatMemoryUsage(),
                    subtitle: "Total by all processes",
                    icon: "memorychip",
                    color: .green
                ) {
                    Text("System manages memory automatically")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // System insights card
                MetricCard(
                    title: "System Activity",
                    value: getActivityLevel(),
                    subtitle: "Current activity level",
                    icon: "waveform.path.ecg",
                    color: .purple
                ) {
                    Text("Based on process count and types")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Learning card
                MetricCard(
                    title: "Did You Know?",
                    value: "🧠",
                    subtitle: getRandomFact(),
                    icon: "lightbulb",
                    color: .yellow
                ) {
                    Text("Tap to learn more about your system")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            
            // System overview section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "chart.pie")
                        .foregroundColor(.accentColor)
                    Text("System Overview")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    OverviewRow(
                        label: "Most Active Apps",
                        value: getMostActiveApps()
                    )
                    
                    OverviewRow(
                        label: "System Health",
                        value: "Good - All processes running normally"
                    )
                    
                    OverviewRow(
                        label: "Background Activity",
                        value: "\(processCollector.processes.filter { $0.processType == .daemon }.count) system daemons active"
                    )
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                .cornerRadius(12)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Dashboard")
        .onAppear {
            processCollector.startCollecting()
        }
        .onDisappear {
            processCollector.stopCollecting()
        }
    }
    
    private func formatMemoryUsage() -> String {
        let totalMemory = processCollector.processes.reduce(0) { $0 + $1.memoryUsage }
        let formatter = ByteCountFormatter()
        formatter.countStyle = .memory
        return formatter.string(fromByteCount: Int64(totalMemory))
    }
    
    private func getActivityLevel() -> String {
        let processCount = processCollector.processes.count
        switch processCount {
        case 0..<50: return "Low"
        case 50..<100: return "Normal"
        case 100..<150: return "High"
        default: return "Very High"
        }
    }
    
    private func getMostActiveApps() -> String {
        let apps = processCollector.processes
            .filter { $0.processType == .application && !$0.isAppleProcess }
            .prefix(3)
            .map { $0.name }
        
        return apps.isEmpty ? "No third-party apps running" : apps.joined(separator: ", ")
    }
    
    private func getRandomFact() -> String {
        let facts = [
            "Every app you open creates at least one process",
            "System processes help your Mac run smoothly",
            "The kernel_task manages system resources",
            "Processes can spawn other processes",
            "Background apps use minimal resources when not active"
        ]
        return facts.randomElement() ?? facts[0]
    }
}

struct MetricCard<Content: View>: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let color: Color
    let content: Content
    
    init(
        title: String,
        value: String,
        subtitle: String,
        icon: String,
        color: Color,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                
                Spacer()
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            content
        }
        .padding()
        .frame(height: 140)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(12)
    }
}

struct OverviewRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
