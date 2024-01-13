//
//  TapperApp.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

@main
struct TapperApp: App, SplashScreenNavigationListener {
    
    @State private var isSplashScreenEnd: Bool = false
    @State private var applicationPackageNameDeeplink: String = ""
    
    var body: some Scene {
        WindowGroup("Tapper") {
            Group {
                if isSplashScreenEnd {
                    HomeScreen()
                } else {
                    SplashScreen(listener: self)
                }
            }
            .frame(width: 1280, height: 720)
            .fixedSize()
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        
        WindowGroup("Tapper - Monkey Testing") {
            MonkeyTestingScreen(applicationPackageNameExecution: $applicationPackageNameDeeplink)
                .frame(minWidth: 450, minHeight: 600)
                .onOpenURL{ url in
                    applicationPackageNameDeeplink = url.absoluteString.replacingOccurrences(of: "tapper://\(TapperConsts.MONKEY_TESTING_DEEPLINK_KEY)/", with: "")
                }
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: [TapperConsts.MONKEY_TESTING_DEEPLINK_KEY])
        
        WindowGroup("Tapper - General Testing") {
            GeneralTestingCommandsScreen(applicationPackageNameExecution: $applicationPackageNameDeeplink)
                .frame(minWidth: 450, minHeight: 600)
                .onOpenURL{ url in
                    applicationPackageNameDeeplink = url.absoluteString.replacingOccurrences(of: "tapper://\(TapperConsts.GENERAL_DEEPLINK_KEY)/", with: "")
                }
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: [TapperConsts.GENERAL_DEEPLINK_KEY])
    }
    
    func onNavigateScreen() {
        self.isSplashScreenEnd = true
    }
    
    
}
