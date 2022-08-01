//
//  ImageUtils.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import UIKit

extension UIImageView {

    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                DispatchQueue.main.async { [weak self] in
                    self?.image = R.image.image_not_found()
                }
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {
            DispatchQueue.main.async { [weak self] in
                self?.image = R.image.image_not_found()
            }
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIView {

    func anchorToEntireView(of view: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
    }
}
