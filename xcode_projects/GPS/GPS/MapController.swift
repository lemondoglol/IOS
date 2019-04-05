//
//  MapController.swift
//  GPS
//
//  Created by Admin on 4/2/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var place: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var preViousLocation: CLLocation?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var onOff: UISwitch!
    
    @IBAction func onOffAction(_ sender: UISwitch) {
        if onOff.isOn {
            startTracking()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    @IBAction func mapTypeAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
        } else {
            mapView.mapType = .satellite
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // do not know how to use it
    
        if let loc = place {
            let circle = MKCircle(center: loc, radius: 10)
            mapView.addOverlay(circle)
            centerMap(loc: loc)
            
            // add annotation for a place
            let ann = MKPointAnnotation()
            ann.title = "MMM"
            ann.coordinate = loc
            mapView.addAnnotation(ann)
        }
    }
    
    func startTracking(){
        let status = CLLocationManager.authorizationStatus()
        if onOff.isOn {
            if (status == .authorizedAlways || status == .authorizedWhenInUse) && onOff.isOn {
                locationManager.startUpdatingLocation()
            } else {
                // request before you set those properties
                locationManager.requestWhenInUseAuthorization()
                locationManager.allowsBackgroundLocationUpdates = true
                // still access data, but delay to process if it runs in background
                locationManager.allowDeferredLocationUpdates(untilTraveled: CLLocationDistanceMax, timeout: 10)
            }
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    // focus on the map
    func centerMap(loc: CLLocationCoordinate2D){
        let radius: CLLocationDistance = 300
        let region = MKCoordinateRegion(center: loc, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    // set up annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else {return nil}

        let identifier = "Annotation"	
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) {
            startTracking()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        print("Finished defered")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    var distance = 0.0
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latest = locations.last!
        if preViousLocation != nil {
            // buildin method distance to calculate distance
            let distanceInMeters = preViousLocation?.distance(from: latest) ?? 0
            let distanceInMiles = distanceInMeters * 3.28 / 5280
            // cal time
            let duration = latest.timestamp.timeIntervalSince(preViousLocation!.timestamp)
            let speed = distanceInMiles * (3600.0 / duration)
            distance += distanceInMiles
            distanceLabel.text = String(format: "%.2f miles", distance)
            speedLabel.text = String(format: ".1f mph", speed)
            let coors = [preViousLocation!.coordinate] + locations.map {$0.coordinate}
            // add trace line to map
            mapView.addOverlay(MKPolyline(coordinates: coors, count: coors.count))
            
        }
        preViousLocation = latest
        centerMap(loc: latest.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let poly = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(overlay: poly)
            renderer.lineWidth = 3
            renderer.strokeColor = .red
            return renderer
        } else if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(overlay: circle)
            renderer.lineWidth = 3
            renderer.strokeColor = .blue
            return renderer
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }

}
