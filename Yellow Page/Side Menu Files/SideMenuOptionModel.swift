//
//  SideMenuOptionModel.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 12/26/24.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case search
    case settings
    
    var title: String {
        switch self {
            case .search: return "Directory"
            case .settings: return "Settings"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .search: return "magnifyingglass"
        case .settings: return "gearshape"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id : Int { rawValue }
}
