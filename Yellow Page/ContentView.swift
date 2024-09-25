// MARK: - Imports
//Framework to build and manage views, layouts, naviagtion, and user interactions
//Things like buttons text styles, forms, etc.
import SwiftUI

//Foundation framework to handle data structures such as Family and Child models
//Also provides the framework to decode the JSON file that contains family info
import Foundation

// MARK: - Models

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
        // Children
        case child1Name = "Child 1 Name"
        case child1Grade = "Child 1 Grade"
        case child1Age = "Child 1 Age"
        case child2Name = "Child 2 Name"
        case child2Grade = "Child 2 Grade"
        case child2Age = "Child 2 Age"
        case child3Name = "Child 3 Name"
        case child3Grade = "Child 3 Grade"
        case child3Age = "Child 3 Age"
        case child4Name = "Child 4 Name"
        case child4Grade = "Child 4 Grade"
        case child4Age = "Child 4 Age"
        case child5Name = "Child 5 Name"
        case child5Grade = "Child 5 Grade"
        case child5Age = "Child 5 Age"
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

        // Load children
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
               !name.trimmingCharacters(in: .whitespaces).isEmpty {
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

// MARK: - Data Loading Function

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

// MARK: - Views

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("Settings")) {
                Toggle("Show Father's Contact Info", isOn: .constant(true))
                Toggle("Show Mother's Contact Info", isOn: .constant(true))
            }
        }
        .navigationTitle("Settings")
    }
}


struct ContentView: View {
    @State private var families: [Family] = []
    @State private var searchText: String = ""
    @State private var isLoading: Bool = true  // Tracks loading state

    var filteredFamilies: [Family] {

        // Sort families alphabetically by last name
        let sortedFamilies = families.sorted { $0.familyLastName.lowercased() < $1.familyLastName.lowercased() }

        // Filter based on search text
        if searchText.isEmpty {
            return sortedFamilies
        } else {
            return sortedFamilies.filter { family in
                let searchLowercased = searchText.lowercased()
                return family.familyLastName.lowercased().contains(searchLowercased) ||
                       family.fatherName.lowercased().contains(searchLowercased) ||
                       family.motherName.lowercased().contains(searchLowercased) ||
                       family.children.contains(where: { $0.name.lowercased().contains(searchLowercased) })
            }
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Yellow Page")
                    .font(.largeTitle)
                    .padding()

                TextField("Search families", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if isLoading {
                    ProgressView("Loading Directory...")  // Loading spinner with message
                        .padding()
                } else {
                    if !families.isEmpty {
                        List(filteredFamilies) { family in
                            NavigationLink(destination: FamilyDetailView(family: family)) {
                                let fatherFirstName = family.fatherName.components(separatedBy: " ").first ?? ""
                                let motherFirstName = family.motherName.components(separatedBy: " ").first ?? ""

                                Text("[\(family.familyLastName)], \(fatherFirstName), \(motherFirstName)")
                                    .font(.headline)
                            }
                        }
                    } else {
                        Text("No directory loaded.")
                            .padding()
                    }
                }
            }
            .navigationTitle("Yellow Page")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
            }
            .onAppear {
                loadDirectoryWithDelay() // Load directory with a simulated delay
            }
        }
    }

    // Simulate loading with a delay for testing purposes
    func loadDirectoryWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulating a 2-second load time
            self.families = loadDirectory()  // Replace with your real data loading function
            self.isLoading = false
        }
    }
}


    
    struct FamilyDetailView: View {
        var family: Family
        @AppStorage("showFatherContact") var showFatherContact: Bool = true
        @AppStorage("showMotherContact") var showMotherContact: Bool = true
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Family: \(family.familyLastName)")
                        .font(.title)
                    
                    if showFatherContact {
                        Group {
                            Text("Father: \(family.fatherName)")
                                .font(.headline)
                                .padding(.top)
                            if let phoneURL = makePhoneURL(phoneNumber: family.fatherMobile) {
                                Link("Mobile: \(family.fatherMobile)", destination: phoneURL)
                            }
                            if let emailURL = makeEmailURL(email: family.fatherEmail) {
                                Link("Email: \(family.fatherEmail)", destination: emailURL)
                            }
                            if let smsURL = makeSMSURL(phoneNumber: family.fatherMobile) {
                                Link("Text: \(family.fatherMobile)", destination: smsURL)
                            }
                        }
                    } else {
                        Text("Father's contact info is hidden.")
                    }
                    
                    if showMotherContact {
                        Group {
                            Text("Mother: \(family.motherName)")
                                .font(.headline)
                                .padding(.top)
                            if let phoneURL = makePhoneURL(phoneNumber: family.motherMobile) {
                                Link("Mobile: \(family.motherMobile)", destination: phoneURL)
                            }
                            if let emailURL = makeEmailURL(email: family.motherEmail) {
                                Link("Email: \(family.motherEmail)", destination: emailURL)
                            }
                            if let smsURL = makeSMSURL(phoneNumber: family.motherMobile) {
                                Link("Text: \(family.motherMobile)", destination: smsURL)
                            }
                        }
                    } else {
                        Text("Mother's contact info is hidden.")
                    }
                    
                    Text("Address: \(family.address)")
                        .padding(.vertical)
                    
                    if !family.children.isEmpty {
                        Text("Children:")
                            .font(.headline)
                        
                        ForEach(family.children) { child in
                            VStack(alignment: .leading) {
                                Text("Name: \(child.name)")
                                Text("Grade: \(child.grade)")
                                Text("Age: \(child.age)")
                            }
                            .padding(.bottom, 5)
                        }
                    } else {
                        Text("No children information available.")
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(family.familyLastName)
        }
        
        // Helper functions to create URLs safely
        func makePhoneURL(phoneNumber: String) -> URL? {
            let cleanedNumber = phoneNumber.filter("0123456789".contains)
            return URL(string: "tel://\(cleanedNumber)")
        }
        
        func makeEmailURL(email: String) -> URL? {
            let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return URL(string: "mailto:\(encodedEmail ?? "")")
        }
        
        func makeSMSURL(phoneNumber: String) -> URL? {
            let cleanedNumber = phoneNumber.filter("0123456789".contains)
            return URL(string: "sms:\(cleanedNumber)")
        }
    }
    
    // MARK: - App Entry Point
    

