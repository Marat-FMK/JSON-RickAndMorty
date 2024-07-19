//
//  TableViewCell.swift
//  ParsJSON
//
//  Created by Marat Fakhrizhanov on 17.07.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    // MARK: - Publuc methods
    
    func configure(with character: Character?) {
        
        nameLabel.text = character?.name
        characterImageView.fetchImage(from: character?.image ?? "")
    }
}
