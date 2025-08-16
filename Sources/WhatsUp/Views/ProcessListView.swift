import SwiftUI

struct ProcessListView: View {
    @StateObject private var processCollector = ProcessCollector()
    @Binding var selectedProcess: ProcessInfo?
    @State private var searchText = ""
    @State private var showAppleProcesses = true
    @State private var showThirdPartyProcesses = true
    
    var filteredProcesses: [ProcessInfo] {
        processCollector.processes.filter { process in
            let matchesSearch = searchText.isEmpty || 
                               process.name.localizedCaseInsensitiveContains(searchText) ||
                               (process.bundleIdentifier?.localizedCaseInsensitiveContains(searchText) ?? false)
            
            let matchesFilter = (process.isAppleProcess && showAppleProcesses) ||
                               (!process.isAppleProcess && showThirdPartyProcesses)
            
            return matchesSearch && matchesFilter
        }
    }
    
    var body: some View {
        HSplitView {
            // Left side - Process list
            VStack(spacing: 0) {
                // Header with controls
                VStack(spacing: 12) {
                    HStack {
                        Text("Processes")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("\(filteredProcesses.count) of \(processCollector.processes.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search processes...", text: $searchText)
                            .textFieldStyle(.plain)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(6)
                    
                    // Filter toggles
                    HStack {
                        Toggle("Apple", isOn: $showAppleProcesses)
                            .toggleStyle(.checkbox)
                        Toggle("Third-party", isOn: $showThirdPartyProcesses)
                            .toggleStyle(.checkbox)
                        Spacer()
                    }
                    .font(.caption)
                }
                .padding()
                
                Divider()
                
                // Process list
                List(filteredProcesses, id: \.id, selection: $selectedProcess) { process in
                    ProcessRow(process: process)
                }
                .listStyle(.plain)
            }
            .frame(minWidth: 300)
            
            // Right side - Process details
            VStack {
                if let selectedProcess = selectedProcess {
                    ProcessDetailView(process: selectedProcess)
                } else {
                    ContentUnavailableView(
                        "No Process Selected",
                        systemImage: "cpu",
                        description: Text("Select a process from the list to view detailed information and learn what it does.")
                    )
                }
            }
            .frame(minWidth: 400)
        }
        .onAppear {
            processCollector.startCollecting()
        }
        .onDisappear {
            processCollector.stopCollecting()
        }
    }
}

struct ProcessRow: View {
    let process: ProcessInfo
    
    var body: some View {
        HStack {
            // Process type indicator
            Circle()
                .fill(process.isAppleProcess ? Color.blue : Color.orange)
                .frame(width: 8, height: 8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(process.name)
                    .font(.system(.body, design: .default, weight: .medium))
                    .lineLimit(1)
                
                if let bundleId = process.bundleIdentifier {
                    Text(bundleId)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("PID \(process.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(process.processType.rawValue)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
}
