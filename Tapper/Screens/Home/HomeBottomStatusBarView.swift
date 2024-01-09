//
//  HomeBottomStatusBarView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct HomeBottomStatusBarView: View, HomeCommandListener {
    
    @State private var adbListener: TapperCommandTimerManager? = nil
    @State private var tapperListener: TapperCommandTimerManager? = nil
    @State private var npmListener: TapperCommandTimerManager? = nil
    @State private var connectedDevicesListener: TapperCommandTimerManager? = nil
    
    @State private var isAdbInstalled: Bool = false
    @State private var isTapperCliInstalled: Bool = false
    @State private var isAndroidDeviceConnected: Bool = false
    @State private var isNodeInstalled: Bool = false
    @State private var connectedDeviceName: String = ""
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
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
        .onReceive(NotificationCenter.default.publisher(for: .OnSettingsInsertionEvent), perform: { _ in
            self.adbListener?.stopJob()
            self.tapperListener?.stopJob()
            self.npmListener?.stopJob()
            self.connectedDevicesListener?.stopJob()
            
            self.onRegisterStatusListeners()
        })
    }
    
    private func onRegisterStatusListeners() {
        let tapperCliResults = try? TapperUtils.shared.onExecuteCommand(
            "tapper info",
            commandType: .Tapper
        ) 
        
        if let isCliInstalled = tapperCliResults?.contains("Welcome To Android Testing CLI Platform") {
            if tapperListener == nil {
                self.tapperListener = TapperCommandTimerManager(
                    command: .Tapper,
                    listener: self
                )
            }
        } else {
            try? TapperUtils.shared.onExecuteCommand("\(TapperPathsStorageManager.shared.getNodeInstallationPath()) \(TapperPathsStorageManager.shared.getNpmInstallationPath()) i -g tapper-core", commandType: .Tapper)
        }
        
        if self.adbListener == nil {
            self.adbListener = TapperCommandTimerManager(
                command: .ADB,
                listener: self
            )
        }
        
        if self.connectedDevicesListener == nil {
            self.connectedDevicesListener = TapperCommandTimerManager(
                command: .ConnectedDevice,
                listener: self
            )
        }
        
        if self.npmListener == nil {
            self.npmListener = TapperCommandTimerManager(
                command: .Npm,
                listener: self
            )
        }
        
        self.tapperListener?.onStartJobListener()
        self.npmListener?.onStartJobListener()
        self.connectedDevicesListener?.onStartJobListener()
        self.adbListener?.onStartJobListener()
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
