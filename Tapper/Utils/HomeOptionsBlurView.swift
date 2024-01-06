//
//  HomeOptionsBlurView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation
import SwiftUI

public struct HomeOptionsBlurView: NSViewRepresentable {
    
    public func makeNSView(context: Context) -> some NSView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        return view
    }
    
    public func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}
