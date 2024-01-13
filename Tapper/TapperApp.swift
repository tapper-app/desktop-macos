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
            PickerOptionsScreen(
                screenTitle: "Tapper General Commands",
                screenDescription: "Tapper Has a General Commands on The Connected Android Device Via ADB, Please Select the Action and the Input to Continue",
                pickerType: .GeneralOptions
            )
            .frame(minWidth: 450, minHeight: 500)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: [TapperConsts.GENERAL_DEEPLINK_KEY])
        
        WindowGroup("Tapper - Testing") {
            PickerOptionsScreen(
                screenTitle: "Tapper Testing Commands",
                screenDescription: "Tapper Has a Testing Commands and Usually this Commands Has the Basic and most Common Methods to Speed up The Development Process",
                pickerType: .TestFunctions
            )
            .frame(minWidth: 450, minHeight: 500)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: [TapperConsts.TESTING_DEEPLINK_KEY])
        
        WindowGroup("Tapper - Developer Options") {
            PickerOptionsScreen(
                screenTitle: "Tapper Developer Commands",
                screenDescription: "Tapper Has a Developer Commands to help Android Development Process to Execute Developer Common Developer Options on Your Device Without Searching on them in Device Settings",
                pickerType: .DeveloperOptions
            )
            .frame(minWidth: 450, minHeight: 500)
        }
        .windowResizability(.contentSize)
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: [TapperConsts.DEVELOPER_DEEPLINK_KEY])
    }
    
    func onNavigateScreen() {
        self.isSplashScreenEnd = true
    }
    
    
}
