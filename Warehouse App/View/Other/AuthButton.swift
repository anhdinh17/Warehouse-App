//
//  AuthButton.swift
//  Warehouse App
//
//  Created by Anh Dinh on 6/11/22.
//

import Foundation
import UIKit

class AuthButton: UIButton {
    enum ButtonType {
        case signIn
        case signUp
        case signOut
        case plain
        var title: String {
            switch self {
            case .signIn:
                return "Sign In"
            case .signUp:
                return "Sign Up"
            case .signOut:
                return "Sign Out"
            case .plain:
                return "-"
            }
        }
    }
    
    let type: ButtonType
    
    init(type: ButtonType, title: String?){
        self.type = type
        super.init(frame: .zero)
        if let title = title {
            setTitle(title, for: .normal)
        }
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        if type != .plain {
            setTitle(type.title, for: .normal)
        }
        switch type {
        case .signIn:
            backgroundColor = .systemBlue
            layer.masksToBounds = true
            layer.cornerRadius = 5
        case .signUp:
            backgroundColor = .systemGreen
            layer.masksToBounds = true
            layer.cornerRadius = 5
        case .signOut:
            backgroundColor = .systemRed
            layer.masksToBounds = true
            layer.cornerRadius = 5
        case .plain:
            setTitleColor(.link
                          , for: .normal)
        default: break
        }
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }
}
