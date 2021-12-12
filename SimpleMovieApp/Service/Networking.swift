//
//  Networking.swift
//  SimpleMovieApp
//
//  Created by Furkan Erzurumlu on 11.12.2021.
//

import Foundation
import Alamofire

class Networking {
    
    static let apikey = "?api_key=1b7f60158ff1adf106fef575bc3fabbd"
    static let upcoming = "https://api.themoviedb.org/3/movie/upcoming" + apikey
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    static let nowplay = "https://api.themoviedb.org/3/movie/now_playing" + apikey
    
    func getUpcoming(completion: @escaping (UpcomingRespnse?, String?) -> ()) { // geri gönderme sırası movie text
        let request = AF.request(Networking.upcoming)
        request.responseDecodable(of: UpcomingRespnse.self) { (response) in
            guard let movie = response.value else {
                completion(nil, response.error?.localizedDescription) // response yok, hata mesajı var
                return
            }
            completion(movie,nil) // hata mesajı yok response var
          }
    }
    
    func getNowplaying(completion: @escaping (NowplayingResponse?, String?) -> ()){
        let request = AF.request(Networking.nowplay)
        request.responseDecodable(of: NowplayingResponse.self) { (response) in
            guard let movie = response.value else {
                completion(nil, response.error?.localizedDescription) // response yok, hata mesajı var
                return
            }
            completion(movie,nil) // hata mesajı yok response var
          }
    }
        
    
}
