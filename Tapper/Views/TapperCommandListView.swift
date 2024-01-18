//
//  TapperCommandListView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 18/01/2024.
//

import SwiftUI

struct TapperCommandListView: View {
    
    let command: TapperTestCommandEntity
    init(command: TapperTestCommandEntity) {
        self.command = command
    }
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(command.name)
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                            .font(.title2)
                            .padding(.bottom, 5)
                        
                        Spacer()
                    }
                    
                    Text("")
                        .frame(height: 20)
                    
                    HStack {
                        Text(command.command)
                            .foregroundColor(TapperUtils.shared.getTextSecondColor())
                            .font(.caption2)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                }
                .padding(4)
                
                VStack(alignment: .center) {
                    Image("MoreImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(4)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image("RightArrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(4)
                        .foregroundColor(.white)
                }
            }
            .padding(8)
        }
        .background(TapperUtils.shared.getApplicationPrimaryColor())
        .cornerRadius(10)
        .frame(width: 300)
    }
}
