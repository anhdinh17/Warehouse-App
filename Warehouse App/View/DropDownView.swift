//
//  DropDownView.swift
//  Warehouse App
//
//  Created by Anh Dinh on 4/22/22.
//

import Foundation
import UIKit

class DropDownView: UIView {
    
    // Need default value or else it gets error with didSet
    var labelSize: CGSize = CGSize.zero{
        didSet{
            itemLabel.frame = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        }
    }
    
    // PaddingLabel inherits from UILabel, use this class to have left offset for the text
    lazy var itemLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .secondarySystemBackground
        label.text = "Select Item To Send"
        label.paddingLeft = 10
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Bold", size: 17)
        label.textColor = .lightGray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(itemLabel)
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
