//
//  TapperTestScenarioModel.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import Foundation

public struct TapperTestScenarioModel: Hashable, Identifiable {
    public var id: String
    public var applicationId: String
    public var name: String
    public var testDescription: String
    public var order: Int
}
