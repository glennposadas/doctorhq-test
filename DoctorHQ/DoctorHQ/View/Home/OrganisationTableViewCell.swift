//
//  OrganisationTableViewCell.swift
//  DoctorHQ
//
//  Created by Glenn Posadas on 6/11/19.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class OrganisationTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    /// The full name of the org.
    private lazy var label_Title: UILabel = {
        return UILabel.new(
            withText: "",
            fontSize: 16.0,
            weight: .medium,
            textColor: .black,
            numberOfLines: 2,
            textAlignment: .left
        )
    }()
    
    /// The complete address of the org.
    private lazy var label_Address: UILabel = {
        return UILabel.new(
            withText: "",
            fontSize: 12.0,
            textColor: .black,
            numberOfLines: 0,
            textAlignment: .left
        )
    }()
    
    /// The close and open schedule of the org.
    private lazy var label_Time: UILabel = {
        return UILabel.new(
            withText: "",
            fontSize: 12.0,
            textColor: .black,
            numberOfLines: 0,
            textAlignment: .left
        )
    }()
    
    /// The label for distance from the user to the org, in KM.
    private lazy var label_Distance: UILabel = {
        return UILabel.new(
            withText: "",
            fontSize: 12.0,
            textColor: .black,
            numberOfLines: 0,
            textAlignment: .left
        )
    }()
    
    /// The location icon that sits at the side of distance label.
    private lazy var imageView_LocationIcon: UIImageView = {
        return UIImageView.new(withImageName: "ic_location", contentMode: .scaleAspectFit)
    }()
    
    /// The clock icon for a stuff that I do not know.
    /// As per the DocHQ iOS appstore screenshots, there's a "2 week" label at the side of the clock icon.
    /// Which does not make sense to me when thinking about the response from the API.
    private lazy var imageView_ClockIcon: UIImageView = {
        return UIImageView.new(withImageName: "ic_clock", contentMode: .scaleAspectFit)
    }()
    
    /// The card container that contains all the subviews of the cell.
    private lazy var view_CardContainer: UIView = {
        return UIView.new(backgroundColor: .white)
    }()
    
    // MARK: - Functions
    
    func setupCell(_ org: Organisation) {
        self.label_Title.text = org.formattedTitle
        self.label_Address.text = org.formattedAddress
    }
    
    // MARK: Overrides
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.removeSeparator()
        
        self.addSubviews(
            self.label_Title,
            self.label_Address,
            self.label_Time,
            self.label_Distance,
            self.imageView_LocationIcon
        )
        
        self.label_Title.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(50.0)
        }

        self.label_Address.snp.makeConstraints {
            $0.top.equalTo(self.label_Title.snp.bottom).offset(8.0)
            $0.leading.trailing.equalTo(self.label_Title)
        }

        self.label_Time.snp.makeConstraints {
            $0.top.equalTo(self.label_Address.snp.bottom).offset(8.0)
            $0.leading.trailing.equalTo(self.label_Title)
        }

        self.imageView_LocationIcon.snp.makeConstraints {
            $0.width.height.equalTo(20.0)
            $0.top.equalTo(self.label_Time.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
        }

        self.label_Distance.snp.makeConstraints {
            $0.centerY.equalTo(self.imageView_LocationIcon)
            $0.leading.equalTo(self.imageView_LocationIcon.snp.trailing).offset(4.0)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

