//
//  CollectionViewCell.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import UIKit
import SnapKit

final class UpcomingMoviesCollectionViewCell: UICollectionViewCell {
    
    var movieImage:UIImageView?
    var movieName:UILabel?
    var movieShortDesc:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        clipsToBounds = true
        makeUI()
    }
    
    func makeUI(){
        movieImage = UIImageView()
        movieImage?.contentMode = .scaleAspectFill
        movieImage?.alpha = 0.6
        movieImage?.image = UIImage(named: "image1")
        addSubview(movieImage!)
        
        movieName = UILabel()
        movieName?.text = "MOONRISE KINGDOM (2012)"
        movieName?.textColor = .white
        movieName?.font = FontManager.fontBold(20)
        addSubview(movieName!)
        
        movieShortDesc = UILabel()
        movieShortDesc?.numberOfLines = 2
        movieShortDesc?.textColor = .white
        movieShortDesc?.font = FontManager.fontMedium(12)
        movieShortDesc?.text = "A pair of young lovers flee their New England town, which causes a local search party to fan out to find them."
        addSubview(movieShortDesc!)
        
        movieImage?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        movieShortDesc?.snp.makeConstraints({ make in
            make.bottom.equalTo(movieImage!.snp.bottom).inset(32)
            make.left.right.equalToSuperview().inset(16)
        })
        movieName?.snp.makeConstraints({ make in
            make.bottom.equalTo(movieShortDesc!.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(16)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
