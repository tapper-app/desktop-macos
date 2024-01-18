//
//  TapperTestCommandsDataSource.swift
//  Tapper
//
//  Created by Yazan Tarifi on 18/01/2024.
//

import Foundation
import RealmSwift

public final class TapperTestCommandsDataSource {
    
    public func onInsertCommandEntity(entity: RealmTestCommandEntity) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(entity)
            }
        }
    }
    
    public func onDeleteCommand(id: String) {
        let realm = try! Realm()
        try! realm.write {
            let commandToDelete = realm
                .objects(RealmTestCommandEntity.self)
                .filter("id == %@", id)
                .first
            
            if commandToDelete != nil {
                realm.delete(commandToDelete!)
            }
        }
    }
    
    public func getCommandsByTestCaseId(id: String, onAppsReady: @escaping ([TapperTestCommandEntity]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let sortedEntities = realm
                .objects(RealmTestCommandEntity.self)
                .filter("testScenarioId == %@", id)
                .sorted(byKeyPath: "order", ascending: true)
            
            var testScenariosList: [TapperTestCommandEntity] = []
            
            sortedEntities.forEach { element in
                testScenariosList.append(TapperTestCommandEntity(
                    id: element.id,
                    name: element.name,
                    command: element.command, testScenarioId: id,
                    order: element.order
                ))
            }
            
            DispatchQueue.main.async {
                onAppsReady(testScenariosList)
            }
        }
    }
}
