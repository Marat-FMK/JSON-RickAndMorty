//
//  EpisodeDetailsViewController.swift
//  ParsJSON
//
//  Created by Marat Fakhrizhanov on 17.07.2024.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    
  
     
    @IBOutlet weak var episodeDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    var episode: Episode!
    
    private var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted{$0.id < $1.id}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCharacters()
        tableView.backgroundColor = UIColor(_colorLiteralRed: 21/255,
                                            green: 32/255,
                                            blue: 66/255,
                                            alpha: 1)
        
        
        title = episode.episode
        
        episodeDescriptionLabel.text = episode.description
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! CharacterDetailViewController
        detailsVC.character = sender as? Character
    }
    
    private func setCharacters() {
        
        episode.characters.forEach { characterURL in
            NetworkManager.shared.fetchCharacter(from: characterURL) { character in
                self.characters.append(character)
            }
        }
   
    }
}

extension EpisodeDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let characterURL = episode.characters[indexPath.row]
        NetworkManager.shared.fetchCharacter(from: characterURL) { character in
            cell.configure(with: character)
        }
        return cell
    }
}

extension EpisodeDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: character)
    }
}
