# macOS System Activity Explorer - Project Plan

## Project Vision

Build an educational macOS application that reveals the hidden activity on your computer, making the invisible visible. This tool will help you understand what your Mac is doing at any moment, how different components interact, and what constitutes "normal" behavior for your system.

## Core Learning Objectives

1. **Demystify the Black Box**: Understand what's actually happening when you click an app, browse a website, or save a file
2. **Establish Baselines**: Learn what's "normal" for your specific Mac and usage patterns
3. **Trace Cause & Effect**: See the ripple effects of actions across the system
4. **Understand Relationships**: Visualize how processes, files, network, and hardware interact
5. **Build Mental Models**: Develop intuition about system behavior

## Architecture Overview

```
┌──────────────────────────────────────────┐
│         Interactive Dashboard            │
│    (SwiftUI - Main Learning Interface)   │
├──────────────────────────────────────────┤
│         Activity Timeline                │
│    (Correlate events across time)        │
├──────────────────────────────────────────┤
│         Relationship Graph               │
│    (Visual system connections)           │
├──────────────────────────────────────────┤
│         Learning Mode                    │
│    (Guided exploration & tutorials)      │
└────────────────┬─────────────────────────┘
                 │
┌────────────────▼─────────────────────────┐
│         Core Engine                      │
│    (Event correlation & storage)         │
└────────────────┬─────────────────────────┘
                 │
      ┌──────────┴──────────┐
      │     Collectors       │
      └─────────────────────┘
```

## Phase 1: Foundation (Week 1-2)
**Theme: "What's Running Right Now?"**

### Goals
- Build basic application structure
- Create first visual representation of system state
- Establish data collection patterns

### Components

#### 1.1 Project Setup
- Swift macOS app with SwiftUI interface
- Core data model for system events
- Basic navigation structure
- Persistent storage (SQLite/Core Data)

#### 1.2 Process Explorer
- **What to Build**:
  - Live process list with hierarchy (tree view)
  - Process details panel (memory, CPU, threads)
  - Process lifecycle tracking (birth/death)
  
- **Learning Features**:
  - "What is this?" tooltips for every process
  - Process family trees showing parent-child relationships
  - Highlight which processes are Apple vs third-party
  - "Why is this running?" explanations for common processes

#### 1.3 Initial Visualization
- Simple dashboard showing:
  - Total processes count
  - Memory pressure gauge
  - CPU activity sparkline
  - Disk I/O indicator

### Milestone
User can answer: "What processes are running and why?"

## Phase 2: Activity Tracking (Week 3-4)
**Theme: "What Happens When I Do Something?"**

### Goals
- Capture system events in real-time
- Correlate user actions with system responses
- Build activity timeline

### Components

#### 2.1 Event Collection System
- **User Actions**:
  - App launches (NSWorkspace notifications)
  - Window focus changes
  - File operations (open, save, delete)
  - Network requests initiated

- **System Responses**:
  - New processes spawned
  - Memory allocations
  - Disk reads/writes
  - Network connections opened

#### 2.2 Activity Timeline
- **Visual Timeline**:
  - Horizontal timeline with multiple tracks
  - User actions on top track
  - System responses below
  - Connecting lines showing causation

- **Interactive Features**:
  - Click any event for details
  - Filter by app or activity type
  - Zoom in/out for different time scales
  - "Replay" mode to watch events unfold

#### 2.3 "Action Lab"
- Guided experiments:
  - "Open Safari and watch what happens"
  - "Save a large file and observe disk activity"
  - "Connect to Wi-Fi and see network changes"
- Each experiment explains expected behavior

### Milestone
User can answer: "What chain of events occurs when I open an app?"

## Phase 3: Resource Monitoring (Week 5-6)
**Theme: "How Are Resources Being Used?"**

### Goals
- Understand resource consumption patterns
- Identify resource bottlenecks
- Learn about system resource management

### Components

#### 3.1 Resource Collectors
- **CPU Monitoring**:
  - Per-core utilization
  - Process CPU history
  - Thermal state
  - Efficiency vs performance cores (Apple Silicon)

- **Memory Tracking**:
  - Physical vs virtual memory
  - Memory pressure
  - Swap usage
  - Per-app memory footprint
  - Memory compression

- **Disk Activity**:
  - Read/write operations per process
  - File system cache hits/misses
  - Storage device health
  - Space usage trends

- **Energy Impact**:
  - Battery drain by app
  - Wake reasons
  - Power assertions

