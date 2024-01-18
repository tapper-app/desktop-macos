//
//  HomeApplicationInfoView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct TestScenarioScreen: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var isCreateCommandDialogEnabled = false
    
    var body: some View {
        HStack {
            VStack {
                // App Info
                HStack {
                    HStack(alignment: .center) {
                        VStack {
                            Image("LeftArrow")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    viewModel.onRemoveSelectedTestScenario()
                                }
                            
                            Spacer()
                        }
                        .frame(height: 50)
                        
                        Image("ApplicationListIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.getSelectedApplication()?.id ?? "")
                                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                                .font(.title)
                            
                            Text(viewModel.getSelectedApplication()?.description ?? "")
                                .foregroundColor(TapperUtils.shared.getTextSecondColor())
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .font(.caption)
                        }
                        .padding()
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    
                    Spacer()
                }
                
                HStack {
                    Text(viewModel.selectedTestScenario?.name ?? "")
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        .font(.title2)
                        .padding(.top, 8)
                    
                    Spacer()
                }
                
                // Testing Scenarios List
                Text("\(viewModel.testScenariosList.count)")
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.testScenarioCommandsList, id: \.id) { command in
                            HStack {
                                TapperCommandListView(command: command)
                                Spacer()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 450)
                .padding()
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                Spacer()
                Image("AddImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .padding(8)
                    .background(TapperUtils.shared.getAccentColor())
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .onTapGesture {
                        isCreateCommandDialogEnabled = true
                    }
                
                if !viewModel.testScenarioCommandsList.isEmpty {
                    Text("")
                        .frame(height: 10)
                    
                    Image("RightArrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .padding(8)
                        .background(TapperUtils.shared.getAccentColor())
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .onTapGesture {
                            
                        }
                }
            }
            .padding(.trailing, 15)
                
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .padding()
        .onAppear {
            viewModel.getTestScenarioCommands()
        }
        .sheet(isPresented: $isCreateCommandDialogEnabled) {
            CreateScenarioCommandDialog(
                isPresented: $isCreateCommandDialogEnabled,
                viewModel: viewModel
            )
        }
    }
}
