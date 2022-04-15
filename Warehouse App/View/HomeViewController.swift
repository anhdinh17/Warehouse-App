//
//  HomeViewController.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/11/22.
//

import Foundation
import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    lazy private var collectionView: UICollectionView = {
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        //collectionView.backgroundColor = .cyan
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var homePageViewModelArray: [HomePageViewModel] = []
    var dictionaryArray = [[String:Any]]()

//MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        getDataForViewModelArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func getDataForViewModelArray(){
        DatabaseManager.shared.readItems{ [weak self] values in
            DispatchQueue.main.async { [self] in
                if let values = values {
                    // print("values in HomeVC: \(values)") ---> print dong nay ra se thay dictionary tra ve la tung thang dictionary rieng re, ko hieu sao lai tra ve kieu nay thay vi la 1 whole dictionary
                    // THOUGHT: values tra ve la tung thang dictionary, nen moi lan tra ve minh append vo array of homePageViewModel
                    self?.homePageViewModelArray.append(HomePageViewModel(item: values))
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePageViewModelArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as? HomePageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = homePageViewModelArray[indexPath.row]
        print("MODEL: \(model)")
        cell.configure(viewModel: model)
        return cell
    }

}
