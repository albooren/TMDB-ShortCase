//
//  ViewController.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    private var upComingMoviesCollectionView:UICollectionView?
    private var pageController: UIPageViewController?
    private var nowPlayingMoviesCollectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUpComingMovies()
        makeNowPlayingMovies()
    }
    
    func makeUpComingMovies(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:screenWidth , height: 276.handleSmallScreenConstraints())
        flowLayout.collectionView?.insetsLayoutMarginsFromSafeArea = true
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        
        upComingMoviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        upComingMoviesCollectionView?.backgroundColor = UIColor.clear
        upComingMoviesCollectionView?.alpha = 0.6
        upComingMoviesCollectionView?.delegate = self
        upComingMoviesCollectionView?.dataSource = self
        upComingMoviesCollectionView?.register(UpcomingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "UpcomingMoviesCollectionViewCell")
        view.addSubview(upComingMoviesCollectionView!)
        upComingMoviesCollectionView?.contentInsetAdjustmentBehavior = .never
        upComingMoviesCollectionView?.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view)
            make.height.equalTo(276.handleSmallScreenConstraints())
        }
    }
    
    func makeNowPlayingMovies(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:screenWidth , height: 136.handleSmallScreenConstraints())
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumLineSpacing = 0
        
        nowPlayingMoviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        nowPlayingMoviesCollectionView?.backgroundColor = UIColor.clear
        nowPlayingMoviesCollectionView?.delegate = self
        nowPlayingMoviesCollectionView?.dataSource = self
        nowPlayingMoviesCollectionView?.register(NowPlayingMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        view.addSubview(nowPlayingMoviesCollectionView!)
        nowPlayingMoviesCollectionView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(upComingMoviesCollectionView!.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == upComingMoviesCollectionView {
            let tempCell = upComingMoviesCollectionView?.dequeueReusableCell(withReuseIdentifier: "UpcomingMoviesCollectionViewCell", for: indexPath) as! UpcomingMoviesCollectionViewCell
            tempCell.movieImage?.image = UIImage(named: "image1")
            cell = tempCell
        }else{
            let tempCell = nowPlayingMoviesCollectionView?.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCollectionViewCell", for: indexPath) as! NowPlayingMoviesCollectionViewCell
            tempCell.movieImage?.image = UIImage(named: "image1")
            cell = tempCell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = MovieDetailViewController()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    func removeNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}

