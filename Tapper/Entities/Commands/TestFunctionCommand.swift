//
//  TestFunctionCommand.swift
//  Tapper
//
//  Created by Yazan Tarifi on 13/01/2024.
//

import Foundation

public enum TestFunctionCommand {
    case Click
    case DoubleClick
    case ScrollToTop
    case ScrollToBottom
    
    public static func getQuestionType(type: TestFunctionCommand) -> Int {
        switch (type) {
        case .Click:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .DoubleClick:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .ScrollToTop:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        case .ScrollToBottom:
            return TapperConsts.QUESTION_TYPE_TEXT_INPUT
        }
    }
    
    public static func getCommandsList() -> [TestFunctionCommand] {
        return [
            TestFunctionCommand.Click,
            TestFunctionCommand.DoubleClick,
            TestFunctionCommand.ScrollToTop,
            TestFunctionCommand.ScrollToBottom,
        ]
    }
    
    public static func getCommandNameByType(type: TestFunctionCommand) -> String {
        switch (type) {
        case .Click:
            return "Submit Click Event"
        case .DoubleClick:
            return "Submit Double Click Event"
        case .ScrollToTop:
            return "Scroll To Top"
        case .ScrollToBottom:
            return "Scroll To bottom"
        }
    }
    
    public static func getCommandQuestionByType(type: TestFunctionCommand) -> String {
        switch (type) {
        case .Click:
            return "Write the Coordinates (x,y)"
        case .DoubleClick:
            return "Write the Coordinates (x,y)"
        case .ScrollToTop:
            return "Write the Screen Height"
        case .ScrollToBottom:
            return "Do You want to Enable / Disable Pointer Location ?"
        }
    }
    
    public static func getCommandsQuestionsList() -> [String] {
        var commandsToShow: [String] = []
        getCommandsList().forEach { command in
            commandsToShow.append(TestFunctionCommand.getCommandNameByType(type: command))
        }
        
        return commandsToShow
    }
    
    public static func getCommandKeyByType(command: TestFunctionCommand?) -> String {
        switch (command) {
        case .Click:
            return "click"
        case .DoubleClick:
            return "double-click"
        case .ScrollToTop:
            return "scroll-top"
        case .ScrollToBottom:
            return "scroll-bottom"
        case .none:
            return ""
        }
    }
    
}
