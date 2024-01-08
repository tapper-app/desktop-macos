//
//  TapperUtils.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation
import SwiftUI

public class TapperUtils {
    
    public static let shared = TapperUtils()
    
    public func getApplicationPrimaryColor() -> Color {
        return Color("PrimaryColor")
    }
    
    public func getApplicationSecondColor() -> Color {
        return Color("SecondColor")
    }
    
    public func getTextPrimaryColor() -> Color {
        return Color("TextPrimaryColor")
    }
    
    public func getTextSecondColor() -> Color {
        return Color("TextSecondColor")
    }
    
    public func getGreenColor() -> Color {
        return Color("GreenColor")
    }
    
    public func getRedColor() -> Color {
        return Color("RedColor")
    }
    
    public func getAccentColor() -> Color {
        return Color("AccentColor")
    }
    
    public func isTextContainsNumbers(text: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return text.rangeOfCharacter(from: decimalCharacters) != nil
    }
    
    @discardableResult
    public func onExecuteCommand(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.standardInput = nil

        try task.run() //<--updated
            
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
            
        return output
    }
    
    public func getCurrentTimestamp() -> Int64 {
        let currentDate = Date()
        let timestamp = Int64(currentDate.timeIntervalSince1970)
        return timestamp
    }
    
}
