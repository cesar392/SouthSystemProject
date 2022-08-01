//
//  MainViewModel.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import UIKit

class MainViewModel: NSObject {

    // MARK: - Attributes
    var events: [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.viewController?.reloadTableView()
            }
        }
    }

    private weak var viewController: MainViewController?
    private var currentSelectedEvent: Event?

    // MARK: - Life Cycle
    init(viewController: MainViewController) {
        super.init()
        self.viewController = viewController
    }

    // MARK: - Actions
    func fetchEventsFromAPI() {
        let request = APIRequest(endpoint: Endpoints.events)
        request.fetch(completion: { result in
            switch result {
            case .success(let events):
                self.events = events
                events.forEach({ print("The following event has been fetched: \($0.title)") })
            case .failure(let error):
                print("An error occured: \(error)")
            }
        })
    }

    private func openDetails(from event: Event) {
        viewController?.navigateToEventDetails(event: event)
    }
    
}

extension MainViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView .dequeueReusableCell(withIdentifier: EventCell.identifier,
                                                        for: indexPath) as? EventCell
        else { fatalError() }
        let currentEvent = events[indexPath.row]
        updateCell(cell, with: currentEvent)
        return cell
    }

    func updateCell(_ cell: EventCell, with event: Event) {
        cell.titleLabel.text = event.title
        cell.eventImage.downloaded(from: event.image)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedEvent = self.events[indexPath.row]
        guard let currentSelectedEvent = currentSelectedEvent else { return }
        openDetails(from: currentSelectedEvent)
    }
}
