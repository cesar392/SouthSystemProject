//
//  ViewController.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import UIKit

class MainViewController: UIViewController, HasCustomView {

    // MARK: - Attributes
    typealias ContentView = MainView
    private var viewModel: MainViewModel? {
        didSet {
            contentView.tableView.dataSource = viewModel
            contentView.tableView.delegate = viewModel
        }
    }

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MainViewModel()
        setupHeader()
    }

    // MARK: - Actions
    private func setupHeader() {
        self.title = R.string.localizable.main_title()
    }
}
