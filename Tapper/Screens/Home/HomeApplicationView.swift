//
//  HomeApplicationView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct HomeApplicationView: View {
    
    @State private var isCreateTestCaseDialogEnabled = false
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            VStack {
                // App Info
                HStack {
                    HStack(alignment: .center) {
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
                    Text("Testing Scenarios")
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        .font(.title2)
                        .padding(.top, 8)
                    
                    Spacer()
                }
                
                // Testing Scenarios List
                if viewModel.testScenariosList.isEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("No Test Scenarios ...")
                                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                                .font(.caption)
                                .padding(.top, 8)
                            Spacer()
                        }
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], alignment: .leading) {
                            ForEach(viewModel.testScenariosList, id: \.id) { testScenario in
                                TestScenarioView(testScenario: testScenario, viewModel: viewModel)
                                    .onTapGesture {
                                        viewModel.onSelectTestScenario(testScenario: testScenario)
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 450)
                    .padding()
                }
                
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
                        isCreateTestCaseDialogEnabled = true
                    }
            }
            .padding(.trailing, 15)
                
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .padding()
        .onAppear {
            viewModel.getAppTestScenarios()
        }
        .sheet(isPresented: $isCreateTestCaseDialogEnabled) {
            CreateTestScenarioDialog(
                isPresented: $isCreateTestCaseDialogEnabled,
                viewModel: viewModel
            )
        }
    }
}
