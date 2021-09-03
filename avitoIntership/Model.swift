//
//  Model.swift
//  avitoIntership
//
//  Created by Janusz on 9/2/21.
//

import Foundation


//let empty = try? newJSONDecoder().decode(Empty.self, from: jsonData)

// MARK: - Model
struct model: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
