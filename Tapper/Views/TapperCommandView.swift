//
//  TapperCommandView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct TapperCommandView: View {
    
    let command: TapperCommandOption
    
    var body: some View {
        HStack {
            Image(command.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(8)
                .background(TapperUtils.shared.getApplicationSecondColor())
                .cornerRadius(10)
                .foregroundColor(.white)
            
            Text(command.id)
                .font(.caption)
                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                .lineLimit(1)
            .padding(.leading, 2)
            
            Spacer()
        }
        .padding(3)
    }
}
