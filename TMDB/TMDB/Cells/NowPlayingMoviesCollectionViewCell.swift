//
//  NowPlayingMoviesCollectionViewCell.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import UIKit

class NowPlayingMoviesCollectionViewCell: UICollectionViewCell {
    
    var movieImage,rightArrow:UIImageView?
    var movieNameLabel,movieShortDescLabel,movieDateLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeCell()
    }
    
    func makeCell(){
        clipsToBounds = true
        backgroundColor = .white
        movieImage = UIImageView()
        movieImage?.contentMode = .scaleAspectFill
        movieImage?.clipsToBounds = true
        movieImage?.layer.cornerRadius = 10
        movieImage?.image = UIImage(named: "image1")
        addSubview(movieImage!)
        
        movieNameLabel = UILabel()
        movieNameLabel?.text = "MOONRISE KINGDOM (2012)"
        movieNameLabel?.font = FontManager.fontBold(15)
        addSubview(movieNameLabel!)
        
        movieShortDescLabel = UILabel()
        movieShortDescLabel?.numberOfLines = 2
        movieShortDescLabel?.textColor = .gray
        
        movieShortDescLabel?.font = FontManager.fontMedium(13)
        movieShortDescLabel?.text = "A pair of young lovers flee their New England town, which causes a local search party to fan out to find them."
        addSubview(movieShortDescLabel!)
        
        movieDateLabel = UILabel()
        movieDateLabel?.text = "15.06.2021"
        movieDateLabel?.textColor = .gray
        movieDateLabel?.font = FontManager.fontMedium(12)
        addSubview(movieDateLabel!)
        
        rightArrow = UIImageView(image: UIImage(named: "rightArrow"))
        rightArrow?.contentMode = .scaleAspectFill
        addSubview(rightArrow!)
        
        let underLine = UIView()
        underLine.backgroundColor = .gray
        underLine.layer.opacity = 0.2
        addSubview(underLine)
        
        movieImage?.snp.makeConstraints { make in
            make.width.height.equalTo(104.handleSmallScreenConstraints())
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        rightArrow?.snp.makeConstraints({ make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(10.5)
            make.width.equalTo(6)
        })
        movieNameLabel?.snp.makeConstraints({ make in
            make.top.equalTo(movieImage!.snp.top).offset(8)
            make.left.equalTo(movieImage!.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        })

        movieShortDescLabel?.snp.makeConstraints({ make in
            make.top.equalTo(movieNameLabel!.snp.bottom).offset(8)
            make.left.equalTo(movieNameLabel!)
            make.right.equalTo(rightArrow!.snp.left).offset(-5)
        })
        movieDateLabel?.snp.makeConstraints({ make in
            make.bottom.equalTo(movieImage!.snp.bottom)
            make.right.equalToSuperview().inset(28)
        })
        underLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(2)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
