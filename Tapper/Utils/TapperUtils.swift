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
    
    public func getAccentColor() -> Color {
        return Color("AccentColor")
    }
    
}
