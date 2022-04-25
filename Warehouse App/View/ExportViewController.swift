//
//  ExportViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/11/22.
//

import Foundation
import UIKit
import DropDown

class ExportViewController: UIViewController {
//MARK: - Properties
    private var sendLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.shared.sendLabel
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var receiverTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Receiver"
        textField.backgroundColor = .secondarySystemBackground
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private var itemQuantityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter The Quantity"
        textField.keyboardType = .numberPad
        textField.backgroundColor = .secondarySystemBackground
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        return textField
    }()

    lazy var dropDownView: DropDownView = {
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight: CGFloat = navigationController?.navigationBar.bounds.height ?? 0
        let view = DropDownView(frame: CGRect(x: 10, y: statusBarHeight + navBarHeight + 100, width: UIScreen.main.bounds.width - 20, height: 50))
        view.labelSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 50)
        view.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDropDownView))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.setTitle("SEND", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action:#selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
    let dropdown = DropDown()
    var arrayOfItem: [[String : Any]] = []
//MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupDropDown()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sendLabel.sizeToFit()
        sendLabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 10, width: sendLabel.frame.width, height: sendLabel.frame.height)
        receiverTextField.frame = CGRect(x: 10, y: sendLabel.frame.origin.y + sendLabel.frame.height + 10, width: view.frame.width - 20, height: 50)
        itemQuantityTextField.frame = CGRect(x: 10, y: receiverTextField.frame.origin.y + receiverTextField.frame.height + 70 , width: view.frame.width - 20, height: 50)
        sendButton.frame = CGRect(x: 10, y: itemQuantityTextField.frame.origin.y + itemQuantityTextField.frame.height + 10, width: view.frame.width - 20, height: 50)
    }
    
//MARK: - Functions
    func setupUI(){
        view.addSubview(sendLabel)
        view.addSubview(receiverTextField)
        view.addSubview(itemQuantityTextField)
        view.addSubview(dropDownView)
        view.addSubview(sendButton)
        // Add tool bar on top of keyboard
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        toolbar.items = [
            // Add space between items on toolbar, if we only have 1 item, then it's pushed all the way to the right.
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        ]
        // Add tool bar to textFields
        receiverTextField.inputAccessoryView = toolbar
        itemQuantityTextField.inputAccessoryView = toolbar
    }
    
    @objc func didTapDoneButton(){
        receiverTextField.resignFirstResponder()
        itemQuantityTextField.resignFirstResponder()
    }
    
    func setupDropDown(){
        dropdown.anchorView = dropDownView
        dropdown.backgroundColor = .secondarySystemBackground
        dropdown.layer.cornerRadius = 8
        
        DatabaseManager.shared.readItems { [weak self] (values, id) in
            guard let values = values, let id = id else {
                let alert = UIAlertController(title: "Error", message: "Unable to load items", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self?.present(alert,animated: true)
                return
            }
            // append items to dropdown array
            self?.dropdown.dataSource.append(values["Item"] as! String)
            self?.arrayOfItem.append(values)
        }

        // Top of drop down will be below the anchorView
        dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
        // Action triggered on selection
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            dropDownView.itemLabel.text = item
            dropDownView.itemLabel.font = .systemFont(ofSize: 16, weight: .regular)
            dropDownView.itemLabel.textColor = .black
        }
    }
    
    @objc func didTapDropDownView(){
        dropdown.show()
    }
    
    @objc func didTapSendButton(){
        if !receiverTextField.text!.isEmpty && !dropDownView.itemLabel.text!.isEmpty && !itemQuantityTextField.text!.isEmpty{
            guard let receiverName = receiverTextField.text, let item = dropDownView.itemLabel.text, let itemQuantity = itemQuantityTextField.text else {
                return
            }

            Utils.shared.checkIfItemIsEnoughToSend(arrayOfItems: arrayOfItem, item: item, quantity: Int(itemQuantity) ?? 0) { success in
                if success{
                    DatabaseManager.shared.storeTransaction(receiverName: receiverName, item: item, quantity: Int(itemQuantity) ?? 0) { success in
                        if success {
                            Utils.shared.popUpAlertWithSuccessAndDismiss(viewController: self, alertMessage: Constant.shared.successfullySendingItemToReceiver)
                        } else {
                            Utils.shared.popUpAlertWithErrorAndDismiss(viewController: self, alertMessage: Constant.shared.errorSendingItemToReceiver)
                        }
                    }
                } else {
                    Utils.shared.popUpAlertWithErrorAndDismiss(viewController: self, alertMessage: Constant.shared.notEnoughItemToSend)
                }
            }
            
            itemQuantityTextField.text = nil
            receiverTextField.text = nil
            dropDownView.itemLabel.text  = Constant.shared.selectItemToSend
            Utils.shared.setupPlaceHolderForLabel(label: dropDownView.itemLabel)
        }else {
            let alert = UIAlertController(title: "Warning", message: Constant.shared.warningMessageOfEmptyFields, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
