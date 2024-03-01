//
//  ReviewViewController+UITableView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 29.02.24.
//

import Foundation
import UIKit

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        tableView.register(ReviewItemsTableViewCell.self, forCellReuseIdentifier: ReviewItemsTableViewCell.identifier)
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        tableView.register(ReviewTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ReviewTableHeaderView.identifier)
        tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: 1
        case 1: Array(userData.keys).count
        default: Array(orderData.keys).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewItemsTableViewCell.identifier, for: indexPath) as? ReviewItemsTableViewCell
            else { return UITableViewCell()}
            cell.configure(title: "Items (\(cartViewModel.cart?.totalProducts ?? 0))")
            return cell
        case 1: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell
            else { return UITableViewCell()}
            cell.configure(leftSide: Array(userData.keys)[indexPath.row], rightSide: Array(userData.values)[indexPath.row])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell
            else { return UITableViewCell()}
            cell.configure(leftSide: Array(orderData.keys)[indexPath.row], rightSide: Array(orderData.values)[indexPath.row])
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReviewTableHeaderView.identifier) as? ReviewTableHeaderView,
              section != 0
        else { return nil }
        
        let title: String = {
            switch section {
            case 0: ""
            case 1: "Shipping Address"
            default: "Order Info"
            }
        }()
        headerView.configure(title: title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: 0
        default: 30
        }
    }
}
