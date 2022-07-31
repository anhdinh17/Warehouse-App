//
//  ViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/7/22.
//

import UIKit

class ImportViewController: UIViewController, UITextFieldDelegate {
    
    private let addNewItemLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.shared.addNewItem
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let itemTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Enter your item"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Quantity"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let pricePerUnitTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Price Per Unit"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD ITEM", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addNewItemLabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 20, width: view.frame.width, height: 20)
        itemTextField.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 45, width: view.frame.width - 20, height: 50)
        quantityTextField.frame = CGRect(x: 10, y: itemTextField.frame.origin.y + itemTextField.frame.height + 10, width: view.frame.width - 20, height: 50)
        pricePerUnitTextField.frame = CGRect(x: 10, y: quantityTextField.frame.origin.y + quantityTextField.frame.height + 10, width: view.frame.width - 20, height: 50)
        addButton.frame = CGRect(x: 10, y: pricePerUnitTextField.frame.origin.y + pricePerUnitTextField.frame.height + 10, width: view.frame.size.width - 20, height: 50)

    }
    
    //=======================================================================================================
    //MARK: FUNCTIONS
    //=======================================================================================================
    func setUpUI(){
        view.addSubview(addNewItemLabel)
        view.addSubview(itemTextField)
        view.addSubview(quantityTextField)
        view.addSubview(addButton)
        view.addSubview(pricePerUnitTextField)
        itemTextField.delegate = self
        quantityTextField.delegate = self
        
        // Add tool bar on top of keyboard
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        toolbar.items = [
            // Add space between items on toolbar, if we only have 1 item, then it's pushed all the way to the right.
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        ]
        // Add tool bar to textFields
        itemTextField.inputAccessoryView = toolbar
        quantityTextField.inputAccessoryView = toolbar
    }
    
    @objc func didTapAddButton(){
        guard let item = itemTextField.text, let itemQty = Int(quantityTextField.text ?? ""), let pricePerUnit = Int(pricePerUnitTextField.text ?? ""), !item.isEmpty, itemQty != 0, pricePerUnit != 0 else {
            return
        }
        DatabaseManager.shared.insertItems(item: item, quantity: itemQty, pricePerUnit: pricePerUnit) { [weak self] success in
            if success {
                // Notification so that in HomeViewVC, tableView is updated
                NotificationCenter.default.post(name: NSNotification.Name("addNewItem"), object: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Cannot insert items into store, please try again later", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                self?.present(alert, animated: true)
            }
        }
        itemTextField.text = nil
        quantityTextField.text = nil
        pricePerUnitTextField.text = nil
    }
    
    @objc func didTapDoneButton(){
        itemTextField.resignFirstResponder()
        quantityTextField.resignFirstResponder()
    }
}

extension ImportViewController {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
