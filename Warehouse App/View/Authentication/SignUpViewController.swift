//
//  SignUpViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 6/11/22.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User Name"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let signUpButton = AuthButton(type: .signUp, title: nil)
    
//MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameTextField.frame = CGRect(x: 15, y: view.safeAreaInsets.top + 10, width: view.frame.width - 30, height: 55)
        emailTextField.frame = CGRect(x: 15, y: usernameTextField.frame.origin.y + usernameTextField.frame.height + 10, width: view.frame.width - 30, height: 55)
        passwordTextField.frame = CGRect(x: 15, y: emailTextField.frame.origin.y + emailTextField.frame.height + 10, width: view.frame.width - 30, height: 55)
        signUpButton.frame = CGRect(x: 15, y: passwordTextField.frame.origin.y + passwordTextField.frame.height + 30, width: view.frame.width - 30, height: 55)
    }

//MARK: - Function
    func setupUI(){
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
    }
    
    func configureButtons(){
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    func configureFields(){
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Add a toolbar on top of keyboard
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        // Add tool bar to textFields
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        usernameTextField.inputAccessoryView = toolbar
    }
    
    @objc func didTapSignUp(){
        didTapKeyboardDone()
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 8 else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please make sure to use valid username, email, password to create your account.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
            return
        }
        AuthManager.shared.signUp(username: username, email: email, password: password) { [weak self] result in
            if result{
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: true)
            }else {
                print("Cannot Sign up")
            }
        }
    }
    
    @objc func didTapKeyboardDone(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
    }
}
