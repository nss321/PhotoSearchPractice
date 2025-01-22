//
//  SearchViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then

final class SearchViewController: BaseViewController {
    
    private var photoList: Photo = Photo(total: 0, total_pages: 0, results: []) {
        didSet {
            if photoList.results.isEmpty {
                searchView.notiLabel.isHidden = false
                searchView.notiLabel.text = "검색 결과가 없어요."
            } else {
                searchView.notiLabel.isHidden = true
                searchView.notiLabel.text = ""
            }
            searchView.collectionView.reloadData()
            print("reloaded")
        }
    }
    private var searchedKeyword = ""
    private var page: Int = 1
    private var currentPage: Int {
        photoList.results.count
    }
    
    private var orderButtonTapped = false {
        didSet {
            searchView.searchController.searchBar.text = searchedKeyword
            searchView.orderButton.setTitleColor(.black, for: .normal)
            searchView.orderButton.setTitle(orderButtonTapped ? "관련순":"최신순", for: .normal)
            searchView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            NetworkService.shared.orderedSearchPhotos(api: .orderedSearch(query: self.searchedKeyword, orderBy: self.orderButtonTapped)) { Photo in
                self.photoList = Photo
            }
        }
    }
    
    private let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configView() {
        self.navigationItem.title = "SEARCH PHOTO"
        self.navigationItem.searchController = searchView.searchController
        searchView.orderButton.addAction(UIAction(handler: { [self] _ in
            if searchedKeyword.isEmpty {
                showAlert(title: "검색어 없음", message: "검색한 내역이 없습니다.\n검색을 먼저 해주세요.", handler: nil)
            } else {
                orderButtonTapped.toggle()
            }
        }), for: .touchUpInside)
    }
    
    override func configDelegate() {
        searchView.searchController.searchBar.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.prefetchDataSource = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchedKeyword = searchBar.text!
        if searchedKeyword.isEmpty {
            showAlert(title: "검색어 없음", message: "검색한 내역이 없습니다.\n검색을 먼저 해주세요.", handler: nil)
        } else {
            NetworkService.shared.orderedSearchPhotos(api: .orderedSearch(query: searchedKeyword, orderBy: orderButtonTapped)) { Photo in
                self.photoList = Photo
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedKeyword = ""
        orderButtonTapped = false
        self.photoList.results.removeAll()
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
        let group = DispatchGroup()
        group.enter()
        NetworkService.shared.photoDetail(id: item.id) {
            vc.photoDetail = $0
            vc.givenPhotoInfo = item
            group.leave()
        }
        group.notify(queue: .main) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (Int(UIScreen.main.bounds.width) - 2) / 2,
               height: Int(imageHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function)
        for item in indexPaths {
            if currentPage - 3 == item.row && currentPage < photoList.total {
                page += 1
                NetworkService.shared.orderedSearchPhotos(api: .orderedSearch(query: searchedKeyword, orderBy: orderButtonTapped, page: page)) { Photo in
                    self.photoList.results.append(contentsOf: Photo.results)
                }
            }
        }
    }
}
