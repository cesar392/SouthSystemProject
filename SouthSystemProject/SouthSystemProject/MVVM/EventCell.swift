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

    lazy var cardView: CardView = {
        let view = CardView(showShadow: true)
        return view
    }()

    lazy var label: UILabel = {
        let lbl = UILabel()
        return lbl
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
        cardView.addSubview(label)
        label.anchor(.top(cardView.topAnchor, constant: 16),
                     .trailing(cardView.trailingAnchor, constant: 8),
                     .bottom(cardView.bottomAnchor, constant: 16),
                     .leading(cardView.leadingAnchor, constant: 8))
        label.centerYToSuperview()
        label.textAlignment = .center

        contentView.addSubview(cardView)
        cardView.fillSuperview(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
}
