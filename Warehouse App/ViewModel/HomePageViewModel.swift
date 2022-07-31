//
//  HomePageViewModel.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/12/22.
//

import Foundation

class HomePageViewModel: NSObject {
    // "item" để store từng thằng dictionary mà .readItems API trả về (snapshot.values)
    var item: [String:Any]
    var itemID: String
    
    init(item: [String:Any], itemID: String){
        self.item = item
        self.itemID = itemID
        super.init()
    }
}
