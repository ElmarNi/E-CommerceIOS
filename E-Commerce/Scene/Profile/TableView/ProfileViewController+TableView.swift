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
        case let .personalInformation(data), let .accountManagment(data):
            return data.count
        case let .supportAndInformation(data):
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell
        else { return UITableViewCell() }
        switch viewModel.sections[indexPath.section] {
        case let .personalInformation(data), let .accountManagment(data):
            cell.configure(title: data[indexPath.row])
        case let .supportAndInformation(data):
            cell.configure(title: data[indexPath.row].key)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.sections[indexPath.section] {
        case .personalInformation(_):
            switch indexPath.row {
            case 0:
                let shippingVC = ShippingViewController()
                shippingVC.title = "Shipping Address"
                navigationController?.pushViewController(shippingVC, animated: true)
            default:
                navigationController?.pushViewController(PaymentViewController(), animated: true)
            }
        case let .supportAndInformation(data):
            let profileSupportViewController = ProfileSupportViewController(data: data[indexPath.row].value,
                                                                            isFAQ: data[indexPath.row].key.lowercased().contains("faq"))
            profileSupportViewController.title = data[indexPath.row].key
            navigationController?.pushViewController(profileSupportViewController, animated: true)
        case .accountManagment(_):
            navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
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

