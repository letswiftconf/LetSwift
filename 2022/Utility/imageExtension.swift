//
//  imageExtension.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

extension Image {
  static let SessionViewTitle: Image = Image("SessionViewTitle")
  
  enum Logo {
    static let instagram: Image = Image("InstagramLogo")
    static let twitter: Image = Image("TwitterLogo")
  }
  
  enum Dummy {
    static let profile: Image = Image("Profile")
  }
}
