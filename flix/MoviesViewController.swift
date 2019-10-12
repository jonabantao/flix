//
//  ViewController.swift
//  flix
//
//  Created by Jonathan Abantao on 10/12/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovies()
    }

    // MARK: -Private Functions
    private func loadMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            if let movies = dataDictionary["results"] as? [[String:Any]] {
                self.movies = movies
            }

              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
}

