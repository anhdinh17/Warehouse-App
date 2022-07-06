//
//  AuthManager.swift
//  Warehouse App
//
//  Created by Anh Dinh on 6/12/22.
//

import Foundation
import FirebaseAuth
import UIKit
import AVFoundation

class AuthManager {
    static let shared = AuthManager()
    private init(){}
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
//MARK: - Functions
    // Use email and password to sign in
    public func signIn(email: String,
                       password:String,
                       completion: @escaping(Result<String,Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard result != nil, error == nil else {
                if let error = error {
                    print("Error in AuthManager for Sign In")
                    completion(.failure(error))
                }
                return
            }            
            completion(.success(email))
        }
    }
    
    
    // Sign up for new account
    func signUp(username: String,email: String, password: String, completion: @escaping(Bool)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](result, error) in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
        UserDefaults.standard.set(username,forKey: "username")
    }
    
    func signOut(completion: @escaping(Bool)->Void){
        do{
            try Auth.auth().signOut()
            completion(true)
        }catch{
            print("Error in AuthManager Sign out: \(error)")
            completion(false)
        }
    }
    
}
