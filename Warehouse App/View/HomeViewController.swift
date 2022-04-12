//
//  HomeViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/11/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    lazy private var collectionView: UICollectionView = {
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        collectionView.backgroundColor = .cyan
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navBarHeight = navigationController?.navigationBar.bounds.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        collectionView.frame = CGRect(x: 0,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.width,
                                      height: view.frame.height - navBarHeight - statusBarHeight - (self.tabBarController?.tabBar.frame.size.height)! ?? 0)
    }

    //=======================================================================================================
    //MARK: Functions
    //=======================================================================================================
    func setUpUI(){
        view.addSubview(collectionView)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as? HomePageCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}
