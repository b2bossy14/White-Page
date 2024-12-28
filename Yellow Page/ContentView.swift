// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var families: [Family] = []       // Loaded data
    @State private var searchText: String = ""      // Search input
    @State private var isLoading: Bool = true       // Loading indicator state
    @State private var showMenu = false             // Tracks the visibility of the SideMenu
    @State private var selectedOption: SideMenuOptionModel? = nil // Tracks the selected menu option

    var filteredFamilies: [Family] {
        // Filter and sort families based on searchText
        let sortedFamilies = families.sorted { $0.familyLastName.lowercased() < $1.familyLastName.lowercased() }

        if searchText.isEmpty {
            return sortedFamilies
        } else {
            return sortedFamilies.filter { family in
                let searchLowercased = searchText.lowercased()
                return family.familyLastName.lowercased().contains(searchLowercased) ||
                       family.fatherName.lowercased().contains(searchLowercased) ||
                       family.motherName.lowercased().contains(searchLowercased) ||
                       family.children.contains { $0.name.lowercased().contains(searchLowercased) }
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Main Content
                LinearGradient(
                    gradient: Gradient(colors: [.white, .blue.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    // Logo and Title
                    VStack(spacing: 10) {
                        Image("Image") // Replace with an actual image asset name
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)

                        Text("Kapaun Directory")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 20)

                    // Search Bar
                    TextField("Search families", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)

                    // Loading or Directory List
                    if isLoading {
                        ProgressView("Loading Directory...")
                            .padding()
                    } else if !families.isEmpty {
                        // Family List
                        List(filteredFamilies) { family in
                            NavigationLink(destination: FamilyDetailView(family: family)) {
                                HStack {
                                    Text("[\(family.familyLastName)], \(family.fatherName), \(family.motherName)")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .padding(.vertical, 7)
                            }
                            .listRowBackground(Color.white)
                        }
                        .listStyle(InsetGroupedListStyle())
                        .scrollContentBackground(.hidden) // Allow gradient to show behind list
                    } else {
                        Text("No directory data available.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .onAppear(perform: loadDirectoryWithDelay)

                // Side Menu
                SideMenu(isShowing: $showMenu, selectedOption: $selectedOption)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 25))
                            .font(.title)
                            .foregroundColor(.black)
                    })
                }
            }
            .navigationDestination(for: SideMenuOptionModel.self) { option in
                switch option {
                case .settings:
                     SettingsView()
                case .search:
                    // Optional: Navigate to the main directory screen or handle as needed.
                    EmptyView()
                }
            }
        }
    }

    // Simulate loading delay
    func loadDirectoryWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.families = loadDirectory()
            self.isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
