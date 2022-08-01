//
//  NotificationBanner.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 01/08/22.
//

import Foundation
import NotificationBannerSwift

public enum BannerType {
    case error
    case info
    case none
    case success
    case warning
}

class BannerPresenter {

    static let shared = BannerPresenter()
    // MARK: - Toast Notification handlers

    var banner: FloatingNotificationBanner?
    func showBanner(with style: BannerStyle, title: String, message: String) {
        DispatchQueue.main.async {
            self.banner = FloatingNotificationBanner(title: title, subtitle: message
                , style: style)
            
            self.banner?.duration = 2
            self.banner?.autoDismiss = true

            self.banner?.show(queuePosition: .front,
                              bannerPosition: .top,
                              cornerRadius: 10)
        }
    }

}
