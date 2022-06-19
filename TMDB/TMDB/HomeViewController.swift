//
//  ViewController.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import UIKit
import SnapKit
import SDWebImage

final class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    private var upComingCollectionView,nowPlayingCollectionView: UICollectionView!
    private var moviePageControl = UIPageControl()
    private var currentPage = 0
    private var movies = ["","","","","",""]
    private var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNowPlayingMovies()
        makeUpComingMovies()
        reloadLists()
    }
    func reloadLists(){
        viewModel.getUpcomingData {
            DispatchQueue.main.async {
            self.upComingCollectionView.reloadData()
            }
        }
        
        viewModel.getNowPlayingData() {
            DispatchQueue.main.async {
                self.nowPlayingCollectionView.reloadData()
            }
        }
    }
    
    func makeNowPlayingMovies(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:screenWidth , height: 276.handleSmallScreenConstraints())
        flowLayout.collectionView?.insetsLayoutMarginsFromSafeArea = true
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        
        nowPlayingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        nowPlayingCollectionView.backgroundColor = UIColor.clear
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.showsHorizontalScrollIndicator = false
        nowPlayingCollectionView.contentInsetAdjustmentBehavior = .never
        nowPlayingCollectionView.isPagingEnabled = true
        nowPlayingCollectionView.register(UpcomingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "UpcomingMoviesCollectionViewCell")
        view.addSubview(nowPlayingCollectionView)
        
        moviePageControl.currentPage = currentPage
        moviePageControl.pageIndicatorTintColor = .gray.withAlphaComponent(0.8)
        moviePageControl.currentPageIndicatorTintColor = .white
        view.addSubview(moviePageControl)
        
        nowPlayingCollectionView?.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view)
            make.height.equalTo(276.handleSmallScreenConstraints())
        }
        moviePageControl.snp.makeConstraints({ make in
            make.bottom.equalTo(nowPlayingCollectionView!.snp.bottom).offset(-8)
            make.left.right.equalToSuperview()
        })
    }
    func makeUpComingMovies(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:screenWidth , height: 136.handleSmallScreenConstraints())
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumLineSpacing = 0
        
        upComingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        upComingCollectionView?.backgroundColor = UIColor.clear
        upComingCollectionView?.delegate = self
        upComingCollectionView?.dataSource = self
        upComingCollectionView?.register(NowPlayingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        view.addSubview(upComingCollectionView!)
        upComingCollectionView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(nowPlayingCollectionView!.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case nowPlayingCollectionView:
            moviePageControl.numberOfPages = viewModel.nowPlayingDataList.count
            return viewModel.nowPlayingDataList.count
        case upComingCollectionView:
            return viewModel.upComingDataList.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == nowPlayingCollectionView {
            let tempCell = nowPlayingCollectionView?.dequeueReusableCell(withReuseIdentifier: "UpcomingMoviesCollectionViewCell", for: indexPath) as! UpcomingMoviesCollectionViewCell
            tempCell.movieImage?.sd_setImage(with: NetworkManager.shared.getImageURL(with: viewModel.nowPlayingDataList[indexPath.item].posterPath))
            tempCell.movieName?.text = viewModel.nowPlayingDataList[indexPath.item].title
            tempCell.movieShortDesc?.text = viewModel.nowPlayingDataList[indexPath.item].overview
            cell = tempCell
        }else{
            let tempCell = upComingCollectionView?.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCollectionViewCell", for: indexPath) as! NowPlayingMoviesCollectionViewCell
            tempCell.movieNameLabel?.text = viewModel.upComingDataList[indexPath.item].title
            tempCell.movieShortDescLabel?.text = viewModel.upComingDataList[indexPath.item].overview
            tempCell.movieImage?.sd_setImage(with: NetworkManager.shared.getImageURL(with: viewModel.upComingDataList[indexPath.item].posterPath))
            tempCell.movieDateLabel?.text = viewModel.upComingDataList[indexPath.item].releaseDate
            cell = tempCell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movieID = 0
        switch collectionView {
        case nowPlayingCollectionView:
            movieID = viewModel.nowPlayingDataList[indexPath.item].id
        case upComingCollectionView:
            movieID = viewModel.upComingDataList[indexPath.item].id
        default:
            break
        }
        let detailView = MovieDetailViewController()
        detailView.viewModel = MovieDetailViewModel(movieID: movieID)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == nowPlayingCollectionView {
            currentPage = Int(nowPlayingCollectionView?.contentOffset.x ?? 0) / Int(nowPlayingCollectionView?.frame.width ?? 0)
            moviePageControl.currentPage = currentPage
        }
    }
}

