//
//  ProfileViewController+TableView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 02.02.24.
//

import Foundation
import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.identifier)
        tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case let .personalInformation(data), let .supportAndInformation(data), let .accountManagment(data):
            data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell
        else { return UITableViewCell() }
        switch viewModel.sections[indexPath.section] {
        case let .personalInformation(data), let .supportAndInformation(data), let .accountManagment(data):
            cell.configure(title: data[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.sections[indexPath.section] {
        case let .personalInformation(data):
            break
        case let .supportAndInformation(data):
            let profileSupportViewController = ProfileSupportViewController()
            profileSupportViewController.title = data[indexPath.row]
            navigationController?.pushViewController(profileSupportViewController, animated: true)
        case let .accountManagment(data):
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderView.identifier) as? ProfileTableHeaderView
        else {
            return UIView()
        }
        headerView.configure(title: viewModel.sections[section].title)
        return headerView
    }
    
}

