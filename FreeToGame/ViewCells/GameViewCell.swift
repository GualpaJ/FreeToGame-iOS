//
//  GameViewCell.swift
//  FreeToGame
//
//  Created by Tardes on 28/5/26.
//

import UIKit

class GameViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardShadowView: UIView!
    
    
    @IBOutlet weak var browserImageView: UIImageView!
    @IBOutlet weak var desktopImageView: UIImageView!
    
    func render(with game: Game){
        titleLabel.text = game.title
        thumbnailImageView.loadFrom(url: game.thumbnail)
        descriptionLabel.text = game.shortDescription
        genreLabel.text = game.genre
        
        browserImageView.isHidden = !game.platform.contains("Web Browser")
        desktopImageView.isHidden = !game.platform.contains("PC (Windows)")

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = true
        cardShadowView.backgroundColor = .clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
