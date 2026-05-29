//
//  DetailViewController.swift
//  FreeToGame
//
//  Created by Tardes on 29/5/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    
    @IBOutlet var roundedViews: [UIView]!
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in roundedViews{
            view.layer.cornerRadius = 10
        }
        
        navigationItem.title = game.title
        
        //Rellamos los datos que tenemos
        titleLabel.text = game.title
        thumbnailImageView.loadFrom(url: game.thumbnail)
        genreLabel.text = game.genre
        publisherLabel.text = game.publisher
        developerLabel.text = game.developer

        Task {
            game = await GameService.getGameByID(game.id)
            
            DispatchQueue.main.async {
                self.loadData()
                
            }
        }
        
    }
    
    func loadData() {
        descriptionLabel.text = game.description
        
        
    }
    
    @IBAction func showMore (_ sender: UIButton){
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 5
            sender.setTitle("Show more", for: .normal)
            
        }else {
            descriptionLabel.numberOfLines = 0
            sender.setTitle("Show less", for: .normal)
            
        }
    }

}
