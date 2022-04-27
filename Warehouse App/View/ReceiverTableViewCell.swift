//
//  ReceiverTableViewCell.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/25/22.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {
//MARK: - Properties
    static let identifier = "ReceiverTableViewCell"
    
    private let receiverLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = Constant.shared.receiverLabel
        return label
    }()
    
    private let receiverNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let sentItemLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = Constant.shared.sentItemLabel
        return label
    }()
    
    private let sentItemNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = Constant.shared.quantityOfSentItemLabel
        return label
    }()
    
    private let numberOfQuantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = Constant.shared.dateSentItemLabel
        return label
    }()
    
    private let dateItemSentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

//MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.addSubview(receiverLabel)
        contentView.addSubview(receiverNameLabel)
        contentView.addSubview(sentItemLabel)
        contentView.addSubview(sentItemNameLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(numberOfQuantityLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(dateItemSentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiverLabel.frame = CGRect(x: 0, y: 10, width: 80 , height: 30)
        receiverNameLabel.frame = CGRect(x: receiverLabel.frame.origin.x + receiverLabel.frame.width, y: 10, width: contentView.frame.width - receiverLabel.frame.width, height: 30)
        sentItemLabel.frame = CGRect(x: 0 , y: receiverLabel.frame.origin.y + receiverLabel.frame.height, width: 80, height: 30)
        sentItemNameLabel.frame = CGRect(x: sentItemLabel.frame.origin.x + sentItemLabel.frame.width, y: sentItemLabel.frame.origin.y, width: contentView.frame.width - sentItemLabel.frame.width, height: 30)
        quantityLabel.frame = CGRect(x: 0, y: sentItemLabel.frame.origin.y + sentItemLabel.frame.height, width: 80, height: 30)
        numberOfQuantityLabel.frame = CGRect(x: quantityLabel.frame.origin.x + quantityLabel.frame.width, y: quantityLabel.frame.origin.y, width: contentView.frame.width - 80, height: 30)
        dateLabel.frame = CGRect(x: 0, y: numberOfQuantityLabel.frame.origin.y + numberOfQuantityLabel.frame.height, width: 80, height: 30)
        dateItemSentLabel.frame = CGRect(x: dateLabel.frame.origin.x + dateLabel.frame.width, y: dateLabel.frame.origin.y, width: contentView.frame.width - dateLabel.frame.width, height: 30)
    }

//MARK: - Functions
    func configure(viewModel: ReceiverViewModel){
        var transactionInfo = viewModel.transactionInfo as! [String:[String:Any]]
        for (key,value) in transactionInfo {
            receiverNameLabel.text = key
            sentItemNameLabel.text = value["Item"] as! String
            numberOfQuantityLabel.text = String(value["Quantity"] as! Int)
            dateItemSentLabel.text = value["Date"] as! String
        }
    }
}
