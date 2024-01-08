//
//  HomeStatusBarView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct HomeStatusBarView: View {
    
    let name: String
    let isActive: Bool
    
    var body: some View {
        HStack {
            Circle()
                .fill(isActive ? TapperUtils.shared.getGreenColor() : TapperUtils.shared.getRedColor())
                .frame(width: 15, height: 15)
            
            Text(name)
                .foregroundColor(TapperUtils.shared.getTextSecondColor())
                .font(.caption2)
                .padding(.leading, 3)
        }
        .padding(6)
        .padding(.leading, 2)
    }
}
