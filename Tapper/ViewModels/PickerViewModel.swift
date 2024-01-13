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
        
    }
    
    private func onDeveloperOptionsSelected(value: String) {
        
    }
    
    /**
      Testing Options Section
     */
    private func getTestingOptionsList() {
        
    }
    
    private func onTestingFunctionsSelected(value: String) {
        
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
        let actionsList = GeneralOptionCommand.getCommandsList()
        
        var commandsToShow: [String] = []
        actionsList.forEach { command in
            commandsToShow.append(GeneralOptionCommand.getCommandNameByType(type: command))
        }
        
        self.optionsList = commandsToShow
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
