//
//  FilterButton.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 04.12.2023.
//

import UIKit

class FilterButton: UIButton {
    
    private var underscoreView: UIView
    
    required init?(coder: NSCoder) {
        underscoreView = UIView(frame: CGRect.zero)
        underscoreView.backgroundColor = UIColor(red: 0,
                                                 green: 119 / 255,
                                                 blue: 1,
                                                 alpha: 1)
        underscoreView.alpha = 0
        super.init(coder: coder)
        self.addSubview(underscoreView)
        
        underscoreView.translatesAutoresizingMaskIntoConstraints = false
        underscoreView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underscoreView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        underscoreView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        underscoreView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func makeActive(_ flag: Bool) {
        if flag {
            underscoreView.alpha = 1
            titleLabel?.textColor = .white
        } else {
            underscoreView.alpha = 0
            titleLabel?.textColor = .white.withAlphaComponent(0.5)
        }
    }
}
