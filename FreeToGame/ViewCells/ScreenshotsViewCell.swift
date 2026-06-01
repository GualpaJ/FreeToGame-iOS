//
//  ScreenshotsViewCell.swift
//  FreeToGame
//
//  Created by Tardes on 1/6/26.
//

import UIKit

class ScreenshotsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    func render(with imageUrl: String) {
        screenshotImageView.loadFrom(url: imageUrl)
    }
}
