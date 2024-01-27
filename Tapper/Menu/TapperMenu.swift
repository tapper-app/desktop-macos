//
//  TapperMenu.swift
//  Tapper
//
//  Created by Yazan Tarifi on 27/01/2024.
//

import Foundation
import SwiftUI

public final class TapperMenu: NSObject {
    
    @Environment(\.openURL) var openUrl
    private let menu = NSMenu()
    
    public func onCreateMenu() -> NSMenu {
        let topView = TapperTopMenuView()
        let topViewToInsert = NSHostingController(rootView: topView)
        topViewToInsert.view.frame.size = CGSize(width: 300, height: 130)
        
        let topBarMenuItem = NSMenuItem()
        topBarMenuItem.view = topViewToInsert.view
        menu.addItem(topBarMenuItem)
        menu.addItem(NSMenuItem.separator())
        
        let developerOptionsMenuItem = NSMenuItem(
            title: "Developer Options",
            action: #selector(onClickOnDeveloperOptionsItem),
            keyEquivalent: ""
        )
        
        let generalOptionsMenuItem = NSMenuItem(
            title: "General Options",
            action: #selector(onClickOnGeneralOptionsItem),
            keyEquivalent: ""
        )
        
        let testingOptionsMenuItem = NSMenuItem(
            title: "Testing Options",
            action: #selector(onClickOnTestingOptionsItem),
            keyEquivalent: ""
        )
        
        let monkeyTestingOptionsMenuItem = NSMenuItem(
            title: "Monkey Testing",
            action: #selector(onClickOnMonkeyTestingOptionsItem),
            keyEquivalent: ""
        )
        
        let aboutApplication = NSMenuItem(
            title: "About Tapper",
            action: #selector(onAboutClickListener),
            keyEquivalent: ""
        )
        
        developerOptionsMenuItem.target = self
        menu.addItem(developerOptionsMenuItem)
        
        generalOptionsMenuItem.target = self
        menu.addItem(generalOptionsMenuItem)
        
        testingOptionsMenuItem.target = self
        menu.addItem(testingOptionsMenuItem)
        
        monkeyTestingOptionsMenuItem.target = self
        menu.addItem(monkeyTestingOptionsMenuItem)
        
        aboutApplication.target = self
        menu.addItem(aboutApplication)
        
        return menu
    }
    
    @objc func onClickOnDeveloperOptionsItem(sender: NSMenuItem) {
        guard let url = URL(string: "tapper://\(TapperConsts.DEVELOPER_DEEPLINK_KEY)") else {
            return
        }
        
        openUrl(url)
    }
    
    @objc func onClickOnGeneralOptionsItem(sender: NSMenuItem) {
        guard let url = URL(string: "tapper://\(TapperConsts.GENERAL_DEEPLINK_KEY)") else {
            return
        }
        
        openUrl(url)
    }
    
    @objc func onClickOnTestingOptionsItem(sender: NSMenuItem) {
        guard let url = URL(string: "tapper://\(TapperConsts.TESTING_DEEPLINK_KEY)") else {
            return
        }
        
        openUrl(url)
    }
    
    @objc func onClickOnMonkeyTestingOptionsItem(sender: NSMenuItem) {
        guard let url = URL(string: "tapper://\(TapperConsts.MONKEY_TESTING_DEEPLINK_KEY)") else {
            return
        }
        
        openUrl(url)
    }
    
    @objc func onAboutClickListener(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel(sender)
    }
}
