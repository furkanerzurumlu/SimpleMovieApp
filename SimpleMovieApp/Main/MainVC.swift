//
//  ViewController.swift
//  SimpleMovieApp
//
//  Created by Furkan Erzurumlu on 10.12.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var sliderCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var pageView: UIPageControl!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private var viewModel: MainVMDelegate = MainVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupUI()
    }

}

// Setup UI Arayüz
extension ViewController {
    fileprivate func setupVM() {
        viewModel.delegate = self
        viewModel.getUpcomingData()
        viewModel.getNowPlayingData()
    }
    
    fileprivate func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isNavigationBarHidden = true
        sliderCollectionView.register(SliderCell.nib, forCellWithReuseIdentifier: SliderCell.identifier)
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.collectionViewLayout = getCollectionViewLayout()
        tableView.register(HomeCell.nib, forCellReuseIdentifier: HomeCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width, height: 256.0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nowPlayingDataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        let data = viewModel.nowPlayingDataResponse[indexPath.row]
        cell.ayarla(data: data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.nowPlayingDataResponse[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138.0
    }
    
}


 
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.upcomingDataResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCell.identifier, for: indexPath) as! SliderCell
        cell.ayarlariYap(data: viewModel.upcomingDataResponse[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aktarilacakData = viewModel.upcomingDataResponse[indexPath.row]
        
    }
    
    
}


// HOMEVM Delegate'i
extension ViewController: MainVMDelegateOutputs {
    func successNowPlaying(_ repsonse: NowplayingResponse) {
        tableView.reloadData()
    }
    
    func successHeader(_ response: UpcomingRespnse) {
        sliderCollectionView.reloadData()
    }
    
    
}
