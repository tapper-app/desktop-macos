//
//  PickerViewModel.swift
//  Tapper
//
//  Created by Yazan Tarifi on 13/01/2024.
//

import Foundation

public class PickerViewModel: ObservableObject {
    
    @Published var optionsList: [String] = []
    @Published var questionDetails: PickerOptionEntityDetails? = nil
    private var selectedGeneralOption: GeneralOptionCommand? = nil
    private var selectedDeveloperOption: DeveloperOptionCommand? = nil
    private var selectedTestingOption: TestFunctionCommand? = nil
    
    public func getOptionsListByPickerType(type: TapperPickerType) {
        switch (type) {
        case .GeneralOptions:
            getGeneralOptionsList()
        case .DeveloperOptions:
            getDeveloperOptionsList()
        case .TestFunctions:
            getTestingOptionsList()
        }
    }
    
    public func onPickerOptionSelected(type: TapperPickerType, value: String) {
        switch (type) {
        case .GeneralOptions:
            onGeneralOptionSelected(value: value)
        case .DeveloperOptions:
            onDeveloperOptionsSelected(value: value)
        case .TestFunctions:
            onTestingFunctionsSelected(value: value)
        }
    }
    
    /**
      Developer Options Section
     */
    private func getDeveloperOptionsList() {
        self.optionsList = DeveloperOptionCommand.getCommandsQuestionsList()
    }
    
    private func onDeveloperOptionsSelected(value: String) {
        let index = self.getOptionIndex(list: DeveloperOptionCommand.getCommandsQuestionsList(), pickedItem: value)
        let selectedCommand = DeveloperOptionCommand.getCommandsList()[index]
        let commandQuestionType = DeveloperOptionCommand.getQuestionType(type: selectedCommand)
        self.selectedDeveloperOption = selectedCommand
        self.questionDetails = PickerOptionEntityDetails(
            questionName: DeveloperOptionCommand.getCommandQuestionByType(type: selectedCommand),
            questionType: commandQuestionType
        )
    }
    
    /**
      Testing Options Section
     */
    private func getTestingOptionsList() {
        self.optionsList = TestFunctionCommand.getCommandsQuestionsList()
    }
    
    private func onTestingFunctionsSelected(value: String) {
        let index = self.getOptionIndex(list: TestFunctionCommand.getCommandsQuestionsList(), pickedItem: value)
        let selectedCommand = TestFunctionCommand.getCommandsList()[index]
        let commandQuestionType = TestFunctionCommand.getQuestionType(type: selectedCommand)
        self.selectedTestingOption = selectedCommand
        self.questionDetails = PickerOptionEntityDetails(
            questionName: TestFunctionCommand.getCommandQuestionByType(type: selectedCommand),
            questionType: commandQuestionType
        )
    }
    
    /**
      Genral Options Section
     */
    private func onGeneralOptionSelected(value: String) {
        let index = self.getOptionIndex(list: GeneralOptionCommand.getCommandsQuestionsList(), pickedItem: value)
        let selectedCommand = GeneralOptionCommand.getCommandsList()[index]
        let commandQuestionType = GeneralOptionCommand.getQuestionType(type: selectedCommand)
        self.selectedGeneralOption = selectedCommand
        self.questionDetails = PickerOptionEntityDetails(
            questionName: GeneralOptionCommand.getCommandQuestionByType(type: selectedCommand),
            questionType: commandQuestionType
        )
    }
    
    private func getGeneralOptionsList() {
        self.optionsList = GeneralOptionCommand.getCommandsQuestionsList()
    }
    
    public func onExecutePickedCommand(commandType: TapperPickerType, answer: String) {
        TapperUtils.shared.onExecuteTapperCommand(command: getCommandString(commandType: commandType, answer: answer))
    }
    
    private func getCommandString(commandType: TapperPickerType, answer: String) -> String {
        switch (commandType) {
        case .GeneralOptions:
            return "\(TapperConsts.EXECUTE_GENERAL_SETTINGS) \(GeneralOptionCommand.getCommandKeyByType(command: selectedGeneralOption)) \(answer)"
        case .DeveloperOptions:
            return "\(TapperConsts.EXECUTE_DEVELOPER_SETTINGS) \(DeveloperOptionCommand.getCommandKeyByType(command: selectedDeveloperOption)) \(answer)"
        case .TestFunctions:
            return "\(TapperConsts.EXECUTE_TESTING_EVENTS) \(TestFunctionCommand.getCommandKeyByType(command: selectedTestingOption)) \(answer)"
        }
    }
    
    public func onCreateTestCommandInstance(
        name: String,
        answer: String,
        commandType: TapperPickerType,
        order: Int32,
        scenarioId: String
    ) -> RealmTestCommandEntity {
        let commandToExecute = self.getCommandString(commandType: commandType, answer: answer)
        let commandToInsert = RealmTestCommandEntity(
            id: TapperUtils.shared.getRandomUUID(),
            name: name,
            command: commandToExecute,
            testScenarioId: scenarioId,
            order: order
        )
        
        return commandToInsert
    }
    
    private func getOptionIndex(list: [String], pickedItem: String) -> Int {
        var selectedIndex = 0
        for (index, value) in list.enumerated() {
            if value == pickedItem {
                selectedIndex = index
                break
            }
        }
        
        return selectedIndex
    }
    
}
