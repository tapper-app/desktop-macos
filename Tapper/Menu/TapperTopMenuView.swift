//
//  TapperTopMenuView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 27/01/2024.
//

import SwiftUI

struct TapperTopMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image("Logo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                    
                
                Text("Tapper")
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .font(.title3)
                
                Text("Android Development Tool")
                    .foregroundColor(TapperUtils.shared.getRedColor())
                    .font(.caption)
                
                Text("Automate, Change Developer Options In Your Android Applications Without Writing Code or Commands")
                    .foregroundColor(TapperUtils.shared.getApplicationSecondColor())
                    .font(.caption2)
                    .lineLimit(2)
            }
            .padding()
        }
    }
}

#Preview {
    TapperTopMenuView()
}
