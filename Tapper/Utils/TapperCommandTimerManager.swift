//
//  TapperCommandTimerManager.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import Foundation
import SwiftUI

public class TapperCommandTimerManager {
    
    private var timer: Timer?
    private let command: TapperHomeCommandType
    private let listener: HomeCommandListener
    
    init(command: TapperHomeCommandType, listener: HomeCommandListener) {
        self.command = command
        self.listener = listener
    }
    
    public func onStartJobListener() {
        self.startJob()
    }
    
    deinit {
        stopJob()
    }
    
    // Create a timer that repeats every 2 seconds
    private func startJob() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            let result = try? TapperUtils.shared.onExecuteCommand(self.getCommandStringByType(), commandType: self.command)
            
            print("Command Result : \(result ?? "")")
            let isActive = self.getSuccessConditionByType(output: result ?? "")
            DispatchQueue.main.async {
                if self.command == .ConnectedDevice {
                    self.listener.onConnectedDeviceName(
                        name: result?.replacingOccurrences(of: "List of devices attached", with: "").trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                    )
                }
                self.listener.onCommandStatus(commandType: self.command, status: isActive)
            }
        }

        timer?.fire()
    }
    
    private func getCommandStringByType() -> String {
        switch command {
        case .ADB:
            return "adb --version"
        case .Npm:
            return "\(TapperPathsStorageManager.shared.getNodeInstallationPath()) -v"
        case .Tapper:
            return "\(TapperPathsStorageManager.shared.getNodeInstallationPath()) \(TapperPathsStorageManager.shared.getNpmInstallationPath()) tapper info"
        case .ConnectedDevice:
            return "adb devices"
        }
    }
    
    private func getSuccessConditionByType(output: String) -> Bool {
        if (output.isEmpty) {
            return false
        }
        
        if output.contains("not found") || output.contains("Not Found") {
            return false
        }
        
        if output.contains("error") || output.contains("Error") {
            return false
        }
        
        if command == .ADB {
            return output.contains("Android Debug Bridge") || output.contains("Installed")
        } else if command == .Npm {
            return TapperUtils.shared.isTextContainsNumbers(text: output)
        } else if command == .Tapper {
            return output.contains("Welcome To Android Testing CLI Platform") || output.contains("CLI Version")
        } else {
            return !output.replacingOccurrences(of: "List of devices attached", with: "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    // Stop the timer when needed (e.g., when the app is about to terminate)
    public func stopJob() {
        timer?.invalidate()
        timer = nil
    }
}

public protocol HomeCommandListener {
    func onCommandStatus(commandType: TapperHomeCommandType, status: Bool)
    func onConnectedDeviceName(name: String)
}
