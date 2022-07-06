//
//  TabBarViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/11/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
 //MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
        var username = UserDefaults.standard.string(forKey: "username")
        print("USERNAME: \(username)")
    }
    
    /*
     check if users already signed in or not, if users not signed in, we navigate to SignInVC. If users already signed in, TabBarVC will be shown.
     ======> Can't put this in viewDidLoad, error!!!!
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !AuthManager.shared.isSignedIn{
            let vc = SignInViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC,animated: true)
        }
    }

    //=======================================================================================================
    //MARK: Functions
    //=======================================================================================================
    
    func presentSignInIfNeeded(){
        if !AuthManager.shared.isSignedIn{
            let vc = SignInViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC,animated: true)
        }
    }
    
    private func setUpControllers(){
        let home = HomeViewController()
        let importItems = ImportViewController()
        let settingsItems = SettingsViewController()
        let exportItems = ExportViewController()
        home.title = "Home Page"
        importItems.title = "Import Items"
        settingsItems.title = "Settings"
        exportItems.title = "Export Items"
        // set nav bar for each tab
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: importItems)
        let nav3 = UINavigationController(rootViewController: exportItems)
        let nav4 = UINavigationController(rootViewController: settingsItems)
        // Set image for each tab
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "airplane"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gear"), tag: 4)
        // put tab bars into order
        setViewControllers([nav1,nav2,nav3,nav4], animated: false)
    }
}
