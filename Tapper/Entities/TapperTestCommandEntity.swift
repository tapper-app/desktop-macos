//
//  TapperTestCommandEntity.swift
//  Tapper
//
//  Created by Yazan Tarifi on 18/01/2024.
//

import Foundation

public struct TapperTestCommandEntity: Hashable, Identifiable {
    public var id: String
    var name: String = ""
    var command: String = ""
    var testScenarioId: String = ""
    var order: Int32 = 0
}
