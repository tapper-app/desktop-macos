//
//  TestScenarioView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import SwiftUI

struct TestScenarioView: View {
    
    let testScenario: TapperTestScenarioModel
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(testScenario.name)
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                            .font(.title2)
                            .padding(.bottom, 5)
                        
                        Spacer()
                    }
                    
                    Text("")
                        .frame(height: 20)
                    
                    HStack {
                        Text(testScenario.testDescription)
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
                            viewModel.onDeleteTestScenario(testScenario: testScenario)
                        }) {
                            Text("Delete Test Scenario")
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
    }
}
