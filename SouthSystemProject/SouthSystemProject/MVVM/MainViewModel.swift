//
//  MainViewModel.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import CoreLocation
import UIKit

class MainViewModel: NSObject {

    // MARK: - Attributes
    var events: [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.tableView.reloadData()
            }
        }
    }

    private weak var view: MainView?
    // MARK: - Life Cycle

    init(view: MainView) {
        super.init()
        self.view = view
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
        cell.label.text = event.title
    }

}