#### 3.2 Resource Visualizations
- **Live Graphs**:
  - Stacked area chart for CPU by process
  - Memory map visualization
  - Disk I/O heatmap
  - Energy usage timeline

- **Learning Overlays**:
  - "Normal range" indicators
  - Annotations for significant events
  - Comparisons to typical usage

#### 3.3 Resource Detective
- Answer questions like:
  - "Why is my fan running?"
  - "What's using all my memory?"
  - "Why is my Mac slow right now?"
- Provide actionable explanations

### Milestone
User can answer: "How efficiently is my Mac using its resources?"

## Phase 4: Network Insights (Week 7-8)
**Theme: "Where Is My Mac Talking To?"**

### Goals
- Visualize network activity
- Understand modern app communication patterns
- Learn about background network activity

### Components

#### 4.1 Network Monitoring
- **Connection Tracking**:
  - Active connections per process
  - Data sent/received
  - Connection endpoints (with geo-location)
  - Protocol breakdown (HTTP/HTTPS/DNS/etc)

- **Traffic Patterns**:
  - Bandwidth usage over time
  - Frequent destinations
  - Local network vs internet
  - Broadcast/multicast traffic

#### 4.2 Network Visualization
- **Connection Map**:
  - Your Mac in the center
  - Lines to all active connections
  - Thickness = bandwidth
  - Color = traffic type

- **Activity Feed**:
  - Scrolling list of connections
  - Domain name resolution
  - Data transfer amounts
  - Connection duration

#### 4.3 Network Teacher
- Explain common traffic:
  - "Why does my Mac talk to Apple servers?"
  - "What is mDNS and why so much traffic?"
  - "Background app refresh explained"
- Privacy indicators (encrypted vs unencrypted)

### Milestone
User can answer: "What network activity is normal for my Mac?"

## Phase 5: File System Observatory (Week 9-10)
**Theme: "What's Happening to My Files?"**

### Goals
- Track file system changes
- Understand app file access patterns
- Learn about macOS file system features

### Components

#### 5.1 File System Monitoring
- **FSEvents Integration**:
  - Real-time file change notifications
  - Track creates, modifies, deletes, renames
  - Monitor specific folders (Desktop, Documents, Downloads)

- **File Access Tracking**:
  - Which apps access which files
  - Frequency of access
  - Read vs write operations

#### 5.2 File System Visualizations
- **Activity Heatmap**:
  - Folder tree with activity intensity
  - Time-based replay
  - Size change indicators

- **Access Timeline**:
  - When files were accessed
  - By which processes
  - Type of operation

#### 5.3 Storage Insights
- **Space Analysis**:
  - What's taking up space
  - Growth trends
  - Temporary file accumulation
  - Cache locations

- **Learning Features**:
  - "Where do apps store data?"
  - "What are all these Library folders?"
  - "Understanding macOS file permissions"

### Milestone
User can answer: "How do apps interact with my file system?"

## Phase 6: System Intelligence (Week 11-12)
**Theme: "Understanding the Whole System"**

### Goals
- Correlate data across all collectors
- Identify patterns and anomalies
- Build comprehensive system understanding

### Components

#### 6.1 Correlation Engine
- **Cross-Domain Events**:
  - Link file access → network activity
  - Process creation → resource usage
  - User action → system response chains

- **Pattern Recognition**:
  - Identify recurring behaviors
  - Baseline "normal" for your system
  - Detect unusual activity

#### 6.2 System Story Builder
- **Narrative View**:
  - "The story of opening Photoshop"
  - "What happens during Time Machine backup"
  - "Your Mac's morning routine"

- **Interactive Exploration**:
  - Start with high-level view
  - Drill down into details
  - See relationships between components

#### 6.3 Learning Dashboard
- **System Health Score**:
  - Based on resource usage
  - Performance indicators
  - Comparison to baseline

- **Daily Insights**:
  - "Today you used 50% more CPU than usual"
  - "New process discovered: X"
  - "Unusual network destination detected"

### Milestone
User can answer: "How do all parts of my system work together?"

## Phase 7: Interactive Learning Mode (Week 13-14)
**Theme: "Guided System Exploration"**

### Goals
- Create interactive tutorials
- Build learning exercises
- Develop system intuition

### Components

#### 7.1 Guided Tours
- **Interactive Tutorials**:
  - "Follow a web request from click to response"
  - "The journey of a saved file"
  - "How apps communicate with each other"

