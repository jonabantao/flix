# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).


---

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [x] (5pts) User can tap a cell to see more details about a particular movie.
- [x] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [x] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [x] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

### App Walkthough GIF
<img src="http://g.recordit.co/4FOSTSbyZ3.gif" width=250><br>

### Notes
Below is probably the worst looking code I've wrote so far while doing iOS development. As this is second week of class, hopefully it will improve in the future:
```
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
```
This code was placed in the `viewDidLoad` func of the `MovieDetailsViewController`. Initially it was placed in the `prepare` func but this caused the modal view to load before the request was completed, which made the `trailerId` not store the key for the trailer.

## Flix Part 1

### User Stories

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [x] (2pt) User can view the app on various device sizes and orientations.
- [x] (1pt) Run your app on a real device.

### App Walkthough GIF
<img src="https://i.imgur.com/ZsP8NJb.gif" width=250><br>
