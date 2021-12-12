//
//  SliderCell.swift
//  SimpleMovieApp
//
//  Created by Furkan Erzurumlu on 12.12.2021.
//

import UIKit

class SliderCell: UICollectionViewCell {
    @IBOutlet weak var backImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ayarlariYap(data: UpcomingResult) {
        // slider resmi backdrop_path
        backImage.load(url: URL(string: Networking.imageUrl + data.backdropPath)!)
    }

}

extension SliderCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
