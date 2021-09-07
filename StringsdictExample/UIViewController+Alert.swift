//
//  UIViewController+Alert.swift
//  StringsdictExample
//
//  Created by Jair Moreno Gaspar on 06/09/21.
//

import UIKit

extension UIViewController {
    
    func showAlertSheet(title: String, deleteAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let action = UIAlertAction(title: title, style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            deleteAction()
            self.setEditing(false, animated: true)
        }
        let closeAction = UIAlertAction(title: NSLocalizedString("ALERT_CANCEL_TITLE", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(action)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
