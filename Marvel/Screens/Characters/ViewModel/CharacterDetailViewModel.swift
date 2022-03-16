//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Monika Saini on 16/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation

class CharacterDetailViewModel: NSObject {
    
    var reloadView: (() -> Void)?

    private var characterService: CharactersServiceProtocol
    var characterCellViewModel: CharacterCellViewModel? = nil
    
    init(characterService: CharactersServiceProtocol = CharactersService()) {
        self.characterService = characterService
    }
    
    //JSON->Array
    func getCharacterDetail(with id: Int) {
        characterService.characterDetails(with: id, completion:  { success, model, error in
            if success, let character = model?.results.first {
                self.characterCellViewModel = self.createCellModel(character: character)
                self.reloadView?()
            } else {
                print(error!)
            }
        })
    }
    
    //Array->Model
    func createCellModel(character: Character) -> CharacterCellViewModel {
        let id = character.id!
        let name = character.name!
        let description = character.description ?? ""
        let poster = character.thumbnail!
        
        return CharacterCellViewModel(id: id, name: name, description: description, poster: poster)
    }
}
