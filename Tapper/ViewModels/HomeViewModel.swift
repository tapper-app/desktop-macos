//
//  HomeViewModel.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation
import SwiftUI

public class HomeViewModel: ObservableObject {
    
    @Published var applicationsList: [TapperApplicationModel] = [
        TapperApplicationModel(id: "Application 1", image: "App Image", description: "App Description"),
    ]
    
    @Published var commandsList: [TapperCommandOption] = [
        TapperCommandOption(id: "Developer Options", icon: "DeveloperOptionsIcon", command: "execute-dev-option"),
        TapperCommandOption(id: "Testing Functions", icon: "TestFunctionsOptionsIcon", command: "execute-testing-events"),
        TapperCommandOption(id: "General Options", icon: "GeneralTestingOptionsIcon", command: "execute-general-options"),
        TapperCommandOption(id: "Monkey Testing", icon: "MonkeyTestingOptionsIcon", command: "execute-monkey-testing"),
        TapperCommandOption(id: "Automatic Testing", icon: "AutomaticTestingOptionsIcon", command: "execute-auto-flow")
    ]
    
}
