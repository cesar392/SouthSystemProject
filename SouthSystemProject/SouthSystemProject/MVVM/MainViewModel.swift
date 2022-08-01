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
        let url = URL(string: Constants.eventsURL)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            do {
                self.events = try JSONDecoder().decode([Event].self, from: data)
            } catch {
                print("Failed to convert, an error occurred: \(error.localizedDescription)")
            }
        }.resume()
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
        cell.eventImage.downloaded(from: event.image ?? "")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedEvent = self.events[indexPath.row]
        guard let currentSelectedEvent = currentSelectedEvent else { return }
        openDetails(from: currentSelectedEvent)
    }
}
