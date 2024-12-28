//
//  Family.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 12/26/24.
//

import Foundation
import SwiftUI

struct Family: Identifiable, Decodable {
    var id = UUID()
    var familyLastName: String
    var fatherName: String
    var fatherMobile: String
    var fatherEmail: String
    var motherName: String
    var motherMobile: String
    var motherEmail: String
    var address: String
    var children: [Child]

    enum CodingKeys: String, CodingKey {
        case familyLastName = "Family Last Name"
        case fatherName = "Father Name"
        case fatherMobile = "Father Mobile"
        case fatherEmail = "Father Email"
        case motherName = "Mother Name"
        case motherMobile = "Mother Mobile"
        case motherEmail = "Mother Email"
        case address = "Address"
        case child1Name, child1Grade, child1Age
        case child2Name, child2Grade, child2Age
        case child3Name, child3Grade, child3Age
        case child4Name, child4Grade, child4Age
        case child5Name, child5Grade, child5Age
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        familyLastName = try container.decode(String.self, forKey: .familyLastName)
        fatherName = try container.decode(String.self, forKey: .fatherName)
        fatherMobile = try container.decode(String.self, forKey: .fatherMobile)
        fatherEmail = try container.decode(String.self, forKey: .fatherEmail)
        motherName = try container.decode(String.self, forKey: .motherName)
        motherMobile = try container.decode(String.self, forKey: .motherMobile)
        motherEmail = try container.decode(String.self, forKey: .motherEmail)
        address = try container.decode(String.self, forKey: .address)

        var tempChildren: [Child] = []
        let childKeys: [(name: CodingKeys, grade: CodingKeys, age: CodingKeys)] = [
            (.child1Name, .child1Grade, .child1Age),
            (.child2Name, .child2Grade, .child2Age),
            (.child3Name, .child3Grade, .child3Age),
            (.child4Name, .child4Grade, .child4Age),
            (.child5Name, .child5Grade, .child5Age)
        ]

        for keys in childKeys {
            if let name = try? container.decode(String.self, forKey: keys.name),
               !name.isEmpty {
                let grade = try container.decode(String.self, forKey: keys.grade)
                let age = try container.decode(String.self, forKey: keys.age)
                tempChildren.append(Child(name: name, grade: grade, age: age))
            }
        }

        children = tempChildren
    }
}

struct Child: Identifiable, Codable {
    var id = UUID()
    var name: String
    var grade: String
    var age: String
}
