//
//  ViewController.swift
//  flix
//
//  Created by Jonathan Abantao on 10/12/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadMovies()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as! MoviesCell
        
        let movie = movies[indexPath.row]
        
        if let title = movie["title"] as? String {
            cell.titleLabel.text = title
        }
        
        if let synopsis = movie["overview"] as? String {
            cell.synopsisLabel.text = synopsis
        }
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!

        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
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

            self.tableView.reloadData()
           }
        }
        task.resume()
    }

}

