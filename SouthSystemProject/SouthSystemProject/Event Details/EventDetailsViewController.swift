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


    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = EventDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    }

    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    func updateView(with event: Event) {
        self.title = R.string.localizable.event_details()
        getAddressFromLatLon(latitude: event.latitude, longitude: event.longitude)
        contentView.titleLabel.text = event.title
        contentView.eventImage.downloaded(from: event.image ?? "")
        contentView.descriptionLabel.text = event.description
        contentView.priceLabel.text = R.string.localizable.price_label(String(event.price ?? 0))
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
