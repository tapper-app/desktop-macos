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
        .windowStyle(HiddenTitleBarWindowStyle())
        
        WindowGroup("Tapper - Monkey Testing") {
            MonkeyTestingScreen()
            .frame(width: 500, height: 500)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: [TapperConsts.MONKEY_TESTING_DEEPLINK_KEY])
    }
    
    func onNavigateScreen() {
        self.isSplashScreenEnd = true
    }
    
    
}
