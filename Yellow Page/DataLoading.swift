//
//  DataLoading.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 12/26/24.
//

import Foundation
import SwiftUI

func loadDirectory() -> [Family] {
    guard let url = Bundle.main.url(forResource: "output", withExtension: "json") else {
        print("JSON file not found")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let directory = try decoder.decode([Family].self, from: data)
        return directory
    } catch {
        print("Error loading directory: \(error)")
        return []
    }
}
