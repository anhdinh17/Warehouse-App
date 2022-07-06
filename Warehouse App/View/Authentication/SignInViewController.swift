//
//  SignInViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 6/11/22.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var completion: (()->Void)?
    
//MARK: - Properties
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Email Address"
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var signInButton = AuthButton(type: .signIn, title: nil)
    private let forgotPassword = AuthButton(type: .plain, title: "Forgot Password")
    private let createNewAccount = AuthButton(type: .plain, title: "New User? Create An Account")
    
//MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        view.backgroundColor = .systemBackground
        setupUI()
        setupButtonActions()
        configureFields()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextField.frame = CGRect(x: 15, y: view.safeAreaInsets.top + 10, width: view.frame.width - 30, height: 50)
        passwordTextField.frame = CGRect(x: 15, y: emailTextField.frame.origin.y + emailTextField.frame.height + 10, width: view.frame.width - 30, height: 50)
        signInButton.frame = CGRect(x: 15, y: passwordTextField.frame.origin.y + passwordTextField.frame.height + 30, width: view.frame.width - 30, height: 50)
        forgotPassword.frame = CGRect(x: 15, y: signInButton.frame.origin.y + signInButton.frame.height + 40, width: view.frame.width - 30, height: 50)
        createNewAccount.frame = CGRect(x: 15, y: forgotPassword.frame.origin.y + forgotPassword.frame.height + 20, width: view.frame.width - 30, height: 50)
    }

//MARK: - Functions
    func setupUI(){
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(forgotPassword)
        view.addSubview(createNewAccount)
    }
    
    func configureFields(){
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
    }
    
    func setupButtonActions(){
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        forgotPassword.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        createNewAccount.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    @objc func didTapSignIn(){
        // Condition for text fields
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 8 else {
            let alert = UIAlertController(title: "Invalid Email/Password", message: "Please enter valid email or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in
                
            }))
            present(alert,animated: true)
            return
        }
        AuthManager.shared.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let email):
                    print("You have signed in with: \(email)")
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc,animated: true)
                case .failure(let error):
                    print("Error signing in")
                    print(error)
                default: break
                }
            }
        }
    }
    
    @objc func didTapForgotPassword(){
        print("Forgot Password is tapped")
    }
    
    @objc func didTapCreateAccount(){
        print("Create account is tapped")
        let vc = SignUpViewController()
        vc.title = "Sign Up"
//        navigationController?.pushViewController(vc, animated: true)
        present(vc,animated: true)
    }
    
    @objc func didTapKeyboardDone(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

}
