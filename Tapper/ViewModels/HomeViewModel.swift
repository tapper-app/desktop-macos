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
            if applicationsCount == 0 {
                self.selectedScreenView = .Default
            } else {
                self.selectedApplication = applications[0]
                self.selectedScreenView = .Application
            }
        }
    }
    
    public func onInsertApplicationInfo(name: String, packageName: String, description: String) {
        var appModel = TapperApplicationModel(
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
        
        appModel.isSelected = true
        selectedApplication = appModel
        selectedScreenView = .Application
        self.getAppTestScenarios()
        
        applicationsDataSource.onInsertApplication(app: appModel)
        applicationsList.append(appModel)
    }
    
    public func onRunCommands() {
        DispatchQueue.global(qos: .background).async {
            self.testScenarioCommandsList.enumerated().forEach { (index, element) in
                let delay = TimeInterval(index) * 1.0 // Adjust the delay as needed
                if element.command.contains("delay") {
                    let delayTime = Int(element.command.split(separator: "delay")[1].trimmingCharacters(in: NSCharacterSet.whitespaces))
                    print("Commands List Execution : Delay for \(String(describing: delayTime)) in Seconds")
                    sleep(UInt32(delayTime ?? 1))
                } else {
                    print("Commands List Execution : Execute Command : \(element.name)")
                    self.onExecuteCommand(element.command, withDelay: delay)
                }
            }
            
            // Wait for the asynchronous operations to complete (useful in a playground or non-async environment)
            sleep(UInt32(self.testScenarioCommandsList.count))
        }
    }
    
    private func onExecuteCommand(_ element: String, withDelay delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            TapperUtils.shared.onExecuteTapperCommand(command: element)
        }
    }
    
    public func onExecuteCommand(command: TapperTestCommandEntity) {
        TapperUtils.shared.onExecuteTapperCommand(command: command.command)
    }
    
    public func onDeleteTestScenario(testScenario: TapperTestScenarioModel) {
        DispatchQueue.global(qos: .background).async {
            self.testScenariosDataSource.onDeleteTestScenario(id: testScenario.id)
            DispatchQueue.main.async {
                var testsList = self.testScenariosList
                if let indexToRemove = testsList.firstIndex(where: { $0.id == testScenario.id }) {
                    testsList.remove(at: indexToRemove)
                }
                
                self.testScenariosList = testsList
            }
        }
    }
    
    public func onDeleteCommand(command: TapperTestCommandEntity) {
        DispatchQueue.global(qos: .background).async {
            self.testScenarioCommandsDataSource.onDeleteCommand(id: command.id)
            DispatchQueue.main.async {
                var commandsList = self.testScenarioCommandsList
                if let indexToRemove = commandsList.firstIndex(where: { $0.id == command.id }) {
                    commandsList.remove(at: indexToRemove)
                }
                
                self.testScenarioCommandsList = commandsList
            }
        }
    }
    
    public func onSelectApp(app: TapperApplicationModel) {
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
        
        self.getAppTestScenarios()
    }
    
    public func onDeleteApp(app: TapperApplicationModel) {
        DispatchQueue.global(qos: .background).async {
            self.applicationsDataSource.onDeleteApp(app: app) { isEmpty in
                if isEmpty {
                    DispatchQueue.main.async {
                        self.testScenariosList = []
                        self.applicationsList = []
                        self.testScenarioCommandsList = []
                    }
                    
                    self.testScenariosDataSource.onDeleteAllTestScenario()
                } else {
                    self.testScenariosDataSource.onDeleteTestScenarioByAppId(id: app.id)
                }
            }
            
            DispatchQueue.main.async {
                var appsList = self.applicationsList
                appsList.removeAll { $0.packageName == app.packageName }
                self.testScenarioCommandsList = []
                
                self.applicationsList = appsList
                if self.applicationsList.count == 1 {
                    self.applicationsList[0].isSelected = true
                    self.selectedApplication = self.applicationsList[0]
                    self.selectedScreenView = .Application
                    self.getAppTestScenarios()
                }
                
                if self.applicationsList.count == 0 {
                    self.selectedApplication = nil
                    self.selectedScreenView = .Default
                    self.testScenariosList = []
                    self.applicationsList = []
                    self.testScenarioCommandsList = []
                }
            }
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
