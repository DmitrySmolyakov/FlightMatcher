//
//  Extensions.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/4/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

// MARK: - Presentation

extension UIViewController {

    func presentFromVisible(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let navigationController = self as? UINavigationController {
            navigationController.topViewController?.presentFromVisible(viewController,
                                                                       animated: flag, completion: completion)
        } else if let tabBarController = self as? UITabBarController {
            tabBarController.selectedViewController?.presentFromVisible(viewController,
                                                                        animated: flag, completion: completion)
        } else if let presentedViewController = presentedViewController {
            presentedViewController.presentFromVisible(viewController, animated: flag, completion: completion)
        } else {
            present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}

// MARK: - Navigation

extension UIViewController {

    func pushViewController(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }

    func presentModally(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }

    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - Alert 

extension UIViewController {

    public func alertController(_ message: String) -> UIAlertController {
        let controller = UIAlertController(title: message, message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(action)
        return controller
    }

    public func showAlert(_ message: String, title: String, cancelButtonTitle: String,
                          acceptButtonTitle: String, completionBlock: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        let acceptAction = UIAlertAction(title: acceptButtonTitle, style: .default, handler: { _ in
            completionBlock()
        })
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        present(alert, animated: true, completion: nil)
    }
}

extension Date {

    func formatUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.short
        let localDate = dateFormatter.string(from: self)
        return localDate
    }

    func toString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func from(string: String, withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }
}
