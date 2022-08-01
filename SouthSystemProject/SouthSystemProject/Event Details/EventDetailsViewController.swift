//
//  EventDetailsViewController.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 01/08/22.
//

import Foundation
import CoreLocation
import UIKit

class EventDetailsViewController: UIViewController, HasCustomView {

    // MARK: - Attributes
    typealias ContentView = EventDetailsView
    var event: Event?
    var viewModel: EventDetailsViewModel?

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = EventDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    public static func initiate(event: Event) -> EventDetailsViewController {
        let viewController = EventDetailsViewController()
        viewController.event = event
        return viewController
    }

    // MARK: - Actions
    private func setupView() {
        setNavigationButtons()
    }

    private func setNavigationButtons() {
        let backItem = UIBarButtonItem(image: R.image.ic_back(),
                                       style: .plain,
                                       target: self,
                                       action: #selector(backPressed))
        backItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backItem

        let checkIn = UIBarButtonItem(image: R.image.ic_add(),
                                      style: .plain,
                                      target: self,
                                      action: #selector(checkInPressed))
        checkIn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = checkIn
    }

    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func checkInPressed() {
        let alert = UIAlertController(title: R.string.localizable.check_in_title(),
                                      message: R.string.localizable.check_in_message(),
                                      preferredStyle: .alert)

        alert.addTextField(configurationHandler: { nameField in
            nameField.placeholder = R.string.localizable.name()
            nameField.returnKeyType = .next
        })
        alert.addTextField(configurationHandler: { emailField in
            emailField.placeholder = R.string.localizable.email()
            emailField.returnKeyType = .done
            emailField.keyboardType = .emailAddress
        })

        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: R.string.localizable.confirm(), style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 2, let event = self.event else { return }
            let nameField = fields[0]
            let emailField = fields[1]
            guard let email = emailField.text, !email.isEmpty,
                  let name = nameField.text, !name.isEmpty else {
                      BannerPresenter.shared.showBanner(with: .warning,
                                                        title: R.string.localizable.error(),
                                                        message: R.string.localizable.bad_user())
                      return
                  }
            let people = People(eventId: event.id,
                                name: name,
                                email: email)
            self.viewModel?.makeAPIPost(people: people)
        }))
        self.present(alert, animated: true)
    }

    func updateView(with event: Event) {
        self.event = event
        self.title = R.string.localizable.event_details()
        getAddressFromLatLon(latitude: event.latitude, longitude: event.longitude)
        contentView.titleLabel.text = event.title
        contentView.eventImage.downloaded(from: event.image)
        contentView.descriptionLabel.text = event.description
        contentView.priceLabel.text = R.string.localizable.price_label(String(event.price))
    }


    private func getAddressFromLatLon(latitude: Double?, longitude: Double?) {
        var addressString = ""
        var center = CLLocationCoordinate2D()
        guard let latitude = latitude, let longitude = longitude else {
            print("Address not provided.")
            return
        }
        center.latitude = latitude
        center.longitude = longitude
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        let ceo = CLGeocoder()
        ceo.reverseGeocodeLocation(loc,
                                   completionHandler: { (placemarks, error) in
            if (error != nil) {
                print("Reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]

            if !pm.isEmpty {
                let pm = placemarks![0]
                if let sublocality = pm.subLocality {
                    addressString += sublocality + ", "
                }
                if let thoroughfare = pm.thoroughfare {
                    addressString += thoroughfare + ", "
                }
                if let locality = pm.locality {
                    addressString += locality + ", "
                }
                if let country = pm.country {
                    addressString += country + "."
                }
            }
            self.updateAdress(with: addressString)
        })
    }

    private func updateAdress(with address: String) {
        contentView.addressLabel.text = R.string.localizable.address_label(address)
    }
}
