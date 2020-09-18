//
//  DropdownMenuView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/7/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

struct DropdownMenuView: NSViewRepresentable {
    
    @ObservedObject var viewModel: ScreenshotListViewModel
    
    func makeNSView(context: Context) -> NSPopUpButton {
        
        let dropdown = NSPopUpButton(frame: CGRect(x: 0, y: 0, width: 48, height: 24), pullsDown: true)
        dropdown.menu!.autoenablesItems = false
        return dropdown
        
    }
    
    func updateNSView(_ nsView: NSPopUpButton, context: Context) {
        
        nsView.removeAllItems()
        
        let iconItem = NSMenuItem()
        let iconImage = NSImage(named: "gear-icon")
        iconItem.image = iconImage
        
        let clearItem = NSMenuItem(title: "Clear", action: #selector(Coordinator.clearAction), keyEquivalent: "")
        clearItem.representedObject = self.viewModel
        clearItem.target = context.coordinator
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(Coordinator.quitAction), keyEquivalent: "q")
        quitItem.target = context.coordinator

        nsView.menu?.insertItem(iconItem, at: 0)
        nsView.menu?.insertItem(clearItem, at: 1)
        nsView.menu?.insertItem(NSMenuItem.separator(), at: 2)
        nsView.menu?.insertItem(quitItem, at: 3)

        let cell = nsView.cell as? NSButtonCell
        cell?.imagePosition = .imageOnly
        cell?.bezelStyle = .texturedRounded

        nsView.wantsLayer = true
        nsView.layer?.backgroundColor = NSColor.clear.cgColor
        nsView.isBordered = false
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        @objc func quitAction(_ sender: NSMenuItem) {
            NSApplication.shared.terminate(self)
        }
        @objc func clearAction(_ sender: NSMenuItem) {
            let vm = sender.representedObject as! ScreenshotListViewModel
            vm.clearScreenshots()
        }
    }
}

//struct DropdownMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropdownMenuView()
//    }
//}

