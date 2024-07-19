//
//  CharacterTableViewController.swift
//  ParsJSON
//
//  Created by Marat Fakhrizhanov on 17.07.2024.
//

import UIKit

class CharacterTableViewController: UITableViewController {

    
    
    @IBOutlet weak var labeli: UILabel!
    @IBOutlet weak var imageView: CharacterImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: Private properties
    private var rickAndMorty = RickAndMorty(info: Info(pages: 2, next: "www", prev: "www"), results: [Character(id: 3, name: "333", status: "333", species: "333", gender: "333", origin: Location(name: ""), location: Location(name: ""), image: "https://rickandmortyapi.com/api/character/avatar/22.jpeg", episode: ["dfdf"], url: "")])
    private var searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacter: [Character] = []
    private var searchBarIsEmptyt: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmptyt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        
        setupNavigationBar()
        setupSearchController()
        fetchData(from: Link.rickAndMortyApi.rawValue)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacter.count : rickAndMorty.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        
        var content = cell.defaultContentConfiguration()
        let character = rickAndMorty.results[indexPath.row]
        content.text = character.name
        
        NetworkManager.shared.fetchIm(from: character.image) { image in
            content.image = image 
        }
        
        
        
        cell.contentConfiguration = content
            
        return cell
        
    }

    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering ? filteredCharacter[indexPath.row] : rickAndMorty.results[indexPath.row]
        let detailVC = segue.destination as! CharacterDetailViewController
        detailVC.character = character
    }
    
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: rickAndMorty.info.next)
        : fetchData(from: rickAndMorty.info.prev)
        
    }
    
    
    
    
   
    // MARK: Private methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = " Search "
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func setupNavigationBar() {
        
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.tableView.reloadData()
        }
    }
    

}

extension CharacterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacter = rickAndMorty.results.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}

