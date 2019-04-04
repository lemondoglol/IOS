//
//  PhotoViewViewController.swift
//  image
//
//

import UIKit


class PhotoViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL? {
        didSet {
            image = nil
            
            print("1")
            let session = URLSession(configuration: .default)
            if let url = imageURL {
                let task = session.dataTask(with: url) { (data: Data?, resp, error) in
                    print("2")
                    if let goodData = data {
                        print("3")
                        DispatchQueue.main.async {
                            print("4")
                            self.image = UIImage(data: goodData)
                            print("5")
                        }
                        print("6")
                    }
                }
                task.resume()
                print("7")
            }
            print("8")
        }
    }
    
    

//    var imageURL: URL? {
//        didSet {
//            image = nil
//
//            print("1")
//            DispatchQueue.global(qos: .userInitiated).async {
//                print("2")
//                if let data = try? Data(contentsOf: self.imageURL!) {
//                    print("3")
//                    DispatchQueue.main.async {
//                        print("4")
//                        self.image = UIImage(data: data)
//                        print("5")
//                    }
//                    print("6")
//                }
//                print("7")
//            }
//            print("8")
//        }
//    }
//
//
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }

    var imageView = UIImageView()
    
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
