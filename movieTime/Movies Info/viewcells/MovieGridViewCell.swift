//
//  MovieGridViewCell.swift
//  Movies Info
//
//  Created by Begum
//  Copyright © 2021 Begum. All rights reserved.//

import UIKit

class MovieGridViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel?
    @IBOutlet weak var ratingsLabel: UILabel?
    
    
    func populateViews(movie: Movie) {
        if let posterPath = movie.posterImageUrl() {
            let url = URL(string:posterPath)!
            posterImageView.af_setImage(
                withURL: url,
                placeholderImage: UIImage(named: "movie100brown")!,
                imageTransition: .crossDissolve(0.2)
            )
        }
        yearLabel?.text = movie.relaseYear()
        ratingsLabel?.text = String(format: " %.2f ", movie.voteAverage!)
    }
}

