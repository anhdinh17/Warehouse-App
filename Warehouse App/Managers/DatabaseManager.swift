//
//  DatabaseManager.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/10/22.
//

import Foundation
import UIKit
import FirebaseDatabase

final class DatabaseManager {
    public static let shared = DatabaseManager()
    private let database = Database.database().reference()
    private init() {}
    
    public func insertItems(item: String, quantity: Int, completion: @escaping (Bool)->Void){
        database.child("Items").observeSingleEvent(of: .value) { [weak self] snapshot in
            // check if there's a node of "Items" and its value
            guard var itemsDictionary = snapshot.value as? [String:Int] else {
                // Nếu ko có "Items", tạo node "Items"
                self?.database.child("Items").setValue(
                    [
                        item: quantity
                    ]
                ){error,_ in
                    guard error == nil else {
                        // trả về false, case này là lần đầu tạo "Items" node
                        completion(false)
                        return
                    }
                    // Trả về true nếu tạo thành công "Items"
                    completion(true)
                }
                return
            }
            itemsDictionary[item] = quantity
            self?.database.child("Items").setValue(itemsDictionary){ error,_ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
}
