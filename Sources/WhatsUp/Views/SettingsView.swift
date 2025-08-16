import SwiftUI

struct SettingsView: View {
    @State private var refreshInterval: Double = 2.0
    @State private var showAppleProcesses = true
    @State private var showSystemDaemons = true
    @State private var enableNotifications = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.title2)
                .fontWeight(.semibold)
            
            GroupBox("Monitoring") {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Refresh Interval")
                        Spacer()
                        Text("\(Int(refreshInterval)) seconds")
                            .foregroundColor(.secondary)
                    }
                    
                    Slider(value: $refreshInterval, in: 1...10, step: 1)
                    
                    Divider()
                    
                    Toggle("Show Apple Processes", isOn: $showAppleProcesses)
                    Toggle("Show System Daemons", isOn: $showSystemDaemons)
                    Toggle("Enable Process Notifications", isOn: $enableNotifications)
                }
                .padding()
            }
            
            GroupBox("Privacy") {
                VStack(alignment: .leading, spacing: 12) {
                    Text("All monitoring data is stored locally on your Mac only. No data is transmitted to external services.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Button("Clear All Collected Data") {
                        // TODO: Implement data clearing
                    }
                    .foregroundColor(.red)
                }
                .padding()
            }
            
            GroupBox("About") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What's Up - System Activity Explorer")
                        .fontWeight(.semibold)
                    
                    Text("Version 1.0.0 (Phase 1)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("An educational tool to help you understand what your Mac is doing at any moment.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
