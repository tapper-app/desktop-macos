//
//  DeveloperOptionCommand.swift
//  Tapper
//
//  Created by Yazan Tarifi on 13/01/2024.
//

import Foundation

public enum DeveloperOptionCommand {
    case Overdraw
    case Layout
    case Touch
    case Pointer
    case Strict
    case GpuUpdates
    case DeveloperOptions
    case HardwareAccelerator
    case Rtl
    case GpuRendering
    
    public static func getQuestionType(type: DeveloperOptionCommand) -> Int {
        switch (type) {
        case .Overdraw:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Layout:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Touch:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Pointer:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Strict:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .GpuUpdates:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .DeveloperOptions:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .Rtl:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .HardwareAccelerator:
            return TapperConsts.QUESTION_TYPE_TOGGLE
        case .GpuRendering:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        }
    }
    
    public static func getCommandsList() -> [DeveloperOptionCommand] {
        return [
            DeveloperOptionCommand.Overdraw,
            DeveloperOptionCommand.Layout,
            DeveloperOptionCommand.Touch,
            DeveloperOptionCommand.Pointer,
            DeveloperOptionCommand.Strict,
            DeveloperOptionCommand.GpuUpdates,
            DeveloperOptionCommand.DeveloperOptions,
            DeveloperOptionCommand.HardwareAccelerator,
            DeveloperOptionCommand.Rtl,
            DeveloperOptionCommand.GpuRendering,
        ]
    }
    
    public static func getCommandNameByType(type: DeveloperOptionCommand) -> String {
        switch (type) {
        case .Overdraw:
            return "Toggle Overdraw"
        case .Layout:
            return "Toggle Layout Bounds"
        case .Touch:
            return "Toggle Touches"
        case .Pointer:
            return "Toggle Pointer Location"
        case .Strict:
            return "Toggle Strict Mode"
        case .GpuUpdates:
            return "Toggle Gpu Updates"
        case .DeveloperOptions:
            return "Toggle Developer Options"
        case .HardwareAccelerator:
            return "Toggle Hardware Accelerator"
        case .Rtl:
            return "Toggle Force RTL"
        case .GpuRendering:
            return "Change Gpu Rendering"
        }
    }
    
    public static func getCommandQuestionByType(type: DeveloperOptionCommand) -> String {
        switch (type) {
        case .Overdraw:
            return "Do You want to Enable / Disable Gpu Overdraw ?"
        case .Layout:
            return "Do You want to Enable / Disable Layout Bounds ?"
        case .Touch:
            return "Do You want to Enable / Disable Touches ?"
        case .Pointer:
            return "Do You want to Enable / Disable Pointer Location ?"
        case .Strict:
            return "Do You want to Enable / Disable Strict Mode ?"
        case .GpuUpdates:
            return "Do You want to Enable / Disable View Updates ?"
        case .DeveloperOptions:
            return "Do You want to Enable / Disable Developer Options ?"
        case .HardwareAccelerator:
            return "Do You want to Enable / Disable Hardware Acceleration ?"
        case .Rtl:
            return "Do You want to Enable / Disable Force Rtl ?"
        case .GpuRendering:
            return "Change Gpu Rendering ? Type (o,v) for (OpenGL, Vulkan)"
        }
    }
    
    public static func getCommandsQuestionsList() -> [String] {
        var commandsToShow: [String] = []
        getCommandsList().forEach { command in
            commandsToShow.append(DeveloperOptionCommand.getCommandNameByType(type: command))
        }
        
        return commandsToShow
    }
    
    public static func getCommandKeyByType(command: DeveloperOptionCommand?) -> String {
        switch (command) {
        case .Overdraw:
            return "overdraw"
        case .Layout:
            return "layout"
        case .Touch:
            return "touch"
        case .Pointer:
            return "pointer"
        case .Strict:
            return "strict"
        case .GpuUpdates:
            return "gpu-updates"
        case .DeveloperOptions:
            return "dev-options"
        case .HardwareAccelerator:
            return "hardware"
        case .Rtl:
            return "rtl"
        case .GpuRendering:
            return "gpu-rendering"
        case .none:
            return ""
        }
    }
    
}
