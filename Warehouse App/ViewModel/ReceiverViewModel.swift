//
//  ReceiverViewModel.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/25/22.
//

import Foundation

class ReceiverViewModel: NSObject {
    var transactionInfo: [String:Any]

    init(transactionInfo: [String:Any]){
        self.transactionInfo = transactionInfo
        super.init()
    }
}
