//
//  MapViewController.swift
//  MyPassport
//
//  Created by Phyllis Hollingshead on 2/27/15.
//  Copyright (c) 2015 Phyllis Hollingshead. All rights reserved.
// 
/////////////////////////////////////////////////////////////////////////
//Edited by Dustin Morgan.
//I commented all of the edits so you could see what it did easier.
//Everything should be working how you wanted it to now.
////////////////////////////////////////////////////////////////////////

import UIKit
import MapKit
import CoreLocation

var locations: [MKPointAnnotation] = []//Make this a global variable. Because it is of type MKAnnotation it can store the name and location as well like I thought in class. Although dictionary is still a bit easier. You could also put this in it's own struct so it's not global.

class MapViewController: UIViewController, MKMapViewDelegate {
    

    @IBOutlet weak var myMapView: MKMapView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userPoint = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.action(_:)))
        userPoint.minimumPressDuration = 2.0
        
        myMapView.addGestureRecognizer(userPoint)
        
        let italy = MKPointAnnotation()
        italy.coordinate = CLLocationCoordinate2DMake(41.8947400, 12.4839000)
        italy.title = "Rome, Italy"
        
        let england = MKPointAnnotation()
        england.coordinate = CLLocationCoordinate2DMake(51.5085300, -0.1257400)
        england.title = "London, England"
        
        let norway = MKPointAnnotation()
        norway.coordinate = CLLocationCoordinate2DMake(59.914225, 10.75256)
        norway.title = "Oslo, Norway"
        
        let spain = MKPointAnnotation()
        spain.coordinate = CLLocationCoordinate2DMake(40.41694, -3.70081)
        spain.title = "Madrid, Spain"
        
        if(locations.isEmpty) {
            //Had to make this an if statement or it would have killed the memory by adding these repeatedly
            locations.append(italy)
            locations.append(england)
            locations.append(norway)
            locations.append(spain)
        }

        
        myMapView.addAnnotations(locations)
        var myRegion = MKCoordinateRegionMakeWithDistance(italy.coordinate, 5500000, 5500000)
        myMapView.setRegion(myRegion, animated: true)
        
        func mapView(_ mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "mapIdentifier")
            return pin
        }

    }
    
    func action(_ gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: self.myMapView)
        let newCoordinate:CLLocationCoordinate2D = myMapView.convert(touchPoint, toCoordinateFrom: myMapView)
        let newAnnotation = MKPointAnnotation()//Make it an MKPointAnnotation
        newAnnotation.coordinate = newCoordinate//Set the coordinate
        var textInAlert: UITextField?//This will be a variable to pass between functions
        
        let alert = UIAlertController(title: "Name Of Point", message: "Choose the name of your point and press ok...", preferredStyle: .alert)
        alert.addTextField { (textField) -> Void in
            //This is a function that makes the text field.
            textInAlert = textField // Passing the variable.
        }
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            //This is a function on pressing the ok button
            newAnnotation.title = textInAlert!.text //Made text field variable the title
            locations.append(newAnnotation)//Append the new annotation to locations
            self.myMapView.removeAnnotations(locations) //Have to remove the annotation to get rid of delay
            self.myMapView.addAnnotations(locations)//Adding back all the annotations
            countries.append(textInAlert!.text!)
        })
        alert.addAction(ok)//Adds the UIAction to alert
        
        present(alert, animated: true, completion: nil)//Calls alert after every press.
        
    }
}


