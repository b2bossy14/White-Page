//
//  SideMenu.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 11/21/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    @Binding var selectedOption: SideMenuOptionModel? // Add this binding

    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {isShowing.toggle()}
                HStack {
                    VStack(alignment: .leading, spacing: 26) {
                        SideMenuHeaderView()
                        
                        VStack {
                            ForEach(SideMenuOptionModel.allCases) { option in
                                Button(action: {
                                    if option == .search {
                                        isShowing = false
                                    } else {
                                        selectedOption = option
                                        print("Selected Option: \(option)")
                                        isShowing = false // Close the side menu
                                    }
                                    
                                }, label: {
                                    SideMenuRowView(option: option, selectedOption: $selectedOption)
                                })
                            }
                        }
                                                                
                        
                        
                        Spacer()
                        
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    
                    Spacer()
                }
            }
        }
        .transition(.move(edge: .leading))
        .animation(.spring, value: isShowing)
    }
}


