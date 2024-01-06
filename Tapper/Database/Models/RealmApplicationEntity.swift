//
//  RealmApplicationEntity.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation
import RealmSwift

public class RealmApplicationEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var desc: String = ""
    @Persisted var packageName: String = ""
    @Persisted var insertedTimestamp: Int64 = 0
    
    convenience init(name: String, packageName: String, description: String, insertedTimestamp: Int64) {
        self.init()
        self.desc = description
        self.packageName = packageName
        self.id = name
        self.insertedTimestamp = insertedTimestamp
    }
    
}
