//
//  Extensions.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/4/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

extension Date {
    
    func formatUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: self)
        return localDate
    }
}

// MARK: - Presentation

extension UIViewController {
    
    func presentFromVisible(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let navigationController = self as? UINavigationController {
            navigationController.topViewController?.presentFromVisible(viewControllerToPresent, animated: flag, completion: completion)
        } else if let tabBarController = self as? UITabBarController {
            tabBarController.selectedViewController?.presentFromVisible(viewControllerToPresent, animated: flag, completion: completion)
        } else if let presentedViewController = presentedViewController {
            presentedViewController.presentFromVisible(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}

// MARK: - Navigation

extension UIViewController {
    
    func pushViewController(_ controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentModally(_ controller: UIViewController) {
        self.present(controller, animated: true, completion: nil)
    }
    
    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - Alert 

extension UIViewController {
    
    public func alertController(_ message: String) -> UIAlertController {
        let controller = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            controller.dismiss(animated: true, completion: nil) }))
        return controller
    }
    
    public func showAlert(_ message: String, title:String, cancelButtonTitle: String, acceptButtonTitle: String, completionBlock: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil) }))
        alert.addAction(UIAlertAction(title: acceptButtonTitle, style: .default, handler: { action in
            completionBlock() }))
        present(alert, animated: true, completion: nil)
    }
}

