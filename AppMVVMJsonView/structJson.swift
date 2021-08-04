//
//  structJson.swift
//  AppMVVMJsonView
//
//  Created by Admin on 29.07.2021.
//

import Foundation




struct jsonStruct: Codable {
    let data: [Datum]
    let view: [String]
  
}

// MARK: - Datum
struct Datum: Codable {
    let name: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?
    
    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}


