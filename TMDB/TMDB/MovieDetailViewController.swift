//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import UIKit
import SDWebImage

final class MovieDetailViewController: UIViewController {
    
    private var movieImage,imdbLogo,starIcon:UIImageView?
    private var rateLabel,dateLabel,movieNameLabel,movieDescriptionLabel:UILabel?
    private var fluView,dot:UIView?
    private var scrollView:UIScrollView?
    var viewModel : MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        viewModel.getMovieDetailData {
            DispatchQueue.main.async {
                self.updateUI(movieImageURL: self.viewModel.movieDetailModel?.posterPath ?? "",
                              movieName: self.viewModel.movieDetailModel?.title ?? "",
                              rate:String(self.viewModel.movieDetailModel?.voteAverage ?? 0),
                              date: self.viewModel.movieDetailModel?.releaseDate ?? "",
                              description: self.viewModel.movieDetailModel?.overview ?? "")
            }
        }
    }
    
    func setupUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = " "
        
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        
        movieImage = UIImageView()
        movieImage?.contentMode = .scaleAspectFill
        movieImage?.clipsToBounds = true
        scrollView?.addSubview(movieImage!)
        
        fluView = UIView()
        fluView?.backgroundColor = .black
        fluView?.alpha = 0.4
        movieImage?.addSubview(fluView!)
        
        imdbLogo = UIImageView(image: UIImage(named: "IMDBLogo"))
        imdbLogo?.contentMode = .scaleAspectFill
        scrollView?.addSubview(imdbLogo!)
        
        starIcon = UIImageView(image: UIImage(named: "starIcon"))
        scrollView?.addSubview(starIcon!)
        
        rateLabel = UILabel()
        rateLabel?.textColor = .gray
        rateLabel?.font = FontManager.fontMedium(13)
        scrollView?.addSubview(rateLabel!)
        
        dot = UIView()
        dot?.layer.cornerRadius = 2
        dot?.backgroundColor = .systemYellow
        scrollView?.addSubview(dot!)
        
        dateLabel = UILabel()
        dateLabel?.textColor = .black
        dateLabel?.font = FontManager.fontMedium(13)
        scrollView?.addSubview(dateLabel!)
        
        movieNameLabel = UILabel()
        movieNameLabel?.textColor = .black
        movieNameLabel?.font = FontManager.fontBold(20)
        scrollView?.addSubview(movieNameLabel!)
        
        movieDescriptionLabel = UILabel()
        
        movieDescriptionLabel?.textColor = .black
        movieDescriptionLabel?.numberOfLines = 0
        movieDescriptionLabel?.font = FontManager.fontRegular(15)
        scrollView?.addSubview(movieDescriptionLabel!)
        
        
    }
    func setupConstraints(){
        scrollView?.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieImage?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.height.equalTo(276.handleSmallScreenConstraints())
            make.width.equalTo(screenWidth)
        })
        
        fluView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imdbLogo?.snp.makeConstraints({ make in
            make.top.equalTo(movieImage!.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(49)
            make.height.equalTo(24)
        })
        
        starIcon?.snp.makeConstraints({ make in
            make.top.equalTo(movieImage!.snp.bottom).offset(16)
            make.left.equalTo(imdbLogo!.snp.right).offset(8)
            make.centerY.equalTo(imdbLogo!)
            make.width.height.equalTo(16)
        })
        
        rateLabel?.snp.makeConstraints({ make in
            make.top.equalTo(movieImage!.snp.bottom).offset(16)
            make.left.equalTo(starIcon!.snp.right).offset(8)
            make.centerY.equalTo(starIcon!)
        })
        
        dot?.snp.makeConstraints { make in
            make.height.width.equalTo(4)
            make.left.equalTo(rateLabel!.snp.right).offset(8)
            make.centerY.equalTo(rateLabel!)
        }
        
        dateLabel?.snp.makeConstraints({ make in
            make.top.equalTo(movieImage!.snp.bottom).offset(16)
            make.left.equalTo(dot!.snp.right).offset(8)
            make.centerY.equalTo(starIcon!)
        })
        movieNameLabel?.snp.makeConstraints({ make in
            make.top.equalTo(imdbLogo!.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        })
        movieDescriptionLabel?.snp.makeConstraints({ make in
            make.left.right.equalTo(view).inset(16)
            make.top.equalTo(movieNameLabel!.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        })
        scrollView?.contentSize = CGSize(width: screenWidth, height: 400.handleSmallScreenConstraints() + (movieDescriptionLabel?.frame.height)!)
    }
    func updateUI(movieImageURL:String,movieName:String,rate:String,date:String,description:String){
        movieImage?.sd_setImage(with: NetworkManager.shared.getImageURL(with: movieImageURL))
        title = movieName
        let range = (rate + "/10" as NSString).range(of: rate)
        let mutableAttributedString = NSMutableAttributedString.init(string: rate + "/10")
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        rateLabel?.attributedText = mutableAttributedString
        dateLabel?.text = date
        movieDescriptionLabel?.text = description
    }
}
