//
//  ViewController.swift
//  ParsJSON
//
//  Created by Marat Fakhrizhanov on 17.07.2024.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterImageView: CharacterImageView! { didSet {
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
    }}
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: Character!
    
    private var spinerView = UIActivityIndicatorView()
    
    // MARK - UIView Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        title = character.name
        descriptionLabel.text = character.description
        characterImageView.fetchImage(from: character.image)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationCpntroller = segue.destination as! UINavigationController
        let episodeVC = navigationCpntroller.topViewController as! EpisodesViewController
        episodeVC.character = character
    }
    
    
    
    

}

