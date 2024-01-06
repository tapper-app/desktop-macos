//
//  TapperApplicationsDataSource.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation
import RealmSwift

public class TapperApplicationsDataSource {
    
    public func onInsertApplication(app: TapperApplicationModel) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(RealmApplicationEntity(
                    name: app.id,
                    packageName: app.packageName, description: app.description,
                    insertedTimestamp: TapperUtils.shared.getCurrentTimestamp()
                ))
            }
        }
    }
    
    public func validateApplicationExists(id: String, isExists: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let objectWithID = realm.object(ofType: RealmApplicationEntity.self, forPrimaryKey: id)
            DispatchQueue.main.async {
                isExists(objectWithID != nil)
            }
        }
    }
    
    public func getRegisteredApplications(onAppsReady: @escaping ([TapperApplicationModel]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            let sortedEntities = realm.objects(RealmApplicationEntity.self).sorted(byKeyPath: "insertedTimestamp", ascending: false)
            var applications: [TapperApplicationModel] = []
            
            sortedEntities.forEach { element in
                applications.append(TapperApplicationModel(
                    id: element.id,
                    image: "",
                    description: element.desc,
                    packageName: element.packageName
                ))
            }
            
            DispatchQueue.main.async {
                onAppsReady(applications)
            }
        }
    }
    
}
