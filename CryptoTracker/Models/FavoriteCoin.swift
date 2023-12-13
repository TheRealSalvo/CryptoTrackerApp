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
    
 //   @Attribute(.unique) var watchlist: String

    init(name: String, watchlist: String) {
        self.name = name
      //  self.watchlist = watchlist
    }

}

//
//@Model
//class WatchlistCoin{
//  //  @Attribute(.unique) 
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
