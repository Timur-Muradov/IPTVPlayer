//
//  ChannelSearchBar.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 03.12.2023.
//

import UIKit

class ChannelSearchBar: UISearchBar {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        if let textfield = self.value(forKey: "searchField") as? UITextField {
//            textfield.textColor = UIColor(red: 143 / 255,
//                                          green: 144 / 255,
//                                          blue: 151 / 255,
//                                          alpha: 1)
//
//            barTintColor = UIColor(red: 64 / 255,
//                                   green: 66 / 255,
//                                   blue: 71 / 255,
//                                   alpha: 1)
//            backgroundImage = nil
//            isTranslucent = false
//            backgroundColor = UIColor(red: 52 / 255,
//                                      green: 52 / 255,
//                                      blue: 56 / 255,
//                                      alpha: 1)
//
//        }
    }
}

extension ChannelSearchBar {
    func setTextFieldColor(_ color: UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                let view = subSubView as? UITextInputTraits
                if view != nil {
                    let textField = view as? UITextField
                    textField?.backgroundColor = color
                    setTextFieldColor(UIColor(red: 52 / 255,
                                              green: 52 / 255, blue: 56 / 255, alpha: 1))
                    
                    break
                }
            }
        }
    }
}

extension ChannelSearchBar {
    func setPlaceholderColor(_ color: UIColor) {
        let textField = self.value(forKey: "searchField") as? UITextField
        let placeholder = textField!.value(forKey: "placeholderLabel") as? UILabel
        placeholder?.textColor = UIColor(red: 143 / 255,
                                         green: 144 / 255,
                                         blue: 151 / 255,
                                         alpha: 1)
    }
}
