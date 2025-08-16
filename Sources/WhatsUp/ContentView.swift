import SwiftUI

struct ContentView: View {
    @State private var selectedTab: SidebarItem = .processes
    @State private var selectedProcess: ProcessInfo?
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectedTab: $selectedTab)
                .navigationSplitViewColumnWidth(min: 200, ideal: 250)
        } detail: {
            switch selectedTab {
            case .processes:
                ProcessListView(selectedProcess: $selectedProcess)
            case .dashboard:
                DashboardView()
            case .timeline:
                TimelineView()
            case .settings:
                SettingsView()
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}
