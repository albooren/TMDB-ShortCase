//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Alperen Kişi on 19.06.2022.
//

import Foundation

final class HomeViewModel {
    //https://api.themoviedb.org/3/movie/upcoming?api_key=993fd1ddf77f9e1dc0979c295296959d&language=en-US&page=1

    var upComingDataList: [ResultModel] = []
    var nowPlayingDataList: [ResultModel] = []

    
    func getUpcomingData(onComplete: @escaping () -> Void) {
        let url = NetworkManager.shared.getURL(with: Endpoints.upComing.rawValue)
        NetworkManager.shared.request(url: url, requestMethod: .get) { [weak self] (result: Result<ResponseDataModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.upComingDataList = response.results
                onComplete()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func getNowPlayingData(onComplete: @escaping () -> Void) {
        let url = NetworkManager.shared.getURL(with: Endpoints.nowPlaying.rawValue)
        NetworkManager.shared.request(url: url, requestMethod: .get) { [weak self] (result: Result<ResponseDataModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.nowPlayingDataList = response.results
                onComplete()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
