//
//  DataModel.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import Foundation
struct DataModel: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Row
struct Row: Codable {
    let title, rowDescription: String?
    let imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
