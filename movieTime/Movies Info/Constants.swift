//
//  Constants.swift
//  Api key and get Movies  Info method
//
//  Created by Begum
//  Copyright © 2021 begum. All rights reserved.
//

import Foundation

struct Constants {
    
    // tmdb.org api key
    static let API_KEY = "39b1643c4474d3dbb71f66535a71733c"
    
    // tmdb.org base url adress
    static let BASE_URL = "https://api.themoviedb.org/3/movie/"
    
    // search base url
    static let MOVIE_SEARCH_BASE_URL = "https://api.themoviedb.org/3/search/movie"
    
    // movie images hosting url
    static let IMAGES_BASE_URL = "https://image.tmdb.org/t/p/"
    
    static let BACK_DROP_BASE_URL = IMAGES_BASE_URL + "w500"
    static let POSTER_BASE_URL = IMAGES_BASE_URL + "w185"
    
    static let KEY_POPULAR = "popular"
    // get popular movies
    
    static let KEY_UPCOMING = "upcoming"
    // get upcoming movies
    
    static let KEY_TOP_RATED = "top_rated"
    // get top rated movies
   
    static let KEY_NOW_PLAYING = "now_playing"
    // get now playing moives
}
