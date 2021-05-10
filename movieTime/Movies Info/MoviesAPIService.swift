//
//  MoviesAPIService.swift
//  Movies get Info
//
//  Created by Begüm
//  Copyright © 2021 Begüm. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MoviesAPIService {
    
    typealias MoviesListAPIResult = (moviesList:[Movie] , nextPage: Int?, totalPages:Int)
    
    
    // get movie list method
    class func getMoviesList (moviesType : String, pageNumber: Int ,completion: @escaping (MoviesListAPIResult?) -> Void) {
        let moviesURL = getMoviesListURL(moviesType: moviesType , page: pageNumber)
        Alamofire.request(moviesURL).responseJSON { response in
            var moviesList: [Movie] = []
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                if let moviesJsonList = json["results"].array {
                    for movie in moviesJsonList {
                        moviesList.append(Movie(movieJson: movie))
                    }
                }
                let currentPage = json["page"].int!
                let totalPages = json["total_pages"].int!
                let nextPage = currentPage+1 < totalPages ? currentPage+1 : nil
                completion((moviesList , nextPage , totalPages))
            } else {
                completion(nil)
            }    
        }
    }
    
    
    // get movie details method
    class func getMoreDetailedMovie (movieId : Int, completion: @escaping (Movie?) -> Void) {
        let moviesURL = getMovieDetailsUrl(movieId: movieId)
        Alamofire.request(moviesURL).responseJSON { response in
            if response.result.isSuccess{
                completion (Movie(movieJson: JSON(response.result.value!)))
            }
            else{
                completion(nil)
            }
        }
    }
    
    // get similar movies method
    class func getSimilarMovies (movieId: Int , completion: @escaping ([Movie]?) -> Void) {
        let moviesURL = getSimilarMoviesUrl(movieId:movieId)
        print("About to get similar movies")
        Alamofire.request(moviesURL).responseJSON { response in
            var moviesList: [Movie] = []
            debugPrint(response)
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                if let moviesJsonList = json["results"].array {
                    for movie in moviesJsonList {
                        moviesList.append(Movie(movieJson: movie))
                    }
                }
                completion(moviesList)
            } else {
                completion(nil)
            }
        }
    }
    
    // return movie details  url
    class func getMovieDetailsUrl(movieId: Int) -> String {
        return "\(appendAPIKeyToURL(url: "\(Constants.BASE_URL)\(movieId)", isOneQueryParam: true))&append_to_response=videos"
    }
    
     // return similar details  url
    class func  getSimilarMoviesUrl(movieId: Int) -> String{
        return appendAPIKeyToURL(url: "\(Constants.BASE_URL)\(movieId)/similar", isOneQueryParam: true)
    }
     
     // poster image url
    class func getPosterImageUrl(imagePath: String) -> String {
        return "\(Constants.POSTER_BASE_URL)\(imagePath)"
    }
    // drop image 
    class func getBackDropImageUrl(imagePath: String) -> String {
        return "\(Constants.BACK_DROP_BASE_URL)\(imagePath)"
    }
    
    // get movies list
    class func getMoviesListURL(moviesType: String , page:Int) -> String {
        return appendAPIKeyToURL(url:"\(Constants.BASE_URL)\(moviesType)?page=\(page)" , isOneQueryParam: false)
    }
    
    // api key auth
    class func appendAPIKeyToURL(url: String, isOneQueryParam: Bool) -> String {
        let separator = isOneQueryParam ? "?" : "&"
        return "\(url)\(separator)api_key=\(Constants.API_KEY)"
    }
}

enum MoviesType: String {
    case popular = "popular"
    case upcoming = "upcoming"
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
}
