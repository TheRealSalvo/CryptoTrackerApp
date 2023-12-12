//
//  Favorites.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 12/12/23.
//

import Foundation
import SwiftData

@Model
class FavoriteCoin{
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
}
