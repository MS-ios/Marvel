//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Monika Saini on 10/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation

class CharactersViewModel: NSObject {
    private var characterService: CharactersServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var characters = [Character]()
    
    var characterCellViewModels = [CharacterCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(characterService: CharactersServiceProtocol = CharactersService()) {
        self.characterService = characterService
    }
    
    func getCharacters() {
        characterService.getCharacters { success, model, error in
            if success, let characters = model?.results {
                self.fetchData(characters: characters)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(characters: [Character]) {
        self.characters = characters // Cache
        var vms = [CharacterCellViewModel]()
        for character in characters {
            vms.append(createCellModel(character: character))
        }
        characterCellViewModels = vms
    }
    
    func createCellModel(character: Character) -> CharacterCellViewModel {
        let id = character.id!
        let name = character.name!
        let description = character.description ?? ""
        let poster = character.thumbnail!
        
        return CharacterCellViewModel(id: id, name: name, description: description, poster: poster)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CharacterCellViewModel {
        return characterCellViewModels[indexPath.row]
    }
}
