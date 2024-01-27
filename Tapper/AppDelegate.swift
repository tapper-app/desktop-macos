//
//  AppDelegate.swift
//  Tapper
//
//  Created by Yazan Tarifi on 27/01/2024.
//

import Foundation
import SwiftUI

public final class AppDelegate: NSObject, NSApplicationDelegate {
    
    static private(set) var instance: AppDelegate!
    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(30))
    let menu = TapperMenu()
    
    public func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.instance = self
        
        if let image = NSImage(named: NSImage.Name("WhiteLogo")) {
            // Set the desired width and height
            let logoWidth: CGFloat = 24
            let logoHeight: CGFloat = 24
                    
            // Resize the image
            let resizedImage = NSImage(size: NSSize(width: logoWidth, height: logoHeight), flipped: false, drawingHandler: { rect in
                        image.draw(in: NSRect(origin: .zero, size: NSSize(width: logoWidth, height: logoHeight)))
                        return true
            })
                    
            // Assign the resized image to the button
            statusBarItem.button?.image = resizedImage
            statusBarItem.button?.imagePosition = .imageLeading
            statusBarItem.menu = menu.onCreateMenu()
        }
    }
}
