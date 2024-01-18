//
//  HomeViewModel.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation
import SwiftUI

public class HomeViewModel: ObservableObject {
    
    private var selectedApplication: TapperApplicationModel? = nil
    private let applicationsDataSource = TapperApplicationsDataSource()
    private let testScenariosDataSource = TapperTestScenariosDataSource()
    private let testScenarioCommandsDataSource = TapperTestCommandsDataSource()
    
    @Published var testScenariosList: [TapperTestScenarioModel] = []
    @Published var testScenarioCommandsList: [TapperTestCommandEntity] = []
    @Published var selectedScreenView: HomeScreenContentType = HomeScreenContentType.NotSet
    @Published var selectedTestScenario: TapperTestScenarioModel? = nil
    @Published var applicationsList: [TapperApplicationModel] = []
    @Published var commandsList: [TapperCommandOption] = []
    
    public func getApplications() {
        commandsList = getCommandsListOptions()
        applicationsDataSource.getRegisteredApplications { applications in
            self.applicationsList.append(contentsOf: applications)
            let applicationsCount = applications.count
            if applicationsCount == 1 {
                self.selectedApplication = applications[0]
                self.selectedScreenView = .Application
            }
            
            if applicationsCount == 0 {
                self.selectedScreenView = .Default
            }
        }
    }
    
    public func onInsertApplicationInfo(name: String, packageName: String, description: String) {
        let appModel = TapperApplicationModel(
            id: name,
            image: "",
            description: description,
            packageName: packageName,
            isSelected: true
        )
        
        applicationsList = applicationsList.map { newItem in
            var itemToInsert = newItem
            itemToInsert.isSelected = false
            return itemToInsert
        }
        
        applicationsDataSource.onInsertApplication(app: appModel)
        applicationsList.append(appModel)
    }
    
    public func onSelectApp(app: TapperApplicationModel) {
        if selectedApplication != nil && selectedApplication?.id == app.id {
            return
        }
        
        self.testScenariosList = []
        self.selectedApplication = app
        self.selectedScreenView = .Application
        self.selectedTestScenario = nil
        
        applicationsList = applicationsList.map { newItem in
            var itemToInsert = newItem
            if itemToInsert.id == app.id {
                itemToInsert.isSelected = true
            } else {
                itemToInsert.isSelected = false
            }
            return itemToInsert
        }
    }
    
    public func getAppTestScenarios() {
        self.selectedTestScenario = nil
        testScenariosDataSource.getTestScenariosByAppId(id: selectedApplication?.id ?? "") { applications in
            self.testScenariosList.append(contentsOf: applications)
        }
    }
    
    public func onInsertCommand(command: RealmTestCommandEntity) {
        testScenarioCommandsDataSource.onInsertCommandEntity(entity: command)
        
        let commandToShow = TapperTestCommandEntity(
            id: command.id,
            name: command.name,
            command: command.command, 
            testScenarioId: command.testScenarioId,
            order: command.order
        )
        
        testScenarioCommandsList.append(commandToShow)
    }
    
    public func onSelectTestScenario(testScenario: TapperTestScenarioModel) {
        self.selectedTestScenario = testScenario
        self.selectedScreenView = .TestScenario
    }
    
    public func onRemoveSelectedTestScenario() {
        self.selectedTestScenario = nil
        self.selectedScreenView = .Application
    }
    
    public func getTestScenarioCommands() {
        self.testScenarioCommandsDataSource.getCommandsByTestCaseId(id: selectedTestScenario?.id ?? "") { commands in
            self.testScenarioCommandsList = commands
        }
    }
    
    public func onCreateTestScenario(name: String, description: String) {
        let testScenarioToInsert = TapperTestScenarioModel(
            id: "",
            applicationId: selectedApplication?.id ?? "",
            name: name,
            testDescription: description,
            order: testScenariosList.count + 1
        )
        
        testScenariosDataSource.onInsertApplication(testScenario: testScenarioToInsert, order: testScenariosList.count + 1)
        testScenariosList.append(testScenarioToInsert)
    }
    
    private func getCommandsListOptions() -> [TapperCommandOption] {
        return [
            TapperCommandOption(
                id: "Developer Options",
                icon: "DeveloperOptionsIcon",
                command: TapperConsts.EXECUTE_DEVELOPER_SETTINGS
            ),
            
            TapperCommandOption(
                id: "Testing Functions",
                icon: "TestFunctionsOptionsIcon",
                command: TapperConsts.EXECUTE_TESTING_EVENTS
            ),
            
            TapperCommandOption(
                id: "General Options",
                icon: "GeneralTestingOptionsIcon",
                command: TapperConsts.EXECUTE_GENERAL_SETTINGS
            ),
            
            TapperCommandOption(
                id: "Monkey Testing",
                icon: "MonkeyTestingOptionsIcon",
                command: TapperConsts.EXECUTE_MONKEY_TESTING
            ),
            
//            TapperCommandOption(
//                id: "Automatic Testing",
//                icon: "AutomaticTestingOptionsIcon",
//                command: TapperConsts.EXECUTE_AUTO_FLOW
//            ),
            
            TapperCommandOption(
                id: "Settings",
                icon: "TestFunctionsOptionsIcon",
                command: TapperConsts.EXECUTE_SETTINGS
            )
        ]
    }
    
    
    public func getSelectedApplication() -> TapperApplicationModel? {
        return self.selectedApplication
    }
}
