//
//  HomePageCollectionViewCell.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/12/22.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomePageCollectionViewCell"
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = Constant.shared.itemLabel
        return label
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.shared.qtyLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        //label.backgroundColor = .yellow
        return label
    }()
    
    private let itemQuantityLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .green
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.shared.originalPricePerItem
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    private let itemOriginalPriceLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(itemLabel)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(itemQuantityLabel)
        contentView.addSubview(itemOriginalPriceLabel)
        contentView.layer.cornerRadius = 8
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
    }
    
//MARK: - Functions
    func configure(viewModel: HomePageViewModel){
        var stringItemName: [String] = []
        var stringItemQty: [Int] = []
        stringItemName.append(viewModel.item["Item"] as! String)
        stringItemQty.append(viewModel.item["Quantity"] as! Int)
        itemNameLabel.text = stringItemName[0]
        itemQuantityLabel.text = String(stringItemQty[0])
    }
}
