//
//  TapperAppCellView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct TapperAppCellView: View {
    
    let application: TapperApplicationModel
    let viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Image("ApplicationListIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(8)
                .background(
                    application.isSelected ? TapperUtils.shared.getGreenColor() : TapperUtils.shared.getApplicationSecondColor()
                )
                .cornerRadius(10)
                .foregroundColor(.white)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(application.id)
                        .font(.title3)
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Menu {
                        Button(action: {
                            viewModel.onDeleteApp(app: application)
                        }) {
                            Text("Delete Application")
                                .foregroundColor(.red)
                        }
                            } label: {
                                VStack {
                                    Image("MoreImage")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 20, height: 20)
                                        .padding(4)
                                        .foregroundColor(.white)
                                        .colorInvert()
                                }
                            }
                            .frame(width: 20, height: 20)
                            .padding(4)
                            .foregroundColor(.white)
                            .menuStyle(.borderlessButton)
                            .colorInvert()
                }
                
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
