//
//  TabBarViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/11/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }

    //=======================================================================================================
    //MARK: Functions
    //=======================================================================================================
    private func setUpControllers(){
        let home = HomeViewController()
        let importItems = ImportViewController()
        let updateItems = UpdateViewController()
        let exportItems = ExportViewController()
        home.title = "Home Page"
        importItems.title = "Import Items"
        updateItems.title = "Update Items"
        exportItems.title = "Export Items"
        // set nav bar for each tab
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: importItems)
        let nav3 = UINavigationController(rootViewController: updateItems)
        let nav4 = UINavigationController(rootViewController: exportItems)
        // Set image for each tab
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "wrench.and.screwdriver"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "airplane"), tag: 4)
        // put tab bars into order
        setViewControllers([nav1,nav2,nav3,nav4], animated: false)
    }
}
