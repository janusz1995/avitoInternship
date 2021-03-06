import Foundation

// MARK: - Model
struct model: Codable {
    var company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    var employees: [Employee]
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
