//
//  Extension-HandleConstraints.swift
//  TMDB
//
//  Created by Alperen Kişi on 18.06.2022.
//

import Foundation


extension Double {
  func handleSmallScreenConstraints() -> Double {
      if screenHeight <= 812 {
          let ratio = self/812
          let new = Double(screenHeight) * ratio
          return new
      }else{
          return self
      }
  }
}
