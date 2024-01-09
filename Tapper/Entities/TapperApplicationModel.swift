//
//  TapperApplicationModel.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import Foundation

public struct TapperApplicationModel: Identifiable, Hashable {
    public var id: String
    public var image: String
    public var description: String
    public var packageName: String
    public var isSelected: Bool
}
