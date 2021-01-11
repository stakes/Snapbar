//
//  AppDelegate.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/5/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Cocoa
import SwiftUI

var po: NSPopover!

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var screenshotMonitor: ScreenshotMonitor?
    var screenshotListViewModel: ScreenshotListViewModel?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        screenshotListViewModel = ScreenshotListViewModel()
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(viewModel: screenshotListViewModel!)

        // Create the window and set the content view. 
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
        
        // Monitor for new screenshots
        screenshotMonitor = ScreenshotMonitor(eventHandler: screenshotEventHandler)
        screenshotMonitor?.startMonitoring()
        
        // Make this into a menu bar app
        let popover = NSPopover()
        let vc = NSHostingController(rootView: contentView)
        popover.contentSize = NSSize(width: 120, height: 480)
        popover.behavior = .transient
       
        popover.contentViewController = vc
        self.popover = popover
        po = self.popover
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = self.statusBarItem.button {
             button.image = NSImage(named: "menubar-icon")
             button.action = #selector(togglePopover(_:))
        }
        
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                self.popover.contentViewController?.view.window?.becomeKey()
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func screenshotEventHandler(url: URL) {
        screenshotListViewModel!.addScreenshot(url)
    }

}

