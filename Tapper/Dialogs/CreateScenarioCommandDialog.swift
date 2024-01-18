//
//  CreateScenarioCommandDialog.swift
//  Tapper
//
//  Created by Yazan Tarifi on 18/01/2024.
//

import SwiftUI

struct CreateScenarioCommandDialog: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var isToggled = false
    @State private var selectedFile: URL?
    @State private var questionAnswer: String = ""
    @State private var nameValue: String = ""
    @State private var pickerType: TapperPickerType = .DeveloperOptions
    @State private var selectedOption: String = ""
    @State private var selectedActionOption: String = ""
    @State private var commandsTypeList: [String] = ["General Options", "Developer Options", "Testing Commands"]
    @StateObject private var pickerViewModel: PickerViewModel = PickerViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create New Test Command")
                .font(.title)
                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
            
            Text("Tapper Can Save a List of Commands To Execute in a List to Save Time for You to Pick and Remember Each Input and Command, Here you Can Only Pick them and Start Executing all of them Directly in Your App")
                .font(.caption)
                .foregroundColor(TapperUtils.shared.getTextSecondColor())
            
            Group {
                TextField("Test Command Name *", text: $nameValue, prompt: Text("Test Command Name *").foregroundColor(TapperUtils.shared.getApplicationPrimaryColor()))
                    .padding()
                    .background(TapperUtils.shared.getTextSecondColor())
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .lineLimit(1)

            }
            .frame(width: 400)
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            Group {
                Picker("Select Command Type", selection: $selectedOption) {
                    ForEach(self.commandsTypeList, id: \.self) { option in
                        Text(option)
                            .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                            .lineLimit(1)
                    }
                }
                .padding()
                .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                .pickerStyle(.menu)
                .onChange(of: selectedOption) {
                    if selectedOption == "General Options" {
                        pickerType = .GeneralOptions
                        pickerViewModel.getOptionsListByPickerType(type: .GeneralOptions)
                    } else if selectedOption == "Developer Options" {
                        pickerType = .DeveloperOptions
                        pickerViewModel.getOptionsListByPickerType(type: .DeveloperOptions)
                    } else {
                        pickerType = .TestFunctions
                        pickerViewModel.getOptionsListByPickerType(type: .TestFunctions)
                    }
                }
            }
            .frame(width: 400)
            .background(TapperUtils.shared.getTextSecondColor())
            .cornerRadius(10)
            .padding(.top, 4)
            
            if !pickerViewModel.optionsList.isEmpty {
                Group {
                    Picker("Select the Action", selection: $selectedActionOption) {
                        ForEach(pickerViewModel.optionsList, id: \.self) { option in
                            Text(option)
                                .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                                .lineLimit(1)
                        }
                    }
                    .padding()
                    .foregroundColor(TapperUtils.shared.getApplicationPrimaryColor())
                    .pickerStyle(.menu)
                    .onChange(of: selectedActionOption) {
                        pickerViewModel.onPickerOptionSelected(type: pickerType, value: selectedActionOption)
                    }
                }
                .frame(width: 400)
                .background(TapperUtils.shared.getTextSecondColor())
                .cornerRadius(10)
                .padding(.top, 4)
            }
            
            if pickerViewModel.questionDetails != nil && pickerViewModel.questionDetails?.questionType != TapperConsts.QUESTION_TYPE_NONE {
                Group {
                    switch pickerViewModel.questionDetails?.questionType {
                    case TapperConsts.QUESTION_TYPE_TEXT_INPUT:
                        getTextInputView(title: pickerViewModel.questionDetails?.questionName ?? "")
                    case TapperConsts.QUESTION_TYPE_PATH_PICKER:
                        getFilePickerInput(title: pickerViewModel.questionDetails?.questionName ?? "")
                    case TapperConsts.QUESTION_TYPE_TOGGLE:
                        getSwitchView(title: pickerViewModel.questionDetails?.questionName ?? "")
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
                    if !nameValue.isEmpty && (pickerViewModel.questionDetails) != nil {
                        let instance = pickerViewModel.onCreateTestCommandInstance(
                            name: nameValue,
                            answer: questionAnswer,
                            commandType: pickerType,
                            order: Int32(viewModel.testScenarioCommandsList.count + 1),
                            scenarioId: viewModel.selectedTestScenario?.id ?? ""
                        )
                        
                        viewModel.onInsertCommand(command: instance)
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
        .frame(width: 450, height: 600)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
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

