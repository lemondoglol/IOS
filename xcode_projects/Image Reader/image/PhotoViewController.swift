//
//  PhotoViewViewController.swift
//  image
//
//

import UIKit


class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
     var imageView = UIImageView()

    // set imageURL
    var imageURL: URL? {
        didSet {
            image = nil
            let session = URLSession(configuration: .default)
            if let url = imageURL {
                let task = session.dataTask(with: url) { (data: Data?, resp, error) in
                    if let goodData = data {
                        DispatchQueue.main.async {
                            self.image = UIImage(data: goodData)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.bounds.size

            scrollView.addSubview(imageView)
            
            scrollView.maximumZoomScale = 4
            scrollView.minimumZoomScale = 0.5
            scrollView.delegate = self
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
            recognizer.numberOfTapsRequired = 1
            recognizer.numberOfTouchesRequired = 1
            scrollView.addGestureRecognizer(recognizer)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if imageURL == nil {
            imageURL = Bundle.main.url(forResource: "falconBig", withExtension: "jpg")
        }
    }
    
    @objc func tap(recog: UITapGestureRecognizer) {
        if recog.state == .ended  {
            let location = recog.location(in: scrollView)

            let pt = imageView.convert(location, from: scrollView)
            let visible = imageView.convert(scrollView.bounds, from: scrollView)
            scrollView.contentOffset.x += (pt.x - visible.midX) * scrollView.zoomScale
            scrollView.contentOffset.y += (pt.y - visible.midY) * scrollView.zoomScale
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
