//
//  Constant.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/12/22.
//

import Foundation

struct Constant {
    static var shared = Constant()
    let itemLabel = "Item: "
    let qtyLabel = "Quantity: "
    let originalPricePerItem = "Original Price: "
    let currentItemsInStore = "Current Items In Store:"
    let addNewItem = "Add New Item"
    let sendLabel = "Send To"
    let selectItemToSend = "Select Item To Send"
    let warningMessageOfEmptyFields = "You must enter all the fields before sending the item."
    let successfullySendingItemToReceiver = "Successfully sending item to receiver."
    let errorSendingItemToReceiver = "Unable to send the selected item to receiver."
    let notEnoughItemToSend = "The item you selected doesn't have enough quantity left in store."
    let receiverLabel = "Receiver: "
    let sentItemLabel = "Sent Item: "
    let quantityOfSentItemLabel = "Quantity: "
    let dateSentItemLabel = "Date: "
    let noItemMessageLabel = "You don't have any items in store."
}
