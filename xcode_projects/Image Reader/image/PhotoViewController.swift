//
//  PhotoViewViewController.swift
//  image
//
//

import UIKit


class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    // use imageView to store image
    // and then use scrollView to store imageView so it can scroll and zoom
    var imageView = UIImageView()
    var image: UIImage?
    
//    {
//        get {
//            return imageView.image
//        }
//        set {
//            imageView.image = newValue
//            // have to add it, or its going to blank
//            // Resizes and moves the receiver view so it just encloses its subviews.
//            imageView.sizeToFit()
//        }
//    }
    
    // set imageURL
    var imageURL: URL? {
        didSet {
            // new way
            let data = try? Data(contentsOf: imageURL!)
            image = UIImage(data: data!)
            imageView.image = image
            imageView.sizeToFit()
            // old way
//            let session = URLSession(configuration: .default)
//            if let url = imageURL {
//                let task = session.dataTask(with: url) { (data: Data?, resp, error) in
//                    if let goodData = data {
//                        DispatchQueue.main.async {
//                            self.image = UIImage(data: goodData)
//                        }
//                    }
//                }
//                task.resume()
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if imageURL == nil {
            imageURL = Bundle.main.url(forResource: "falconBig", withExtension: "jpg")
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.bounds.size
            scrollView.addSubview(imageView)
            
            scrollView.maximumZoomScale = 5
            scrollView.minimumZoomScale = 0.5
            scrollView.delegate = self
        }
    }
    // for zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
