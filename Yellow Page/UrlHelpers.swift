//
//  UrlHelpers.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 12/26/24.
//
import SwiftUI
import Foundation

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

func makeMapsURL(address: String) -> URL? {
    let baseUrl = "http://maps.apple.com/?q="
    if let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        let urlString = "\(baseUrl)\(encodedAddress)"
        return URL(string: urlString)
    } else {
        return nil
    }
}
