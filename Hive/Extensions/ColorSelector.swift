//
//  ColorSelector.swift
//  Hive
//
//  Created by justin casler on 7/4/23.
//

import Foundation
import SwiftUI

func colorStringToSwiftUIColor(_ colorString: String) -> UIColor? {
    // Your logic to convert the string to SwiftUI Color
    switch colorString {
        case ".red": return .systemRed
        case ".blue": return .systemBlue
        case ".green": return .systemGreen
        case ".purple": return .systemPurple
        case ".brown": return .systemBrown
        case ".cyan": return .systemCyan
        case ".gray": return .systemGray
        case ".indigo": return .systemIndigo
        case ".mint": return .systemMint
        case ".orange": return .systemOrange
        case ".pink": return .systemPink
        case ".teal": return .systemTeal
        default: return nil
    }
}
