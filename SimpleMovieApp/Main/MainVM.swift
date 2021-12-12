//
//  MainVM.swift
//  SimpleMovieApp
//
//  Created by Furkan Erzurumlu on 12.12.2021.
//

import Foundation

protocol MainVMDelegate { // viewcontroller da dinleyeceğimiz yada çağıracağımız fonksiyonlar
    var delegate: MainVMDelegateOutputs? { get set }
    var upcomingDataResponse: [UpcomingResult] { get set }
    var nowPlayingDataResponse: [NowplayinResult] { get set }
    func getUpcomingData()
    func getNowPlayingData()
}

protocol MainVMDelegateOutputs: AnyObject {
    func successHeader(_ response: UpcomingRespnse) // view controller'a göndereceğimiz fonksiyonlar
    func successNowPlaying(_ repsonse: NowplayingResponse)
    
}

class MainVM: MainVMDelegate {
    var delegate: MainVMDelegateOutputs?
    var network: Networking = Networking()
    var upcomingDataResponse: [UpcomingResult] = []
    var nowPlayingDataResponse: [NowplayinResult] = []
    
    func getUpcomingData() {
        network.getUpcoming(completion: { (response, error) in
            guard let response = response else {
                print("HATA upcoming", error)
                return
            }
            self.upcomingDataResponse = response.results
            self.delegate?.successHeader(response)
        })
    }
    
    func getNowPlayingData() {
        network.getNowplaying(completion: { (response, error) in
            guard let response = response else {
                print("HATA nowPlaying", error)
                return
            }
            self.nowPlayingDataResponse = response.results
            self.delegate?.successNowPlaying(response)
            
        })
    }
}
