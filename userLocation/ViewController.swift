//
//  ViewController.swift
//  userLocation
//
//  Created by Moses Park on 1/5/19.
//  Copyright © 2019 Moses Park. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    var userLocation = ""
    
    // Map
    @IBOutlet weak var map: MKMapView!

    @IBOutlet weak var currentAddress: UILabel!
    
    // Related to Location Data
    let manager = CLLocationManager()
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        getAddressFromLatLon(pdblLatitude: String(location.coordinate.latitude), withLongitude: String(location.coordinate.longitude))
        
    }
    
    
//    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
//        -> Void ) {
//        // Use the last reported location.
//        if let lastLocation = self.manager.location {
//            let geocoder = CLGeocoder()
//
//            // Look up the location and pass it to the completion handler
//            geocoder.reverseGeocodeLocation(lastLocation,
//                                            completionHandler: { (placemarks, error) in
//                                                if error == nil {
//                                                    let firstLocation = placemarks?[0]
//                                                    completionHandler(firstLocation)
//                                                }
//                                                else {
//                                                    // An error occurred during geocoding.
//                                                    completionHandler(nil)
//                                                }
//            })
//        }
//        else {
//            // No location was available.
//            completionHandler(nil)
//        }
//    }

    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var addressString : String = ""
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
//                    print(pm.country)
//                    print(pm.locality)
//                    print(pm.subLocality)
//                    print(pm.thoroughfare)
//                    print(pm.postalCode)
//                    print(pm.subThoroughfare)
                    
//                    if pm.subLocality != nil {
//                        addressString = addressString + pm.subLocality! + ", "
//                    }
                    if pm.subThoroughfare != nil {
                        addressString = addressString + pm.subThoroughfare! + " "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    /*if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    } */
                    
                    if pm.administrativeArea != nil {
                     addressString = addressString + pm.administrativeArea! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    

                    //print(addressString)
                    self.currentAddress.text = addressString
                    
                    UserDefaults.standard.set(pm.postalCode, forKey: "zipCode")
                    UserDefaults.standard.set(pm.administrativeArea, forKey: "state")
                    UserDefaults.standard.set(pm.locality, forKey: "city")
                    
                }
        })
        
    }
  
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    
    }


}

