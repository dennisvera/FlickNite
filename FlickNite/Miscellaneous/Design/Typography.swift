//
//  Typography.swift
//  FlickNite
//
//  Created by Dennis Vera on 6/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

extension String {
  
  // MARK: - Helper Methods
  
  func toTtitle(color: UIColor = .black, textAlignment: NSTextAlignment = .center) -> NSAttributedString {
    return StringBuilder(string: self)
      .size(18.0)
      .color(color)
      .textAlignment(textAlignment)
      .build()
  }
}


final class StringBuilder {
  
  // MARK: - Types
  
  enum FontName: String {
    
    // MARK: - Cases
    
    case latoBold = "Lato-Bold"
    case latoLight = "Lato-Light"
    case latoRegular = "Lato-Regular"
    
    // MARK: - Methods
    
    fileprivate func font(of size: CGFloat) -> UIFont {
      return UIFont(name: rawValue, size: size)!
    }
  }
  
  // MARK: - Properties
  
  private let string: String
  private var fontName: FontName = .latoRegular
  private var size: CGFloat = 17.0
  private var color: UIColor = .black
  private var textAlignment: NSTextAlignment = .center
  
  // MARK: - Initialization
  
  init(string: String) {
    self.string = string
  }
  
  // MARK: - Pulblic API
  
  func fontName(_ fontName: FontName) -> StringBuilder {
    self.fontName = fontName
    return self
  }
  
  func size(_ fontSize: CGFloat) -> StringBuilder {
    self.size = fontSize
    return self
  }
  
  func color(_ fontColor: UIColor) -> StringBuilder {
    self.color = fontColor
    return self
  }
  
  func textAlignment(_ textAlignment: NSTextAlignment) -> StringBuilder {
    self.textAlignment = textAlignment
    return self
  }
  
  func build() -> NSAttributedString {
    // Create Paragraph Style
    let paragraphStyle = NSMutableParagraphStyle()
    
    // Configure Paragraph Style
    paragraphStyle.alignment = textAlignment
    
    // Define Attributes
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: color,
      .font: fontName.font(of: size),
      .paragraphStyle: paragraphStyle
    ]
    
    return NSAttributedString(string: string, attributes: attributes)
  }
}
