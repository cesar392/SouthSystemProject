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

    fileprivate var type: BannerType = .info
    fileprivate var message: String = ""

    fileprivate func color(for style: BannerType) -> UIColor {
        switch style {
        case .error:   return UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
        case .info:     return UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
        case .none:     return UIColor.clear
        case .success:  return UIColor(red:0.22, green:0.80, blue:0.46, alpha:1.00)
        case .warning:  return UIColor(red:1.00, green:0.66, blue:0.16, alpha:1.00)
        }
    }

    var banner: FloatingNotificationBanner?
    func showBanner(with style: BannerStyle, title: String, message: String) {
        DispatchQueue.main.async {
            if (self.banner?.isDisplaying ?? false) && AppConfig.shared.environment != .staging {
                return
            }

            self.banner = FloatingNotificationBanner(title: title, subtitle: message
                , style: style)

            // + 40
            self.banner?.duration = 2
            self.banner?.autoDismiss = true

            self.banner?.show(queuePosition: .front,
                              bannerPosition: .top,
                              cornerRadius: 10)
        }
    }

}
