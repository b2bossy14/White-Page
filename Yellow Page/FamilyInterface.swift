//
//  FamilyInterface.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 12/26/24.
//
import SwiftUI


struct FamilyDetailView: View {
    var family: Family
    @AppStorage("showFatherContact") var showFatherContact: Bool = true
    @AppStorage("showMotherContact") var showMotherContact: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(family.familyLastName) Family")
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
                    Text("Father's contact info is not available.")
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
                    Text("Mother's contact info is not available.")
                }
                
                // Address Link
                if let mapsURL = makeMapsURL(address: family.address) {
                    Link("Address: \(family.address)", destination: mapsURL)
                        .padding(.vertical)
                }
                
                // Children Information
                if !family.children.isEmpty {
                    Text("Children:")
                        .font(.headline)
                        .padding(.top)
                    
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
            .navigationTitle(family.familyLastName)
        }
    }
}
