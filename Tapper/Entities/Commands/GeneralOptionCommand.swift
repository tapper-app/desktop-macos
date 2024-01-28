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
    case HomeButton
    case PhoneNumber
    case OpenUrl
    case Screenshot
    case OpenApp
    case Delay
    
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
        case .HomeButton:
            return "Click on Home Button"
        case .PhoneNumber:
            return "Call Phone Number"
        case .OpenUrl:
            return "Open Website by Web Browser"
        case .Screenshot:
            return "Take a Screenshot"
        case .Delay:
            return "Delay in Seconds"
        case .OpenApp:
            return "Open Application By Package Name"
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
        case .HomeButton:
            return ""
        case .PhoneNumber:
            return "Write the phone Number Example (+123456789)"
        case .OpenUrl:
            return "Write the Url Example (https://example.com)"
        case .Screenshot:
            return "Write the Save Location Path Example (/sdcard/screenshot.png)"
        case .OpenApp:
            return "Write The App Package Name"
        case .Delay:
            return "Write The Number in Seconds To Delay Commands"
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
        case .HomeButton:
            return "home-tap"
        case .PhoneNumber:
            return "call-phone"
        case .OpenUrl:
            return "open-url"
        case .Screenshot:
            return "screenshot"
        case .OpenApp:
            return "open-app"
        case .Delay:
            return "delay"
        }
    }
    
    public static func getCommandsList() -> [GeneralOptionCommand] {
        return [
//            GeneralOptionCommand.ConnectedDevices, //TODO: Remove the Comment When Support Output Type
//            GeneralOptionCommand.ConnectedDevicesWithDetails, //TODO: Remove the Comment When Support Output Type
            GeneralOptionCommand.RestartDevice,
            GeneralOptionCommand.Wifi,
            GeneralOptionCommand.Power,
            GeneralOptionCommand.Install,
            GeneralOptionCommand.Remove,
            GeneralOptionCommand.DarkMode,
            GeneralOptionCommand.PhoneNumber,
            GeneralOptionCommand.HomeButton,
            GeneralOptionCommand.OpenUrl,
            GeneralOptionCommand.Screenshot,
            GeneralOptionCommand.OpenApp,
            GeneralOptionCommand.Delay,
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
        case .HomeButton:
            return TapperConsts.QUESTION_TYPE_NONE
        case .PhoneNumber:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .OpenUrl:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .Screenshot:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .OpenApp:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .Delay:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        }
    }
    
}
