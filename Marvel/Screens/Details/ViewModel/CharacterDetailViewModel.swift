//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Monika Saini on 14/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation

class CharacterDetailViewModel: NSObject {
    private let characterId: Int
    private let useCase: MoviesUseCaseType

    init(characterId: Int, useCase: MoviesUseCaseType) {
        self.characterId = characterId
        self.useCase = useCase
    }

    func transform(input: MovieDetailsViewModelInput) -> MovieDetailsViewModelOutput {
        let movieDetails = input.appear
            .flatMap({[unowned self] _ in self.useCase.movieDetails(with: self.movieId) })
            .map({ result -> MovieDetailsState in
                switch result {
                    case .success(let movie): return .success(self.viewModel(from: movie))
                    case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        let loading: MovieDetailsViewModelOutput = input.appear.map({_ in .loading }).eraseToAnyPublisher()

        return Publishers.Merge(loading, movieDetails).removeDuplicates().eraseToAnyPublisher()
    }

    private func viewModel(from movie: Movie) -> MovieViewModel {
        return MovieViewModelBuilder.viewModel(from: movie, imageLoader: {[unowned self] movie in self.useCase.loadImage(for: movie, size: .original) })
    }

}

