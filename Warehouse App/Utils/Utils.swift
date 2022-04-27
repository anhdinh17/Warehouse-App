//
//  Utils.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/22/22.
//

import Foundation
import UIKit

class Utils: NSObject {
    static let shared: Utils = Utils()
    
    private override init(){
        
    }
    
    func setupPlaceHolderForLabel(label: UILabel){
        label.font = UIFont(name: "Roboto-Bold", size: 17)
        label.textColor = .lightGray
    }
    
    func popUpAlertWithSuccessAndDismiss(viewController: UIViewController, alertMessage: String){
        let alert = UIAlertController(title: "Update", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        viewController.present(alert,animated: true)
    }
    
    func popUpAlertWithErrorAndDismiss(viewController: UIViewController, alertMessage: String){
        let alert = UIAlertController(title: "Warning", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        viewController.present(alert,animated: true)
    }
    
    public func checkIfItemIsEnoughToSend(arrayOfItems: [[String:Any]],item: String, quantity: Int,completion: @escaping (Bool)->Void){
        // Moi eachItem la 1 dictionary ["Item": String, "Quantity": Int]
        for eachItem in arrayOfItems {
            if eachItem["Item"] as! String == item && eachItem["Quantity"] as! Int >= quantity{
                print("Item has enough quantity to send")
                completion(true)
            } else if (eachItem["Item"] as! String == item && (eachItem["Quantity"] as! Int) < quantity) {
                print("Item doens't have enough quantity to send")
                completion(false)
            }
        }
    }
    
    public func getCurrentDateAndTime() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let convertedDate = dateFormatter.string(from: today)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: today)
        let minute = calendar.component(.minute, from: today)
        let second = calendar.component(.second, from: today)
        return "\(convertedDate) \(hour):\(minute):\(second)"
    }
    
}
