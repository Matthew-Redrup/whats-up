import Foundation

struct ProcessDescriptions {
    private static let descriptions: [String: String] = [
        // System processes
        "kernel_task": "The core of macOS that manages system resources and hardware.",
        "launchd": "The first process that starts when your Mac boots and manages all other processes.",
        "WindowServer": "Manages your desktop, windows, and graphical interface.",
        "Finder": "The app that manages your desktop, file browsing, and file operations.",
        "Dock": "The dock at the bottom of your screen showing running apps and shortcuts.",
        "SystemUIServer": "Manages menu bar items and system UI elements.",
        "loginwindow": "Handles user login and logout processes.",
        "Activity Monitor": "Apple's built-in tool for monitoring system activity and processes.",
        
        // Common third-party apps
        "Safari": "Apple's web browser for browsing the internet.",
        "Chrome": "Google's web browser.",
        "Firefox": "Mozilla's web browser.",
        "Slack": "Team communication and collaboration app.",
        "Spotify": "Music streaming application.",
        "Zoom": "Video conferencing application.",
        
        // Bundle identifiers
        "com.apple.Safari": "Apple's web browser for browsing the internet.",
        "com.google.Chrome": "Google's web browser.",
        "com.apple.finder": "The app that manages your desktop and file browsing.",
        "com.apple.dock.extra": "The dock showing your apps and shortcuts.",
    ]
    
    private static let whyRunningReasons: [String: String] = [
        "kernel_task": "Always runs as the core of macOS - without it, your Mac wouldn't function.",
        "launchd": "The master process that starts all other processes when your Mac boots up.",
        "WindowServer": "Needed to display anything on your screen - manages all windows and graphics.",
        "Finder": "Runs to manage your desktop and provide file management capabilities.",
        "Dock": "Provides the dock interface you see at the bottom of your screen.",
        "SystemUIServer": "Manages menu bar items like WiFi, battery, and volume controls.",
        "Safari": "You opened Safari to browse the web, or it's running in the background.",
        "Chrome": "You're using Chrome to browse the web or it has background processes running.",
        "Slack": "Either actively using Slack or it's running in background for notifications.",
        "Spotify": "Playing music or running in background to enable quick music access.",
    ]
    
    static func description(for identifier: String) -> String? {
        return descriptions[identifier]
    }
    
    static func whyRunning(for identifier: String) -> String? {
        return whyRunningReasons[identifier]
    }
}