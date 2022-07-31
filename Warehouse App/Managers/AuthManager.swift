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
            
            // Get the username corresponding to sign-in email
            DatabaseManager.shared.getUsername(email: email) { [weak self] username in
                if let username = username {
                    UserDefaults.standard.set(username,forKey: "username")
                    completion(.success(username))
                }
            }
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
        
        // add username and email to Realtime Database
        DatabaseManager.shared.addEmailToRealtimeDatabase(email: email, username: username, completion: completion)
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
