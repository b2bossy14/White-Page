//
//  SideMenuHeaderView.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 11/21/24.
//

import SwiftUI


struct SideMenuHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Bryson Toubassi")
                    .font(.subheadline)
                Text("Parent")
                    .font(.footnote)
                    .tint(.gray)
            }
        }
    }
}

#Preview {
    SideMenuHeaderView()
}
