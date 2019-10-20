//
//  MovieTrailerViewController.swift
//  flix
//
//  Created by Jonathan Abantao on 10/19/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    
    @IBOutlet weak var trailerWebView: WKWebView!
    var trailerId: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        let trailerURL = URL(string: "https://www.youtube.com/watch?v=\(trailerId!)")
        let request = URLRequest(url: trailerURL!)
        trailerWebView.load(request)
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
