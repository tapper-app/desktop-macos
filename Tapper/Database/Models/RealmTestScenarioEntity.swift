//
//  RealmTestScenarioEntity.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import Foundation
import RealmSwift

public class RealmTestScenarioEntity: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var applicationId: String = ""
    @Persisted var name: String = ""
    @Persisted var testDescription: String = ""
    @Persisted var order: Int = 0
    
    convenience init(id: String, applicationId: String, name: String, testDescription: String) {
        self.init()
        self.id = id
        self.applicationId = applicationId
        self.name = name
        self.testDescription = testDescription
    }
}
