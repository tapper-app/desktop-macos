//
//  GeneralTestingCommandsScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 12/01/2024.
//

import SwiftUI

struct GeneralTestingCommandsScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var isToggled = false
    @State private var selectedFile: URL?
    @State private var selectedOption: String = ""
    @State private var questionAnswer: String = ""
    @Binding var applicationPackageNameExecution: String
    @StateObject private var viewModel: PickerViewModel = PickerViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tapper General Commands")
                    .font(.title)
                    .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                
                Spacer()
            }
            
            HStack {
                Text("Tapper Has a General Commands on The Connected Android Device Via ADB, Please Select the Action and the Input to Continue")
                    .font(.caption)
                    .foregroundColor(TapperUtils.shared.getTextSecondColor())
                
                Spacer()
            }
            
            Text("")
                .frame(height: 50)
            
            Group {
                Picker("Select the Action", selection: $selectedOption) {
                    ForEach(viewModel.optionsList, id: \.self) { option in
                        Text(option)
                            .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                            .lineLimit(1)
                    }
                }
                .padding()
                .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                .pickerStyle(.menu)
                .onChange(of: selectedOption) {
                    viewModel.onPickerOptionSelected(type: .GeneralOptions, value: selectedOption)
                }
            }
            .frame(width: 400)
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            if viewModel.questionDetails != nil && viewModel.questionDetails?.questionType != TapperConsts.QUESTION_TYPE_NONE {
                Group {
                    switch viewModel.questionDetails?.questionType {
                    case TapperConsts.QUESTION_TYPE_TEXT_INPUT:
                        getTextInputView(title: viewModel.questionDetails?.questionName ?? "")
                    case TapperConsts.QUESTION_TYPE_PATH_PICKER:
                        getFilePickerInput(title: viewModel.questionDetails?.questionName ?? "")
                    case TapperConsts.QUESTION_TYPE_TOGGLE:
                        getSwitchView(title: viewModel.questionDetails?.questionName ?? "")
                    default:
                        EmptyView()
                    }
                }
                .frame(width: 400)
                .background(TapperUtils.shared.getTextSecondColor())
                .cornerRadius(10)
                .padding(.top, 4)
            }
            
            HStack {
                Button(action: {
                    dismiss()
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
        .onAppear {
            viewModel.getOptionsListByPickerType(type: .GeneralOptions)
        }
    }
    
    @ViewBuilder
    private func getTextInputView(title: String) -> some View {
        TextField(title, text: $questionAnswer, prompt: Text(title)
            .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
            .padding()
            .background(TapperUtils.shared.getTextSecondColor())
            .textFieldStyle(PlainTextFieldStyle())
            .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
            .lineLimit(1)
    }
    
    @ViewBuilder
    private func getFilePickerInput(title: String) -> some View {
        HStack {
            if !questionAnswer.isEmpty {
                Text(questionAnswer)
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .padding()
                    .lineLimit(1)
            } else {
                Text(title)
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .padding()
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action: {
                openFilePicker()
            }) {
                Text("Select")
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .padding(4)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .font(.caption2)
            }
            .buttonStyle(.bordered)
            .tint(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(5)
            .padding(.trailing, 9)
        }
    }
    
    @ViewBuilder
    private func getSwitchView(title: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                .padding()
                .lineLimit(1)
            
            Spacer()
            
            Toggle("To ?", isOn: $isToggled)
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: TapperUtils.shared.getApplicationSecondColor()))
        }
    }
    
    private func openFilePicker() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true

        panel.begin { response in
            if response == .OK, let selectedURL = panel.urls.first {
                self.selectedFile = selectedURL
                self.questionAnswer = selectedFile?.lastPathComponent ?? ""
            }
        }
    }
}
