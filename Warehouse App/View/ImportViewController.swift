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
        textField.placeholder = "Qty."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Item", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
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
        addNewItemLabel.frame = CGRect(x: 30, y: view.safeAreaInsets.top + 20, width: view.frame.width, height: 20)
        itemTextField.frame = CGRect(x: 30, y: view.safeAreaInsets.top + 45, width: (3/5)*(view.frame.width), height: 50)
        addButton.frame = CGRect(x: 30, y: itemTextField.frame.origin.y + itemTextField.frame.height + 10, width: view.frame.size.width - 60, height: 50)
        var quantityTextFieldWidth: CGFloat = view.frame.size.width - 60 - itemTextField.frame.width - 15
        quantityTextField.frame = CGRect(x: itemTextField.frame.origin.x + itemTextField.frame.width + 15, y: view.safeAreaInsets.top + 45, width: quantityTextFieldWidth, height: 50)

    }
    
    //=======================================================================================================
    //MARK: FUNCTIONS
    //=======================================================================================================
    func setUpUI(){
        view.addSubview(addNewItemLabel)
        view.addSubview(itemTextField)
        view.addSubview(quantityTextField)
        view.addSubview(addButton)
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
        guard let item = itemTextField.text, let itemQty = Int(quantityTextField.text ?? "") else {
            return
        }
        DatabaseManager.shared.insertItems(item: item, quantity: itemQty) { success in
            if success {
                print("Inserted data into Firebase")
            }
        }
        itemTextField.text = nil
        quantityTextField.text = nil
    }
    
    @objc func didTapDoneButton(){
        itemTextField.resignFirstResponder()
        quantityTextField.resignFirstResponder()
        NotificationCenter.default.post(name: NSNotification.Name("addNewItem"), object: nil)
    }
}

extension ImportViewController {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
