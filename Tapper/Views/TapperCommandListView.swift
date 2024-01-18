//
//  TapperCommandListView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 18/01/2024.
//

import SwiftUI

struct TapperCommandListView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    let command: TapperTestCommandEntity
    
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
                    Menu {
                        Button(action: {
                            viewModel.onExecuteCommand(command: command)
                        }) {
                            Text("Run Command")
                        }
                        
                        Button(action: {
                            viewModel.onDeleteCommand(command: command)
                        }) {
                            Text("Delete Command")
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

                    
                    Spacer()
                    
                    Image("")
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
        .frame(width: 500)
    }
}
