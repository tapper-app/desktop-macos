//
//  CreateTestScenarioDialog.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import SwiftUI

struct CreateTestScenarioDialog: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var nameValue: String = ""
    @State private var descriptionValue: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create New Test Case Scenario")
                .font(.title)
                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
            
            Text("Tapper Can save Several Test Cases Secarios inside Single Application to Cover Multiple Flows of Your App, Create Your Test Case Scenario to Start ...")
                .font(.caption)
                .foregroundColor(TapperUtils.shared.getTextSecondColor())
            
            Group {
                TextField("Test Scenario Name *", text: $nameValue, prompt: Text("Test Scenario Name *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
                    .padding()
                    .background(TapperUtils.shared.getTextSecondColor())
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .lineLimit(1)

            }
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            Group {
                TextField("Test Scenario Description *", text: $descriptionValue, prompt: Text("Test Scenario Description *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
                    .padding()
                    .background(TapperUtils.shared.getTextSecondColor())
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .lineLimit(1)
            }
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            HStack {
                Button(action: {
                    if !nameValue.isEmpty && !descriptionValue.isEmpty {
                        viewModel.onCreateTestScenario(name: nameValue, description: descriptionValue)
                        isPresented = false
                    }
                }) {
                    Text("Save")
                        .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                        .padding()
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                }
                .buttonStyle(.bordered)
                .tint(TapperUtils.shared.getTextSecondColor())
                .cornerRadius(10)

                Button(action: {
                    isPresented = false
                }) {
                    Text("Close")
                        .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                        .padding()
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                }
                .buttonStyle(.bordered)
                .tint(TapperUtils.shared.getTextSecondColor())
                .cornerRadius(10)
            }
            .padding(.top, 4)
        }
        .padding()
        .frame(width: 350, height: 330)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
    }
}

