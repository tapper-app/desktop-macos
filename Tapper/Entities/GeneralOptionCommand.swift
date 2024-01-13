//
//  GeneralOptionCommand.swift
//  Tapper
//
//  Created by Yazan Tarifi on 13/01/2024.
//

import Foundation

public enum GeneralOptionCommand {
    case DarkMode
    case Power
    case Wifi
    case ConnectedDevices
    case ConnectedDevicesWithDetails
    case Install
    case Remove
    case RestartDevice
    
    public static func getCommandNameByType(type: GeneralOptionCommand) -> String {
        switch (type) {
        case .ConnectedDevices:
            return "Get Connected Devices"
        case .ConnectedDevicesWithDetails:
            return "Get Connected Devices With Details"
        case .DarkMode:
            return "Force DarkMode in Developer Options"
        case .Install:
            return "Install Application By Apk Path"
        case .Power:
            return "Toggle Power Saving Mode"
        case .Remove:
            return "Remove Application By Package Name"
        case .RestartDevice:
            return "Reboot Connected Device"
        case .Wifi:
            return "Toggle Wifi"
        }
    }
    
    public static func getCommandQuestionByType(type: GeneralOptionCommand) -> String {
        switch (type) {
        case .ConnectedDevices:
            return ""
        case .ConnectedDevicesWithDetails:
            return ""
        case .DarkMode:
            return "Do you want To Enable / Disable The Force DarkMode in Developer Options ?"
        case .Install:
            return "Please Pick the Path of the Apk"
        case .Power:
            return "Do you want To Enable / Disable The Power Saving Mode ?"
        case .Remove:
            return "Please Write the Package Name of the Application"
        case .RestartDevice:
            return ""
        case .Wifi:
            return "Do you want To Enable / Disable Wifi ?"
        }
    }
    
    public static func getCommandsQuestionsList() -> [String] {
        var commandsToShow: [String] = []
        getCommandsList().forEach { command in
            commandsToShow.append(GeneralOptionCommand.getCommandNameByType(type: command))
        }
        
        return commandsToShow
    }
    
    public static func getCommandKeyByType(command: GeneralOptionCommand?) -> String {
        if command == nil {
            return ""
        }
        
        switch (command) {
        case .ConnectedDevices:
            return "device"
        case .ConnectedDevicesWithDetails:
            return "device-details"
        case .DarkMode:
            return "dark-mode"
        case .Install:
            return "install"
        case .Power:
            return "power"
        case .Remove:
            return "delete"
        case .RestartDevice:
            return "restart"
        case .Wifi:
            return "wifi"
        case .none:
            return ""
        }
    }
    
    public static func getCommandsList() -> [GeneralOptionCommand] {
        return [
            GeneralOptionCommand.ConnectedDevices,
            GeneralOptionCommand.ConnectedDevicesWithDetails,
            GeneralOptionCommand.RestartDevice,
            GeneralOptionCommand.Wifi,
            GeneralOptionCommand.Power,
            GeneralOptionCommand.Install,
            GeneralOptionCommand.Remove,
            GeneralOptionCommand.DarkMode,
        ]
    }
    
    public static func getQuestionType(type: GeneralOptionCommand) -> Int {
        switch (type) {
        case .ConnectedDevices:
            return TapperConsts.QUESTION_TYPE_NONE
        case .ConnectedDevicesWithDetails:
            return TapperConsts.QUESTION_TYPE_NONE
        case .RestartDevice:
            return TapperConsts.QUESTION_TYPE_NONE
        case .DarkMode:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Power:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Wifi:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Install:
            return TapperConsts.QUESTION_TYPE_PATH_PICKER
        case .Remove:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        }
    }
    
}
