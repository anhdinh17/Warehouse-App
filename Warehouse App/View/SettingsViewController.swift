//
//  UpdateViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/11/22.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private let signOutButton = AuthButton(type: .signOut, title: nil)

//MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signOutButton.frame = CGRect(x: 15, y: view.safeAreaInsets.top + 30, width: view.frame.width - 30, height: 50)
    }
//MARK: - Functions
    func setupUI(){
        view.addSubview(signOutButton)
    }
    
    func configureButtons(){
        signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
    }
    
    @objc func didTapSignOut(){
        AuthManager.shared.signOut { [weak self] result in
            if result {
                let vc = SignInViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
                UserDefaults.standard.removeObject(forKey: "username")
            }else {
                print("Error signing out")
            }
        }
    }
}
