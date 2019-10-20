//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Jonathan Abantao on 10/18/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    var trailerId: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!

        posterImageView.af_setImage(withURL: posterUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropImageView.af_setImage(withURL: backdropUrl!)
        
        Alamofire.request("https://api.themoviedb.org/3/movie/\(movie["id"]!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
            .responseJSON { response in
                if let value = response.result.value as? [String:Any], let videos = value["results"] as? [Any] {
                    for video in videos {
                        if let videoInfo = video as? [String:Any] {
                            let videoType = videoInfo["type"] as! String
                            let videoId = videoInfo["key"] as! String
                        
                            if videoType == "Trailer" {
                                self.trailerId = videoId
                                break
                            }
                        }
                    }
                }
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let trailerViewController = segue.destination as? MovieTrailerViewController {
            trailerViewController.trailerId = self.trailerId
        }
    }
}
