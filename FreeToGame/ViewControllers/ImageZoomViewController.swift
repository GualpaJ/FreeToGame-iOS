//
//  ImageZoomViewController.swift
//  FreeToGame
//
//  Created by Tardes on 1/6/26.
//

import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonCloseView: UIButton!
    
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar scrollView para zoom
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // Cargar la imagen
        if let url = imageUrl {
            imageView.loadFrom(url: url)
        }
        
        // Doble tap para zoom
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        tapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tapGesture)
        view.bringSubviewToFront(buttonCloseView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerImage()
    }
    
    // Centrar imagen cuando está en zoom 1x
    func centerImage() {
        // Solo centrar si no estamos haciendo zoom
        /*guard scrollView.zoomScale == 1.0 else {
            scrollView.contentInset = .zero
            return
        }*/
        
        let scrollViewHeight = scrollView.bounds.height
        let imageViewHeight = imageView.bounds.height
        
        if imageViewHeight < scrollViewHeight {
            let topInset = (scrollViewHeight - imageViewHeight) / 2
            scrollView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: topInset, right: 0)
        } else {
            scrollView.contentInset = .zero
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Al hacer zoom, resetear inset
        if scrollView.zoomScale != 1.0 {
            //scrollView.contentInset = .zero
            centerImage()
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // Al terminar el zoom, volver a centrar si es 1x
        if scale == 1.0 {
            centerImage()
        }
    }
    
    // Doble tap para hacer zoom
    @objc func handleDoubleTap() {
        if scrollView.zoomScale == 1.0 {
            scrollView.setZoomScale(3.0, animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
