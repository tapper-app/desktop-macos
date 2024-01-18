//
//  RealmTestCommandEntity.swift
//  Tapper
//
//  Created by Yazan Tarifi on 18/01/2024.
//

import Foundation
import RealmSwift

public class RealmTestCommandEntity: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String = ""
    @Persisted var command: String = ""
    @Persisted var testScenarioId: String = ""
    @Persisted var order: Int32 = 0
    
    convenience init(id: String, name: String, command: String, testScenarioId: String, order: Int32) {
        self.init()
        self.id = id
        self.name = name
        self.command = command
        self.testScenarioId = testScenarioId
        self.order = order
    }
    
}
