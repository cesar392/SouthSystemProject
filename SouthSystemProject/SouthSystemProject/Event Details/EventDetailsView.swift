//
//  EventDetailsView.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 01/08/22.
//

import Foundation
import AloeStackView
import UIKit

class EventDetailsView: UIView {

    // MARK: - Attributes

    lazy var mainStack: AloeStackView = {
        let stack = AloeStackView()
        stack.backgroundColor = .colorPrimary
        stack.hidesSeparatorsByDefault = true
        stack.isScrollEnabled = true
        stack.rowInset = UIEdgeInsets(top: 8, left: Constants.defaultPadding,
                                      bottom: 8, right: Constants.defaultPadding)
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()

    lazy var eventImage: UIImageView = {
        let image = UIImageView()
        image.withHeight(250)
        image.image = R.image.image_not_found()
        image.sizeToFit()
        return image
    }()

    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()

    lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()

    lazy var priceValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()

    lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()

    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .colorPrimary
        setupMainStack()
        setupTitle()
        setupImage()
        setupDescription()
        setupAddress()
        setupPrice()
    }

    private func setupMainStack() {
        addSubview(mainStack)
        mainStack.fillSuperview()
    }

    private func setupTitle() {
        mainStack.addRow(titleLabel)
    }

    private func setupImage() {
        mainStack.addRow(eventImage)
    }

    private func setupDescription() {
        mainStack.addRow(descriptionLabel)
    }

    private func setupAddress() {
        mainStack.addRow(addressLabel)
    }

    private func setupPrice() {
        mainStack.addRow(priceLabel)
    }
}
