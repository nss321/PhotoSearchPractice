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
            if photoList.results.isEmpty {
                notiLabel.isHidden = false
                notiLabel.text = "검색 결과가 없어요."
            } else {
                notiLabel.isHidden = true
                notiLabel.text = ""
            }
            collectionView.reloadData()
            print("reloaded")
        }
    }
    var searchedKeyword = ""
    let notiLabel = UILabel()
    var currentPage: Int {
        photoList.results.count
    }
    
    let orderButton = UIButton()
    var orderButtonTapped = false {
        didSet {
            print(#function)
            orderButton.setTitleColor(.black, for: .normal)
            orderButton.setTitle(orderButtonTapped ? "관련순":"최신순", for: .normal)
            NetworkService.shared.orderedSearchPhotos(keyword: searchedKeyword, orderBy: orderButtonTapped) { Photo in
                self.photoList = Photo
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configHierarchy() {
        super.configHierarchy()
        view.addSubview(notiLabel)
        horizontalScrollView.addSubview(horizontalStackView)
        verticalScrollView.addSubview(verticalStackView)
        
        [blackButton, whiteButton, yellowButton, redButton, purpleButton, greenButton, blueButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        view.addSubview(orderButton)
        
    }
    
    override func configLayout() {
        notiLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
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
        
        orderButton.snp.makeConstraints {
            $0.centerY.equalTo(horizontalStackView.snp.centerY)
            $0.trailing.equalToSuperview().offset(8)
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
        collectionView.prefetchDataSource = self
        notiLabel.text = "사진을 검색해보세요."
        notiLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        orderButton.do {
            var config = UIButton.Configuration.plain()
            config.title = "최신순"
            config.baseForegroundColor = .black
            config.background.backgroundColor = .white
            let image = UIImage(systemName: "line.3.horizontal.decrease.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            config.image = image
            config.background.strokeWidth = 1
            config.background.strokeColor = .gray
            
            $0.configuration = config
            $0.addAction(UIAction(handler: { _ in
                print(#function)
                self.orderButtonTapped.toggle()
            }), for: .touchUpInside)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchedKeyword = searchBar.text!
        NetworkService.shared.searchPhotos(keyword: searchBar.text!) {
            self.photoList = $0
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedKeyword = ""
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

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function)
        for item in indexPaths {
            if currentPage - 3 == item.row {
                NetworkService.shared.searchPhotos(keyword: searchedKeyword) {
                    self.photoList.results.append(contentsOf: $0.results)
                }
            }
        }
    }
}
