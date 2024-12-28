//
//  ContentView1.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 11/21/24.
//
/*
import SwiftUI

struct ContentView1 : View {
    @State private var showMenu = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello World!")
                }
                SideMenu(isShowing: $showMenu)
                
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    })
                }
            }
            .padding()
        }
    }
}


#Preview {
    ContentView1()
}
*/
