//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movieImage,imdbLogo,starIcon:UIImageView?
    private var rateLabel,dateLabel,movieNameLabel,movieDescriptionLabel:UILabel?
    private var fluView,dot:UIView?
    private var scrollView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        title = "Moonrise Kingdom (2012)"
        navigationController?.navigationBar.topItem?.title = " "
        
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        
        movieImage = UIImageView()
        movieImage?.contentMode = .scaleAspectFill
        movieImage?.clipsToBounds = true
        movieImage?.image = UIImage(named: "image1")
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
        rateLabel?.text = "7.8/10"
        rateLabel?.font = FontManager.fontMedium(13)
        scrollView?.addSubview(rateLabel!)
        
        
        dot = UIView()
        dot?.layer.cornerRadius = 2
        dot?.backgroundColor = .systemYellow
        scrollView?.addSubview(dot!)
        
        dateLabel = UILabel()
        dateLabel?.text = "15.12.2022"
        dateLabel?.textColor = .black
        dateLabel?.font = FontManager.fontMedium(13)
        scrollView?.addSubview(dateLabel!)
        
        movieNameLabel = UILabel()
        movieNameLabel?.text = "Moonrise Kingdom (2012)"
        movieNameLabel?.textColor = .black
        movieNameLabel?.font = FontManager.fontBold(20)
        scrollView?.addSubview(movieNameLabel!)
        
        movieDescriptionLabel = UILabel()
        movieDescriptionLabel?.text = "Moonrise Kingdom is a 2012 American coming-of-age comedy-drama film directed by Wes Anderson, written by Anderson and Roman Coppola. It features an ensemble cast including Bruce Willis, Edward Norton, Bill Murray, Frances McDormand, Tilda Swinton, Jason Schwartzman, Bob Balaban, Harvey Keitel, and newcomers Jared Gilman and Kara Hayward. Largely set on the fictional New England island of New Penzance, it tells the story of an orphan boy (Gilman) who escapes from a scouting camp to unite with his pen pal and love interest, a girl with aggressive tendencies (Hayward). Feeling alienated from their guardians and shunned by their peers, the lovers abscond to an isolated beach. Meanwhile, the island's police captain (Willis) organizes a search party of scouts and family members to locate the runaways."
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
    func fillWithMovie(movieName:String,rate:String,date:String,description:String){
        
    }
}
