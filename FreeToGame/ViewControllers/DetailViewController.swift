//
//  DetailViewController.swift
//  FreeToGame
//
//  Created by Tardes on 29/5/26.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    @IBOutlet weak var systemRequirementsOsLabel: UILabel!
    @IBOutlet weak var systemRequirementsProcessorLabel: UILabel!
    @IBOutlet weak var systemRequirementsMemoryLabel: UILabel!
    @IBOutlet weak var systemRequirementsGraphicsLabel: UILabel!
    @IBOutlet weak var systemRequirementsStorageLabel: UILabel!
    
    
    
    
    
    @IBOutlet var roundedViews: [UIView]!
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in roundedViews{
            view.layer.cornerRadius = 10
        }
        
        //configuracion del collectionView
        screenshotsCollectionView.dataSource = self
        screenshotsCollectionView.delegate = self
        
        navigationItem.title = game.title
        
        //Rellamos los datos que tenemos
        titleLabel.text = game.title
        thumbnailImageView.loadFrom(url: game.thumbnail)
        genreLabel.text = game.genre
        publisherLabel.text = game.publisher
        developerLabel.text = game.developer
        
        // Colocamos aqui los datos para que nada mas entrar a la pantalla cargue estos datos
        systemRequirementsOsLabel.text = "Not avaible"
        systemRequirementsProcessorLabel.text = "Not avaible"
        systemRequirementsMemoryLabel.text = "Not avaible"
        systemRequirementsGraphicsLabel.text = "Not avaible"
        systemRequirementsStorageLabel.text = "Not avaible"

        Task {
            game = await GameService.getGameByID(game.id)
            
            DispatchQueue.main.async {
                self.loadData()
                
            }
        }
        
    }
    
    func loadData() {
        descriptionLabel.text = game.description
        
        // Como son valores opcionales, lo solventamos con un if
        if let systemRequirements = game.systemRequirements {
            systemRequirementsOsLabel.text = systemRequirements.os
            systemRequirementsProcessorLabel.text = systemRequirements.processor
            systemRequirementsMemoryLabel.text = systemRequirements.memory
            systemRequirementsGraphicsLabel.text = systemRequirements.graphics
            systemRequirementsStorageLabel.text = systemRequirements.storage
        }
        screenshotsCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let screenshots = game.screenshots {
            return screenshots.count
        }else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Screenshots Cell", for: indexPath) as! ScreenshotsViewCell
        let screenshot = game.screenshots![indexPath.row]
        cell.render(with: screenshot.image)
        return cell
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
    
    @IBAction func share(_ sender: Any) {
        let textToShare = [game.profileUrl]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func playNow(_ sender: Any) {
        if let url = URL (string: game.gameUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    //Este bloque para image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("✅ Tap detectado en índice: \(indexPath.row)")
        
        // 🔥 Vibración al abrir el zoom
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        guard let screenshot = game.screenshots?[indexPath.row] else { return }
        
        let zoomVC = storyboard?.instantiateViewController(withIdentifier: "ImageZoomViewController") as! ImageZoomViewController
        zoomVC.imageUrl = screenshot.image
        zoomVC.modalPresentationStyle = .fullScreen
        zoomVC.modalTransitionStyle = .crossDissolve
        
        present(zoomVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ScreenshotsViewCell {
            UIView.animate(withDuration: 0.1) {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ScreenshotsViewCell {
            UIView.animate(withDuration: 0.1) {
                cell.transform = .identity
            }
        }
    }
}
