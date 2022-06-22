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
        let view = DropDownView(frame: .zero)
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
    
    private let receiverTableView: UITableView = {
        let table = UITableView()
        table.register(ReceiverTableViewCell.self, forCellReuseIdentifier: ReceiverTableViewCell.identifier)
        return table
    }()
    
    let dropdown = DropDown()
    var arrayOfItem: [[String : Any]] = []
    var receiverArray: [ReceiverViewModel] = []
    
//MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupDropDown()
        let isFirstTimeLoginExport = !UserDefaults.standard.bool(forKey: "firstTime")
        guard isFirstTimeLoginExport else {
            // only fetch data if it's not the first time going to this screen
            fetchDataOfReceiver()
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sendLabel.sizeToFit()
        sendLabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 10, width: sendLabel.frame.width, height: sendLabel.frame.height)
        receiverTextField.frame = CGRect(x: 10, y: sendLabel.frame.origin.y + sendLabel.frame.height + 10, width: view.frame.width - 20, height: 50)
        dropDownView.frame = CGRect(x: 10, y: receiverTextField.frame.origin.y + receiverTextField.frame.height + 10, width: view.frame.width - 20, height: 50)
        itemQuantityTextField.frame = CGRect(x: 10, y: dropDownView.frame.origin.y + dropDownView.frame.height + 10 , width: view.frame.width - 20, height: 50)
        sendButton.frame = CGRect(x: 10, y: itemQuantityTextField.frame.origin.y + itemQuantityTextField.frame.height + 10, width: view.frame.width - 20, height: 50)
        receiverTableView.frame = CGRect(x: 10, y: sendButton.frame.origin.y + sendButton.frame.height + 25, width: view.frame.width - 20, height: 0.55*view.frame.height - (tabBarController?.tabBar.frame.size.height ?? 0))
    }
    
//MARK: - Functions
    func setupUI(){
        view.addSubview(sendLabel)
        view.addSubview(receiverTextField)
        view.addSubview(itemQuantityTextField)
        view.addSubview(dropDownView)
        view.addSubview(sendButton)
        view.addSubview(receiverTableView)
        receiverTableView.delegate = self
        receiverTableView.dataSource = self 
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

            Utils.shared.checkIfItemIsEnoughToSend(arrayOfItems: arrayOfItem, item: item, quantity: Int(itemQuantity) ?? 0) { [weak self] success in
                if success{
                    var date = Utils.shared.getCurrentDateAndTime()
                    DatabaseManager.shared.storeTransaction(receiverName: receiverName, item: item, quantity: Int(itemQuantity) ?? 0,date: date) { [weak self] success in
                        if success {
                            // Create an alert to tell users that item has been sent successfully and update tableView with transaction info
                            let alert = UIAlertController(title: "Congratulation", message: "Your item has been sent successfully", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Dismiss", style: .default) { _ in
                                
                                // Set bool value to true to handle first time log in scenario
                                UserDefaults.standard.set(true,forKey: "firstTime")
                                
                                DispatchQueue.main.async {
                                    //add this transaction item as dictionary [String:Any] to array and reload tableView
                                    self?.receiverArray.append(ReceiverViewModel(transactionInfo: [receiverName:["Date":date,"Item":item,"Quantity":Int(itemQuantity)]]))
                                    self?.receiverTableView.reloadData()
                                }
                            }
                            alert.addAction(action)
                            self?.present(alert,animated: true)
                        } else {
                            Utils.shared.popUpAlertWithErrorAndDismiss(viewController: self!, alertMessage: Constant.shared.errorSendingItemToReceiver)
                        }
                    }
                } else {
                    Utils.shared.popUpAlertWithErrorAndDismiss(viewController: self!, alertMessage: Constant.shared.notEnoughItemToSend)
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
    
    func fetchDataOfReceiver(){
        DatabaseManager.shared.readDataFromReceivers { [weak self] values in
            // values la 1 thang big dictionary, chua toan bo nhung gi under "Receivers" node
            // lay tung thang (key,value) trong cai big dictionary nay de store vao array
            for (key,value) in values {
                self?.receiverArray.append(ReceiverViewModel(transactionInfo: [key:value]))
            }
            DispatchQueue.main.async {
                self?.receiverTableView.reloadData()
            }
        }
    }
}

//MARK: - Extension TableView
extension ExportViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiverArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceiverTableViewCell.identifier, for: indexPath) as? ReceiverTableViewCell else {
            return UITableViewCell()
        }
        let model = receiverArray[indexPath.row]
        cell.configure(viewModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
