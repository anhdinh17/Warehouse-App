//
//  HomePageCollectionViewCell.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/12/22.
//

import UIKit
import Foundation
import CDAlertView

protocol HomePageCollectionViewCellDelegate: AnyObject {
    func didTapUpdateButton(cell: HomePageCollectionViewCell)
}

class HomePageCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomePageCollectionViewCell"
    weak var deleage: HomePageCollectionViewCellDelegate?
    var itemID: String?
    
    var itemLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = Constant.shared.itemLabel
        return label
    }()
    
    var itemNameLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        return label
    }()
    
    var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.shared.qtyLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        //label.backgroundColor = .yellow
        return label
    }()
    
    var itemQuantityLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .green
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.shared.originalPricePerItem
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    var itemOriginalPriceLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        return label
    }()
    
    var updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.layer.cornerRadius = 3
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        return button
    }()
    
    //=======================================================================================================
    //MARK: Initialization
    //=======================================================================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(itemLabel)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(itemQuantityLabel)
        contentView.addSubview(itemOriginalPriceLabel)
        contentView.addSubview(updateButton)
        contentView.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        itemLabel.frame = CGRect(x: 10, y: 10, width: 45, height: 35)
        itemNameLabel.frame = CGRect(x: itemLabel.frame.origin.x + itemLabel.frame.width, y: 10, width: contentView.frame.width - 10 - itemLabel.frame.width - 10, height: 35)
        quantityLabel.frame = CGRect(x: 10, y: itemLabel.frame.origin.y + itemLabel.frame.height, width: 78, height: 35)
        itemQuantityLabel.frame = CGRect(x: quantityLabel.frame.origin.x + quantityLabel.frame.width, y: itemLabel.frame.origin.y + itemLabel.frame.height, width: contentView.frame.width - 10 - quantityLabel.frame.width - 10, height: 35)
        priceLabel.frame = CGRect(x: 10, y: quantityLabel.frame.origin.y + quantityLabel.frame.height, width: 120, height: 35)
        itemOriginalPriceLabel.frame = CGRect(x: priceLabel.frame.origin.x + priceLabel.frame.width, y: quantityLabel.frame.origin.y + quantityLabel.frame.height, width: contentView.frame.width - 10 - priceLabel.frame.width - 10, height: 35)
        updateButton.sizeToFit()
        updateButton.frame = CGRect(x: contentView.frame.width * (2/3), y: (contentView.frame.height-updateButton.frame.size.height)/2, width: 100, height: updateButton.frame.height)
    }
    
//MARK: - Functions
    func configure(viewModel: HomePageViewModel){
        var stringItemName: [String] = []
        var stringItemQty: [Int] = []
        stringItemName.append(viewModel.item["Item"] as! String)
        stringItemQty.append(viewModel.item["Quantity"] as! Int)
        itemNameLabel.text = stringItemName[0]
        itemQuantityLabel.text = String(stringItemQty[0])
        itemID = viewModel.itemID
    }
    
    @objc func didTapUpdateButton(){
        self.deleage?.didTapUpdateButton(cell: self)
    }
}
