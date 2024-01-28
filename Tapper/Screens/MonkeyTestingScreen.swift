//
//  MonkeyTestingScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import SwiftUI

struct MonkeyTestingScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var applicationPackageNameExecution: String
    @State private var applicationNumberOfClicks: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tapper Monkey Testing")
                    .font(.title)
                    .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                
                Spacer()
            }
            
            HStack {
                Text("Monkey Testing is a Native Android Applications Testing That Opening an Application by its own Package Name and Simulate Random Clicks on the Connected Device")
                    .font(.caption)
                    .foregroundColor(TapperUtils.shared.getTextSecondColor())
                
                Spacer()
            }
            
            Text("")
                .frame(height: 50)
            
            Group {
                TextField("Application Package Name *", text: $applicationPackageNameExecution, prompt: Text("Application Package Name *")
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
                    .padding()
                    .background(TapperUtils.shared.getTextSecondColor())
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .lineLimit(1)
                    .onChange(of: applicationPackageNameExecution) { newValue in
                        applicationPackageNameExecution = newValue
                    }
            }
            .frame(width: 400)
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            Group {
                TextField("Number of Clicks *", text: $applicationNumberOfClicks, prompt: Text("Number of Clicks *")
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
                    .padding()
                    .background(TapperUtils.shared.getTextSecondColor())
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .lineLimit(1)
                    .onChange(of: applicationNumberOfClicks) { newValue in
                        applicationNumberOfClicks = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                    }
            }
            .frame(width: 400)
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            HStack {
                Button(action: {
                    if !applicationPackageNameExecution.isEmpty && !applicationNumberOfClicks.isEmpty {
                        TapperUtils.shared.onExecuteTapperCommand(
                            command: "\(TapperConsts.EXECUTE_MONKEY_TESTING) \(applicationNumberOfClicks)"
                        )
                        dismiss()
                    }
                }) {
                    Text("Submit")
                        .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                        .padding()
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                }
                .buttonStyle(.bordered)
                .tint(TapperUtils.shared.getTextSecondColor())
                .cornerRadius(10)

                Button(action: {
                    dismiss()
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
        .frame(width: 450, height: 600)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
    }
}
