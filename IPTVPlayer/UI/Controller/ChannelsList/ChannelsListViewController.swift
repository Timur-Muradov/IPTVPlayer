//
//  ChannelsListViewController.swift
//  IPTVPlayer
//
//  Created by Тимур Мурадов on 01.12.2023.
//

import UIKit

enum ChannelsListFilter {
    case all, favorites, none
}

/// Main view controller to show list of available channels and fillter it
class ChannelsListViewController: UIViewController, ChannelCellDelegate {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allChannelsButton: FilterButton!
    @IBOutlet weak var favoriteChannelsButton: FilterButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    // MARK: - Variables
    var dataSource: DataSource?
    var filter: ChannelsListFilter = .none {
        didSet {
            switch filter {
            case .all:
                allChannelsButton.toggleActive(true)
                favoriteChannelsButton.toggleActive(false)
            case .favorites:
                allChannelsButton.toggleActive(false)
                favoriteChannelsButton.toggleActive(true)
            default:
                allChannelsButton.toggleActive(true)
                favoriteChannelsButton.toggleActive(false)
            }
        }
    }
    var channels: [ChannelViewModel] = []
    // MARK: - Overrided interface
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ChannelTableViewCell", bundle: Bundle.main)
        self.tableView.register(cellNib, forCellReuseIdentifier: "ChannelTableViewCell")
        dataSource?.fetchChannelsList {
            self.channels = self.dataSource?.channels ?? []
            self.filter = .all
            self.configureUI()
            self.searchTextField.textColor = UIColor(red: 143 / 255, green: 144 / 255, blue: 151 / 255, alpha: 1)
            self.searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Напишите название канала",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor(red: 143 / 255,
                                                                    green: 144 / 255,
                                                                    blue: 151 / 255,
                                                                    alpha: 1)
                ])
        }
    }
    
    func configureUI() {
        switch filter {
        case .all:
            self.channels = self.dataSource?.channels ?? []
        case .favorites:
            self.channels = self.dataSource?.favoriteChannels ?? []
        default:
            self.channels = []
        }
        self.tableView.reloadData()
    }
    
    func toggleFavorite(_ channel: ChannelViewModel) {
        dataSource?.toggleFavorite([channel])
        self.configureUI()
    }
    // MARK: - Actions
    @IBAction func showAllChannels(_ sender: FilterButton) {
        self.filter = .all
        self.configureUI()
    }
    
    @IBAction func showFavoriteChannels(_ sender: FilterButton) {
        self.filter = .favorites
        self.configureUI()
    }
}

