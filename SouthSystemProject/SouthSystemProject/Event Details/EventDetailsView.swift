//
//  EventDetailsView.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 01/08/22.
//

import Foundation
import UIKit

class EventDetailsView: UIView {

    // MARK: - Attributes

    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 8
        stack.axis = .vertical
        stack.padTop(Constants.defaultPadding)
        stack.padBottom(Constants.defaultPadding)
        stack.padLeft(Constants.defaultPadding)
        stack.padRight(Constants.defaultPadding)
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    lazy var eventImage: UIImageView = {
        let image = UIImageView()
        image.withSize(CGSize(width: 250, height: 150))
        image.sizeToFit()
        return image
    }()

    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()

    lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()

    lazy var priceLabel: UILabel = {
        let lbl = UILabel()
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
        setupTitle()
        setupImage()
        setupDescription()
        setupAddress()
        setupPrice()
    }

    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.anchor(.top(self.topAnchor, constant: Constants.defaultPadding))
    }

    private func setupImage() {
        addSubview(eventImage)
        eventImage.anchor(.top(titleLabel.bottomAnchor, constant: Constants.defaultPadding))
        eventImage.centerYToSuperview()
    }

    private func setupDescription() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(.top(eventImage.bottomAnchor, constant: Constants.defaultPadding),
                                .trailing(self.trailingAnchor, constant: Constants.defaultPadding),
                                .leading(self.leadingAnchor, constant: Constants.defaultPadding))
    }

    private func setupAddress() {
        addSubview(addressLabel)
        addressLabel.anchor(.top(descriptionLabel.bottomAnchor, constant: Constants.defaultPadding),
                            .leading(self.leadingAnchor, constant: Constants.defaultPadding),
                            .trailing(self.trailingAnchor, constant: Constants.defaultPadding))
    }

    private func setupPrice() {
        addSubview(priceLabel)
        priceLabel.anchor(.top(addressLabel.bottomAnchor, constant: Constants.defaultPadding),
                          .leading(self.leadingAnchor, constant: Constants.defaultPadding),
                          .trailing(self.trailingAnchor, constant: Constants.defaultPadding),
                          .bottom(self.bottomAnchor, constant: 0))
    }
}
