//
//  HomeBottomStatusBarView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct HomeBottomStatusBarView: View, HomeCommandListener {
    
    @State private var isAdbInstalled: Bool = false
    @State private var isTapperCliInstalled: Bool = false
    @State private var isAndroidDeviceConnected: Bool = false
    @State private var isNodeInstalled: Bool = false
    @State private var connectedDeviceName: String = ""
    
    var body: some View {
        HStack {
            HStack {
                HomeStatusBarView(
                    name: isAdbInstalled ? "ADB Installed" : "ADB Not Installed",
                    isActive: isAdbInstalled
                )
                
                HomeStatusBarView(
                    name: isTapperCliInstalled ? "Tapper Cli Installed" : "Tapper Cli Not Installed",
                    isActive: isTapperCliInstalled
                )
                
                HomeStatusBarView(
                    name: isAndroidDeviceConnected ? "Android Device Connected - \(connectedDeviceName)" : "Device Not Connected",
                    isActive: isAndroidDeviceConnected
                )
                
                HomeStatusBarView(
                    name: isNodeInstalled ? "Npm, Node Installed" : "Node Not Installed",
                    isActive: isNodeInstalled
                )
            }
            
            Spacer()
            
            HomeStatusBarView(name: "V1.0.0 - Update Available", isActive: true)
        }
        .background(TapperUtils.shared.getApplicationPrimaryColor())
        .onAppear {
            self.onRegisterStatusListeners()
        }
    }
    
    private func onRegisterStatusListeners() {

        TapperCommandTimerManager(
            command: .ADB,
            listener: self
        ).onStartJobListener()
        
        TapperCommandTimerManager(
            command: .ConnectedDevice,
            listener: self
        ).onStartJobListener()
        
        TapperCommandTimerManager(
            command: .Npm, 
            listener: self
        ).onStartJobListener()
        
        TapperCommandTimerManager(
            command: .Tapper, 
            listener: self
        ).onStartJobListener()
    }
    
    func onCommandStatus(commandType: TapperHomeCommandType, status: Bool) {
        switch commandType {
        case .ADB:
            isAdbInstalled = status
        case .ConnectedDevice:
            isAndroidDeviceConnected = status
        case .Npm:
            isNodeInstalled = status
        case .Tapper:
            isTapperCliInstalled = status
        }
    }
    
    func onConnectedDeviceName(name: String) {
        self.connectedDeviceName = name
    }
}

#Preview {
    HomeBottomStatusBarView()
}
