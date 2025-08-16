import SwiftUI

struct SidebarView: View {
    @Binding var selectedTab: SidebarItem
    
    var body: some View {
        List(SidebarItem.allCases, selection: $selectedTab) { item in
            Label {
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.rawValue)
                        .font(.headline)
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            } icon: {
                Image(systemName: item.systemImage)
                    .foregroundColor(.accentColor)
            }
            .tag(item)
        }
        .navigationTitle("What's Up")
        .listStyle(.sidebar)
    }
}
