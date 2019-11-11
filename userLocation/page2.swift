//
//  page2.swift
//  userLocation
//
//  Created by Moses Park on 1/5/19.
//  Copyright © 2019 Moses Park. All rights reserved.
//

import UIKit
import WebKit
class page2: UIViewController {


    //@IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webView2: WKWebView!



    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // -------------    WEB PAGE ONE
        var zip = UserDefaults.standard.string(forKey: "zipCode")
        let url_1 = "https://www.realtor.com/realestateandhomes-search/" + zip!
        let request1 = URLRequest(url: URL(string: url_1)!)
        self.webView.load(request1)
        
        
        
        // -------------    WEB PAGE TWO
        var state = UserDefaults.standard.string(forKey: "state")
        var city = UserDefaults.standard.string(forKey: "city")
        // this for loop is for inserting '-' in between city name if the name is more than one word
        // this is necessary because it is the needed format for neighborhoodscout.com's  URL
        var cityDash = ""
        for char in city! {
            if char == " "
            {
                cityDash.append("-")
            }
                
            else {
                cityDash.append(char)
            }
        }
        
        let url_2 = "https://www.neighborhoodscout.com/" + state! + "/" + cityDash
        let request2 = URLRequest(url: URL(string: url_2)!)
        self.webView2.load(request2)
        

        
        

        
        
        
 
        
        // Do any additional setup after loading the view.
    }
    

    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
