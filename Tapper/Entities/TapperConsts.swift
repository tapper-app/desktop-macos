//
//  TapperConsts.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import Foundation

public class TapperConsts {
    
    // App Deeplinks
    public static let MONKEY_TESTING_DEEPLINK_KEY = "monkey-testing"
    public static let MAIN_DEEPLINK_KEY = "main"
    public static let GENERAL_DEEPLINK_KEY = "general"
    public static let DEVELOPER_DEEPLINK_KEY = "developers"
    public static let TESTING_DEEPLINK_KEY = "testings"
    
    // Commands
    public static let EXECUTE_MONKEY_TESTING = "execute-monkey-testing"
    public static let EXECUTE_GENERAL_SETTINGS = "execute-general-options"
    public static let EXECUTE_DEVELOPER_SETTINGS = "execute-dev-option"
    public static let EXECUTE_TESTING_EVENTS = "execute-testing-events"
    public static let EXECUTE_AUTO_FLOW = "execute-auto-flow"
    public static let EXECUTE_SETTINGS = "settings"
    
    // Question Type
    public static let QUESTION_TYPE_TOGGLE = -1
    public static let QUESTION_TYPE_TEXT_INPUT = -2
    public static let QUESTION_TYPE_PATH_PICKER = -4
    public static let QUESTION_TYPE_NONE = -3
}
