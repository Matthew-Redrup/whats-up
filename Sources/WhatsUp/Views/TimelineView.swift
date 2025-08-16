import SwiftUI

struct TimelineView: View {
    var body: some View {
        ContentUnavailableView(
            "Timeline Coming Soon",
            systemImage: "timeline.selection",
            description: Text("The activity timeline will show you how system events correlate over time. This feature will be implemented in Phase 2 of development.")
        )
        .navigationTitle("Timeline")
    }
}
