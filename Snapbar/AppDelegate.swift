//
//  AppDelegate.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/5/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var screenshotMonitor: ScreenshotMonitor?
    var screenshotListViewModel: ScreenshotListViewModel?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        screenshotListViewModel = ScreenshotListViewModel()
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(viewModel: screenshotListViewModel!)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        // Monitor for new screenshots
        screenshotMonitor = ScreenshotMonitor(eventHandler: screenshotEventHandler)
        screenshotMonitor?.startMonitoring()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func screenshotEventHandler(url: URL) {
        print("screenshotEventHandler()")
        print(url)
        
        screenshotListViewModel!.addScreenshot(url)
    }

}

