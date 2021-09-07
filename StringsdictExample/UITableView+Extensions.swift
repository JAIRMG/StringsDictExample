//
//  UITableView+Extensions.swift
//  StringsdictExample
//
//  Created by Jair Moreno Gaspar on 02/09/21.
//

import UIKit

extension UITableView {

    var allIndexPaths: [IndexPath] {
        return (0..<self.numberOfSections).indices.map { (sectionIndex: Int) -> [IndexPath] in
            (0..<self.numberOfRows(inSection: sectionIndex)).indices.compactMap { (rowIndex: Int) -> IndexPath? in
                IndexPath(row: rowIndex, section: sectionIndex)
            }
        }.flatMap { $0 }
    }
}
