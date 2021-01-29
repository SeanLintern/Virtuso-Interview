//
//  CommentTableViewCell.swift
//  Interview
//
//  Created by Sean Lintern on 29/01/2021.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!

    func setup(comment: CommentCellViewModel) {
        nameLabel.text = comment.name
        emailLabel.text = comment.email
        bodyLabel.text = comment.body
    }
}
