//
//  HomeTableViewCell.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class HomeTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private lazy var imageView_SelectIcon: UIImageView = {
        return UIImageView.new(withImageName: "ic_select_city")
    }()
    
    private lazy var label_Title: UILabel = {
        return UILabel.new(withText: "", fontSize: 15.0)
    }()
    
    // MARK: - Functions
    
    func setupCell(_ city: City?) {
        if let city = city {
            self.imageView_SelectIcon.alpha = 0
            self.label_Title.text = city.homeCellDescription
            return
        }
        
        self.label_Title.text = "Tap to select a city".localized()
        self.imageView_SelectIcon.alpha = 1.0
    }
    
    // MARK: Overrides
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.removeSeparator()
        
        self.addSubviews(
            self.imageView_SelectIcon,
            self.label_Title
        )
        
        self.imageView_SelectIcon.snp.makeConstraints {
            $0.width.height.equalTo(44.0)
            $0.top.leading.bottom.equalToSuperview().inset(16.0)
        }

        self.label_Title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.imageView_SelectIcon.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
