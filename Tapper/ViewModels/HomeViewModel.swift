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
    
    @Published var selectedScreenView: HomeScreenContentType = HomeScreenContentType.NotSet
    @Published var applicationsList: [TapperApplicationModel] = []
    @Published var commandsList: [TapperCommandOption] = [
        TapperCommandOption(id: "Developer Options", icon: "DeveloperOptionsIcon", command: "execute-dev-option"),
        TapperCommandOption(id: "Testing Functions", icon: "TestFunctionsOptionsIcon", command: "execute-testing-events"),
        TapperCommandOption(id: "General Options", icon: "GeneralTestingOptionsIcon", command: "execute-general-options"),
        TapperCommandOption(id: "Monkey Testing", icon: "MonkeyTestingOptionsIcon", command: "execute-monkey-testing"),
        TapperCommandOption(id: "Automatic Testing", icon: "AutomaticTestingOptionsIcon", command: "execute-auto-flow"),
        TapperCommandOption(id: "Settings", icon: "TestFunctionsOptionsIcon", command: "settings"),
    ]
    
    public func getApplications() {
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
        self.selectedApplication = app
        self.selectedScreenView = .Application
        
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
    
    public func getSelectedApplication() -> TapperApplicationModel? {
        return self.selectedApplication
    }
}
