//
//  HomePageViewModel.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/12/22.
//

import Foundation

class HomePageViewModel: NSObject {
    var item: [String:Any]
    var dictionaryArray = [[String:Int]]()
    
    init(item: [String:Any]){
        self.item = item
        super.init()
    }
}
