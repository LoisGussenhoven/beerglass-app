//
//  MapViewController.swift
//  NicksBeerGlasses
//
//  Created by Lois Gussenhoven on 19-12-18.
//  Copyright © 2018 Lois Gussenhoven. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setNavigationBar()
        _setMapView()
    }
    
   private func _setNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 52/255, alpha: 1)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        title = "Map"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Hiragino Mincho ProN W6", size: 20)!]
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    private func _setMapView(){
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let (currentLocation, annotation, currentMapPoint) = setFirstLocation()
        let (nextAnnotation, nextMapPoint) = setSecondLocation()
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = currentMapPoint
        directionRequest.destination = nextMapPoint
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
        }
        
        let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotations([annotation,nextAnnotation])
    }
    
    func setFirstLocation() -> (CLLocationCoordinate2D,MKPointAnnotation, MKMapItem){
        let currentLocation = CLLocationCoordinate2D(latitude: -5.582730, longitude: 75.754270)
        let annotation = MKPointAnnotation()
        annotation.title = "Starting place"
        annotation.coordinate = currentLocation
        let currentPlaceMark = MKPlacemark(coordinate: currentLocation)
        let currentMapPoint = MKMapItem(placemark: currentPlaceMark)
        return (currentLocation, annotation, currentMapPoint)
    }
    
    func setSecondLocation() -> (MKPointAnnotation, MKMapItem){
        let nextLocation = CLLocationCoordinate2D(latitude: -55.646473, longitude: 4.7575874)
        let nextAnnotation = MKPointAnnotation()
        nextAnnotation.title = "Next place your going"
        nextAnnotation.coordinate = nextLocation
        let nextPlaceMark = MKPlacemark(coordinate: nextLocation)
        let nextMapPoint = MKMapItem(placemark: nextPlaceMark)
        return (nextAnnotation, nextMapPoint)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 40/255.0, green: 40/255.0, blue: 52/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
}
