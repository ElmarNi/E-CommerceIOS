//
//  FilterView.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 22.01.24.
//

import UIKit
import SnapKit

class FilterView: UIView {
    var onAction: (Int) -> Void = {_ in }
    private let tableView = UITableView()
    private let applyButton = RoundedBlackButton(title: "Apply")
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        addSubview(title)
        addSubview(tableView)
        addSubview(applyButton)
        setupUI()
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func applyButtonTapped() {
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        onAction(index)
    }
    
    private func setupUI() {
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(24)
        }
        applyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(12)
            make.bottom.equalTo(applyButton.snp.top).offset(12)
        }
    }
}

extension FilterView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: Filter.titleAtIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell else { return }
        for cell in tableView.visibleCells {
            guard let cell = cell as? FilterTableViewCell else { continue }
            cell.unSelected()
        }
        cell.selected()
    }
}
