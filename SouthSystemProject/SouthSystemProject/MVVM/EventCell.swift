//
//  EventCell.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import UIKit

class EventCell: UITableViewCell {

    // MARK: - Attributes
    static var identifier = "EventCell"

    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 8
        stack.axis = .vertical
        stack.padTop(16)
        stack.padBottom(16)
        return stack
    }()

    lazy var cardView: CardView = {
        let view = CardView(showShadow: true)
        return view
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


    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Actions
    func setupCell() {
        setupTitleLabel()
        setupImageView()
        setupCardView()
        self.backgroundColor = .colorPrimary
        self.selectedBackgroundView = UIView()
    }

    private func setupTitleLabel() {
        mainStack.addArrangedSubview(titleLabel)
        titleLabel.textAlignment = .center
    }

    func setupImageView() {
        mainStack.addArrangedSubview(eventImage)
    }

    private func setupCardView() {
        cardView.addSubview(mainStack)
        mainStack.fillSuperview()
        contentView.addSubview(cardView)
        cardView.fillSuperview(padding: UIEdgeInsets(top: 8, left: 8, bottom: 4, right: 8))
    }
}
