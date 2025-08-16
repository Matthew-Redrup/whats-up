# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**whats-up** is a macOS educational application designed to reveal hidden system activity and make the invisible visible. It helps users understand what their Mac is doing at any moment, how components interact, and what constitutes "normal" system behavior.

## Project Status

- **Current Phase**: Planning complete, implementation not yet started
- **Tech Stack**: Swift + SwiftUI for macOS
- **Architecture**: Real-time system monitoring with educational overlays
- **Storage**: Local SQLite/Core Data for event history
- **Target**: macOS native application

## Development Environment

- **Platform**: macOS (native Swift app)
- **UI Framework**: SwiftUI
- **Data Storage**: SQLite or Core Data
- **Xcode Project**: Not yet created

## Core Architecture

The application follows a collector-based architecture with educational components:

```
Interactive Dashboard (SwiftUI)
         ↓
Activity Timeline & Relationship Graph
         ↓
Core Engine (Event correlation & storage)
         ↓
System Collectors (Process, Network, FileSystem, Resources)
```

### Key Components

1. **System Collectors**: Monitor processes, network activity, file system changes, and resource usage
2. **Event Correlation Engine**: Links related system events across time and components
3. **Educational Layer**: Provides explanations and learning context for all system activity
4. **Interactive Timeline**: Visual representation of system events and their relationships
5. **Learning Modules**: Guided tutorials and experiments

## Common Development Commands

Since the project hasn't been implemented yet, these commands will be relevant once development begins:

```bash
# Project setup (when created)
xcodebuild -workspace WhatsUp.xcworkspace -scheme WhatsUp build
xcodebuild test -workspace WhatsUp.xcworkspace -scheme WhatsUp

# Swift Package Manager (if used)
swift build
swift test
swift run

# Code formatting (if SwiftFormat is added)
swiftformat .

# Linting (if SwiftLint is added)
swiftlint
```

## Implementation Phases

The project is planned in 7 phases over 14 weeks:

1. **Foundation (Week 1-2)**: Basic app structure, process monitoring
2. **Activity Tracking (Week 3-4)**: Event correlation, timeline interface
3. **Resource Monitoring (Week 5-6)**: CPU, memory, disk, energy tracking
4. **Network Insights (Week 7-8)**: Connection mapping, traffic analysis
5. **File System Observatory (Week 9-10)**: FSEvents monitoring, file access tracking
6. **System Intelligence (Week 11-12)**: Cross-domain correlation, pattern recognition
7. **Interactive Learning (Week 13-14)**: Guided tutorials, knowledge base

## Development Principles

### Privacy & Security
- All data stored locally only
- No network transmission of system data
- User controls for data retention and deletion
- Ability to exclude specific apps/folders from monitoring

### Educational Focus
- Every system component must include plain English explanations
- Progressive disclosure from simple to complex views
- Interactive tutorials and guided experiments
- Built-in knowledge base for system concepts

### Performance Considerations
- Sampling strategies for high-frequency events
- Adjustable collection intensity
- Real-time monitoring with minimal system impact
- Self-reporting of resource usage

## Key Framework Usage

When implementing system monitoring, use these macOS frameworks:

- **Process Monitoring**: `NSWorkspace`, `NSRunningApplication`, `ProcessInfo`
- **File System**: `FSEvents` for real-time file change notifications
- **Network**: `Network.framework`, `SystemConfiguration`
- **Resources**: `HostBasicInfo`, `task_info`, `mach_host_self()`
- **Energy**: `IOPMCopyScheduledPowerEvents`, power assertion APIs

## Data Model Design

```swift
protocol SystemCollector {
    var name: String { get }
    var educationalContext: String { get }
    func startCollecting()
    func stopCollecting()
    func getCurrentState() -> CollectorState
}

struct SystemEvent {
    let timestamp: Date
    let source: CollectorSource
    let eventType: EventType
    let parentEventID: UUID?  // For causation tracking
    let educationalNote: String?
}
```

## UI/UX Guidelines

1. **Progressive Disclosure**: Start simple, reveal complexity gradually
2. **Educational First**: No unexplained technical terms, tooltips everywhere
3. **Real-time Responsive**: Live updates with smooth animations
4. **Native macOS Design**: Modern SwiftUI following platform conventions

## Project Goals

The application should enable users to answer questions like:
- "What processes are running and why?"
- "What happens when I open an app?"
- "How efficiently is my Mac using resources?"
- "Where is my Mac communicating on the network?"
- "How do apps interact with my file system?"
- "How do all parts of my system work together?"

## Next Steps

1. Create Xcode project with SwiftUI
2. Implement basic process collector using NSWorkspace
3. Build simple process list view with educational tooltips
4. Add real-time updates and basic visualizations
5. Expand to additional system collectors following the phased plan