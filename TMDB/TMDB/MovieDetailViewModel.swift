//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Alperen Kişi on 19.06.2022.
//

import Foundation

final class MovieDetailViewModel {
    
    var movieID = 0
    var movieDetailModel : MovieDetailModel?
    
    init(movieID:Int){
        self.movieID = movieID
    }
    
    func getMovieDetailData(onComplete: @escaping () -> Void) {
        NetworkManager.shared.request(url: NetworkManager.shared.getURL(with: "/3/movie/\(movieID)"), requestMethod: .get) { [weak self] (result: Result<MovieDetailModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movieDetailModel = response
                onComplete()
            case .failure(let error):
                print(error)
            }
        }
    }

}
