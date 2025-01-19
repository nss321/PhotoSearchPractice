//
//  SearchViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then

class SearchViewController: BaseViewController {
    
    var photoList: Photo = Photo(total: 0, total_pages: 0, results: []) {
        didSet {
            collectionView.reloadData()
            print("reloaded")
        }
    }
    
    override func configHierarchy() {
        [horizontalScrollView, verticalScrollView, collectionView].forEach { view.addSubview($0) }
        horizontalScrollView.addSubview(horizontalStackView)
        verticalScrollView.addSubview(verticalStackView)
        
        [blackButton, whiteButton, yellowButton, redButton, purpleButton, greenButton, blueButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
    }
    
    override func configLayout() {
        horizontalScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(32)
        }
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(horizontalScrollView.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configView() {
        super.configView()
        searchController.searchBar.delegate = self
        self.navigationItem.title = "SEARCH PHOTO"
        self.navigationItem.searchController = searchController
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        horizontalStackView.spacing = 4
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        NetworkService.shared.searchPhotos(keyword: searchBar.text!) {
            self.photoList = $0
        }
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = photoList.results[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.id, for: indexPath) as! ResultCollectionViewCell
        
        cell.config(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let item = photoList.results[indexPath.item]
        NetworkService.shared.photoDetail(id: item.id) {
            vc.photoDetail = $0
        }
        vc.givenPhotoInfo = item
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (Int(UIScreen.main.bounds.width) - 2) / 2,
               height: Int(UIScreen.main.bounds.height / 3.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
}
