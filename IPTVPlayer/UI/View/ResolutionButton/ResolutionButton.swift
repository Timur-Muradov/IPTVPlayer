//
//  ResolutionButton.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 15.12.2023.
//

import UIKit

/// Custom button for resolution menu
final class ResolutionButton: UIButton {
    func makeActive(_ flag: Bool) {
        if flag {
            backgroundColor = UIColor(red: 0 / 255,
                                      green: 119 / 255,
                                      blue: 255 / 255,
                                      alpha: 1)
            
            titleLabel?.textColor = .white
        } else {
            backgroundColor = UIColor(red: 255 / 255,
                                      green: 255 / 255,
                                      blue: 255 / 255,
                                      alpha: 1)
            
            titleLabel?.textColor = UIColor(red: 26 / 255,
                                            green: 28 / 255,
                                            blue: 35 / 255,
                                            alpha: 1)
        }
    }
}
