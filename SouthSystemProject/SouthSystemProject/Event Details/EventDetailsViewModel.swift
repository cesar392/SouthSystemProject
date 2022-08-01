//
//  EventDetailsViewModel.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 01/08/22.
//

import Foundation

class EventDetailsViewModel: NSObject {

    // MARK: - Attributes
    private weak var viewController: EventDetailsViewController?

    // MARK: - Life Cycle
    init(viewController: EventDetailsViewController) {
        super.init()
        self.viewController = viewController
    }

    // MARK: - Actions
    func makeAPIPost(people: People) {
        let request = APIRequest(endpoint: Endpoints.checkin)
        request.save(people: people, completion: { result in
            switch result {
            case .success(let event):
                print("The following event has been sent: \(event.title)")
            case .failure(let error):
                print("An error occured: \(error)")
            }
        })
    }
}
