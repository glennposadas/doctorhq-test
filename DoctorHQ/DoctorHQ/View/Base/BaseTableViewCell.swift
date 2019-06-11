//
//  BaseTableViewCell.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private(set) var disposeBag = DisposeBag()
    
    static var identifier: String! {
        get {
            return "\(self.typeName(self))"
        }
    }
    
    // MARK: - Functions
    
    private static func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    // MARK: Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHighlightedAnimation() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 5,
            animations: {
                let value: CGFloat = self.isHighlighted ? 0.95 : 1.0
                _ = self.subviews.map { $0.transform = CGAffineTransform(scaleX: value, y: value) }
        }, completion: nil)
    }
}

