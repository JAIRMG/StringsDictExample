//
//  UIViewController+Alert.swift
//  StringsdictExample
//
//  Created by Jair Moreno Gaspar on 06/09/21.
//

import UIKit

extension UIViewController {
    
    func showAlertSheet(itemsCount: Int, deleteAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let formatString : String = NSLocalizedString("ACTION_SHEET_MESSAGE",
                                                      comment: "Number of towns to delete in plural configuration")
        let resultString = String.localizedStringWithFormat(formatString, itemsCount)
        
        let action1 = UIAlertAction(title: resultString, style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            deleteAction()
            self.setEditing(false, animated: true)
        }
        let closeAction = UIAlertAction(title: NSLocalizedString("ALERT_CANCEL_TITLE", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(action1)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
