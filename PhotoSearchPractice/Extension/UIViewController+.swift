//
//  UIViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit

extension UIViewController {
    var baseMargin: CGFloat { 16 }
    var imageWidth: CGFloat {(UIScreen.main.bounds.width - 20) / 2}
    var imageHeight: CGFloat {UIScreen.main.bounds.height / 3.5}
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func pushViewControllerWithNewRoot(root: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = scene.windows.first else { return }
        window.rootViewController = UINavigationController(rootViewController: root)
        window.makeKeyAndVisible()
    }
}
