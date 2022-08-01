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
                BannerPresenter.shared.showBanner(with: .success,
                                                  title: R.string.localizable.success(),
                                                  message: R.string.localizable.checkin_confirmed())
                print("The following event has been sent: \(event.title)")
            case .failure(let error):
                BannerPresenter.shared.showBanner(with: .warning,
                                                  title: R.string.localizable.error(),
                                                  message: R.string.localizable.something_happened())
                print("An error occured: \(error)")
            }
        })
    }
}
