//
//  TapperAppCellView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct TapperAppCellView: View {
    
    let application: TapperApplicationModel
    
    var body: some View {
        HStack {
            Image("ApplicationListIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(8)
                .background(TapperUtils.shared.getApplicationSecondColor())
                .cornerRadius(10)
                .foregroundColor(.white)
            
            VStack(alignment: .leading) {
                Text(application.id)
                    .font(.title3)
                    .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                    .lineLimit(1)
                
                Text(application.description)
                    .font(.system(.caption))
                    .foregroundColor(TapperUtils.shared.getTextSecondColor())
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }
            .padding(.leading, 2)
            
            Spacer()
        }
        .padding(3)
    }
}
