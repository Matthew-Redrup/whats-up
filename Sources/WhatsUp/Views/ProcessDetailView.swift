import SwiftUI

struct ProcessDetailView: View {
    let process: ProcessInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Circle()
                            .fill(process.isAppleProcess ? Color.blue : Color.orange)
                            .frame(width: 12, height: 12)
                        
                        Text(process.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("PID \(process.id)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    if let bundleId = process.bundleIdentifier {
                        Text(bundleId)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                // What is this section
                InfoSection(
                    title: "What is this?",
                    icon: "questionmark.circle",
                    content: process.description
                )
                
                // Why is it running section
                InfoSection(
                    title: "Why is it running?",
                    icon: "play.circle",
                    content: process.whyRunning
                )
                
                // Process details
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Process Details", icon: "info.circle")
                    
                    VStack(spacing: 8) {
                        DetailRow(label: "Process Type", value: process.processType.rawValue)
                        DetailRow(label: "Source", value: process.isAppleProcess ? "Apple (System)" : "Third-party")
                        
                        if let launchDate = process.launchDate {
                            DetailRow(label: "Started", value: formatDate(launchDate))
                        }
                        
                        if let bundlePath = process.bundlePath {
                            DetailRow(label: "Bundle Path", value: bundlePath)
                        }
                        
                        if process.parentProcessID != nil {
                            DetailRow(label: "Parent PID", value: String(process.parentProcessID!))
                        }
                    }
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                .cornerRadius(8)
                
                // Resource usage (placeholder for now)
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Resource Usage", icon: "speedometer")
                    
                    VStack(spacing: 8) {
                        DetailRow(label: "CPU Usage", value: process.formattedCPUUsage)
                        DetailRow(label: "Memory Usage", value: process.formattedMemoryUsage)
                        DetailRow(label: "Threads", value: String(process.threadCount))
                    }
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct InfoSection: View {
    let title: String
    let icon: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: title, icon: icon)
            
            Text(content)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.accentColor.opacity(0.1))
        .cornerRadius(8)
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}

struct DetailRow: View {
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
        .font(.system(.body, design: .monospaced))
    }
}
