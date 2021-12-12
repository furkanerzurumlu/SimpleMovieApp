//
//  ViewController.swift
//  SimpleMovieApp
//
//  Created by Furkan Erzurumlu on 10.12.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    var viewModel: MainVMDelegate = MainVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupUI()
    }

}

// Setup UI Arayüz
extension ViewController {
    func setupVM() {
        viewModel.delegate = self
        viewModel.getUpcomingData()
    }
    
    func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isNavigationBarHidden = true
        sliderCollectionView.register(SliderCell.nib, forCellWithReuseIdentifier: SliderCell.identifier)
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.collectionViewLayout = getCollectionViewLayout()
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


// Collection View Data Source Delegate
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
        //TIKLANDIĞI ZAMAN
    }
    
    
}


// HOMEVM Delegate'i
extension ViewController: MainVMDelegateOutputs {
    func successHeader(_ response: UpcomingRespnse) {
        sliderCollectionView.reloadData()
    }
    
    
}
