//
//  View.swift
//  DropdownButton_Example
//
//  Created by Alexander Korus on 30.11.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import DropdownButton

class View: UIView {
    
    // MARK: - Subviews
    let dropDownButton: DropdownButton = {
        let button: DropdownButton = DropdownButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.selectedRowColor = .lightGray
        button.selectedRowTextColor = .white
        button.rowHeight = 40
        button.listHeight = 150
        return button
    }()
    
    let chevron: UIImageView = {
        let image = UIImage(named: "down")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        let view: UIImageView = UIImageView(image: image)
        view.tintColor = .white
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        // Set Subviews
        self.dropDownButton.addSubview(self.chevron)
        self.chevron.translatesAutoresizingMaskIntoConstraints = false
        
        for view in [self.dropDownButton] {
            self.addSubview(self.dropDownButton)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Constraints
        self.dropDownButton.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(200)
            
        }
        
        self.chevron.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            
            make.trailing.equalToSuperview().inset(10.0)
            make.height.equalTo(14.0)
            make.width.equalTo(16.0)
            make.centerY.equalToSuperview()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

