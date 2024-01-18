//
//  TapperTestScenariosDataSource.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import Foundation
import RealmSwift

public final class TapperTestScenariosDataSource {
    
    public func onInsertApplication(testScenario: TapperTestScenarioModel, order: Int) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let testScenarioToInsert = RealmTestScenarioEntity(
                id: TapperUtils.shared.getRandomUUID(),
                applicationId: testScenario.applicationId,
                name: testScenario.name,
                testDescription: testScenario.testDescription
            )
            
            testScenarioToInsert.order = order
            
            try! realm.write {
                realm.add(testScenarioToInsert)
            }
        }
    }
    
    public func onDeleteTestScenario(id: String) {
        let realm = try! Realm()
        try! realm.write {
            let testScenarioToDelete = realm
                .objects(RealmTestScenarioEntity.self)
                .filter("id == %@", id)
                .first
            
            let commandsToDelete = realm
                .objects(RealmTestCommandEntity.self)
                .filter("testScenarioId == %@", id)
            
            if testScenarioToDelete != nil {
                realm.delete(testScenarioToDelete!)
            }
            
            if !commandsToDelete.isEmpty {
                realm.delete(commandsToDelete)
            }
        }
    }
    
    public func getTestScenariosByAppId(id: String, onAppsReady: @escaping ([TapperTestScenarioModel]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let sortedEntities = realm
                .objects(RealmTestScenarioEntity.self)
                .filter("applicationId == %@", id)
                .sorted(byKeyPath: "order", ascending: true)
            
            var testScenariosList: [TapperTestScenarioModel] = []
            
            sortedEntities.forEach { element in
                testScenariosList.append(TapperTestScenarioModel(
                    id: element.id,
                    applicationId: element.applicationId,
                    name: element.name,
                    testDescription: element.testDescription,
                    order: element.order
                ))
            }
            
            DispatchQueue.main.async {
                onAppsReady(testScenariosList)
            }
        }
    }
    
}
