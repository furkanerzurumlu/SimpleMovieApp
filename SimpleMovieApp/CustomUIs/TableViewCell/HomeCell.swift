//
//  HomeCell.swift
//  SimpleMovieApp
//
//  Created by Furkan Erzurumlu on 12.12.2021.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet private weak var filmImage: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmInfo: UITextView!
    @IBOutlet weak var filmDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ayarla(data: NowplayinResult) {
        filmImage.load(url: URL(string: Networking.imageUrl + data.posterPath)!)
        filmName.text = data.originalTitle
        filmInfo.text = data.overview
        filmDate.text = data.releaseDate
    }
    
}

extension HomeCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
