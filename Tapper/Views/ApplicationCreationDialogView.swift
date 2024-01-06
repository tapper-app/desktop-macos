//
//  ApplicationCreationDialogView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct ApplicationCreationDialogView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var nameValue: String = ""
    @State private var packageNameValue: String = ""
    @State private var descriptionValue: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create Application")
                .font(.title)
                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
            
            Text("Add Your Application Information To Start Using Tapper Functions")
                .font(.title2)
                .foregroundColor(TapperUtils.shared.getTextSecondColor())
            
            Group {
                TextField("Application Name *", text: $nameValue, prompt: Text("Application Name *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
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
                TextField("Application Package Name *", text: $packageNameValue, prompt: Text("Application Package Name *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
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
                TextField("Application Description", text: $descriptionValue, prompt: Text("Application Description").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
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
                    if !nameValue.isEmpty && !packageNameValue.isEmpty {
                        viewModel.onInsertApplicationInfo(
                            name: nameValue,
                            packageName: packageNameValue,
                            description: descriptionValue
                        )
                        
                        isPresented = false
                    }
                }) {
                    Text("Create")
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
        .frame(width: 350, height: 600)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
    }
}
