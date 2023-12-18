//
//  ChannelsListViewController+TextField.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 10.12.2023.
//

import UIKit
// MARK: - UITextFieldDelegate
extension ChannelsListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let oldText = textField.text else { return false }
        let text = oldText.replacingCharacters(in: Range(range, in: oldText)!, with: string)
        if !text.isEmpty {
            switch filter {
            case .all:
                self.channels = dataSource?.channels.filter({
                    $0.title.lowercased().contains(text.lowercased())
                }) ?? []
            case .favorites:
                self.channels = dataSource?.favoriteChannels.filter({
                    $0.title.lowercased().contains(text.lowercased())
                }) ?? []
            default:
                self.channels = []
            }
        } else {
            switch filter {
            case .all:
                self.channels = dataSource?.channels ?? []
            case .favorites:
                self.channels = dataSource?.favoriteChannels ?? []
            default:
                self.channels = []
            }
        }
        tableView.reloadData()
        return true
    }
}