- **Scenario Exploration**:
  - "What happens when you wake your Mac"
  - "The shutdown sequence explained"
  - "How updates work behind the scenes"

#### 7.2 Experiment Mode
- **Controlled Tests**:
  - "Compare: Opening app first time vs cached"
  - "Test: Impact of many browser tabs"
  - "Measure: File copy local vs network"

- **Predictions**:
  - User predicts what will happen
  - System shows actual result
  - Explanation of differences

#### 7.3 Knowledge Base
- **Built-in Wiki**:
  - Process encyclopedia
  - System component guide
  - Common patterns library
  - Troubleshooting guide

### Milestone
User has deep intuition about system behavior

## Technical Implementation Details

### Data Collection Strategy
```swift
protocol SystemCollector {
    var name: String { get }
    var description: String { get }
    var educationalContext: String { get }
    
    func startCollecting()
    func stopCollecting()
    func getCurrentState() -> CollectorState
    func getHistoricalData(timeRange: DateInterval) -> [DataPoint]
}
```

### Event Correlation System
```swift
struct SystemEvent {
    let timestamp: Date
    let source: CollectorSource
    let eventType: EventType
    let details: [String: Any]
    let parentEventID: UUID?  // For tracking causation
    let educationalNote: String?
}
```

### Learning Annotation Framework
Every piece of data should include:
- Plain English explanation
- Why it matters
- What's normal vs unusual
- Related system concepts
- Links to learn more

### Privacy & Performance Considerations

#### Privacy First
- All data stored locally only
- Option to exclude specific apps/folders
- Clear data retention settings
- Export/delete all data easily

#### Performance Impact
- Sampling strategies for high-frequency events
- Adjustable collection intensity
- Pause/resume monitoring
- Resource usage self-reporting

### Key UI/UX Principles

1. **Progressive Disclosure**
   - Start simple, reveal complexity gradually
   - Multiple zoom levels for every view
   - Optional technical details

2. **Always Educational**
   - No unexplained technical terms
   - Tooltips everywhere
   - "Learn more" links throughout

3. **Interactive & Responsive**
   - Real-time updates
   - Smooth animations showing change
   - Direct manipulation where possible

4. **Beautiful & Engaging**
   - Modern, native macOS design
   - Thoughtful use of color and animation
   - Data visualization best practices

## Success Metrics

### Learning Outcomes
- User can explain what their Mac is doing at any moment
- User understands resource usage patterns
- User can identify unusual behavior
- User has mental model of system architecture

### Engagement Metrics
- Daily active usage
- Features explored
- Learning modules completed
- "Aha!" moments (tracked via interactions)

## Future Enhancements

### Version 2.0 Ideas
- iOS companion app (if applicable)
- Historical comparisons ("your Mac today vs last month")
- System optimization recommendations
- Community pattern sharing (anonymized)
- Integration with system logs
- Automated report generation

### Advanced Features
- Machine learning for anomaly detection
- Predictive resource usage
- Cross-device insights (multiple Macs)
- Developer mode with deeper hooks
- API for third-party extensions

## Getting Started Checklist

### Week 1 Setup
- [ ] Create Xcode project with SwiftUI
- [ ] Set up git repository
- [ ] Design basic data model
- [ ] Create navigation structure
- [ ] Implement first process collector
- [ ] Build simple process list view
- [ ] Add first educational tooltip
- [ ] Test on your Mac
- [ ] Document first learnings

### Development Principles
1. **Start Simple**: Get basic version working first
2. **Iterate Quickly**: Daily builds with new insights
3. **Document Everything**: Your learning is the product
4. **User Test Yourself**: You're the primary user
5. **Prioritize Learning**: Every feature should teach something
6. **Make It Beautiful**: Engagement drives learning
7. **Respect Privacy**: Your data stays yours
8. **Have Fun**: This is about discovery!

## Resources & References

### Apple Documentation
- Process Info API
- FSEvents Framework
- Network Extension Framework
- OSLog and Unified Logging
- System Configuration Framework

### Learning Resources
- WWDC Sessions on system frameworks
- macOS Internals books
- Open source system monitors for inspiration
- Apple's Activity Monitor source concepts

### Community & Support
- Create blog documenting journey
- Share interesting discoveries
- Get feedback from other developers
- Consider open-sourcing eventually

---

*This plan is a living document. Update it as you learn and discover new aspects of your system that you want to explore!*