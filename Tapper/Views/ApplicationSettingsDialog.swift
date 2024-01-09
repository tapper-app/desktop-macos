//
//  ApplicationSettingsDialog.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct ApplicationSettingsDialog: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var adbInstallationPath: String = ""
    @State private var npmInstallationPath: String = ""
    @State private var nodeInstallationPath: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Application Settings")
                .font(.title)
                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
            
            Text("Tapper Need to Configure Your Environment Variables On Your Machine To Use The Utilities Installed On Your Device, Please add the Required Fields (ADB Installation Path, Npm Installation Path, Node Installation Path, Tapper Cli Installation Path) and All of them are Required To Configure Tapper UI Application to Start")
                .font(.caption)
                .foregroundColor(TapperUtils.shared.getTextSecondColor())
            
            Group {
                TextField("ADB Path *", text: $adbInstallationPath, prompt: Text("ADB Path *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
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
                TextField("Node Path *", text: $nodeInstallationPath, prompt: Text("Node Path *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
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
                TextField("Npm Path *", text: $npmInstallationPath, prompt: Text("Npm Path *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
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
                    if !adbInstallationPath.isEmpty && !npmInstallationPath.isEmpty && !nodeInstallationPath.isEmpty {
                        TapperPathsStorageManager.shared.updateApplicationPaths(
                            adbPath: adbInstallationPath,
                            tapperCliPath: "",
                            npmPath: npmInstallationPath,
                            nodePath: nodeInstallationPath
                        )
                        
                        NotificationCenter.default.post(name: .OnSettingsInsertionEvent, object: nil)
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
