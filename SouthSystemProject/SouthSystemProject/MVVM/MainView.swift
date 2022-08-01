//
//  MainView.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import LBTATools
import UIKit

class MainView: UIView {

    // MARK: - Attributes
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .colorPrimaryDark
        setupTable()
    }

    // MARK: - Actions

    private func setupTable() {
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .colorPrimary
        addSubview(tableView)
        tableView.anchor(.top(safeAreaLayoutGuide.topAnchor, constant: 0),
                         .bottom(bottomAnchor, constant: 0),
                         .trailing(trailingAnchor, constant: 0),
                         .leading(leadingAnchor, constant: 0))
    }
}
