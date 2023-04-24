//
//  GalleryViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 23.04.2023.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {
    
    // MARK: - Constants
    
    private enum Constants {
        static let navigationItemTile = "MobileUp Gallery"
        static let titleNavigationBarButtom = "Выход"
    }
    
    // MARK: - Properties

    var gallery = GalleryModel.getGallery()
    
    // MARK: - Views
    
    let galleryCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    // MARK: - Methods
    
}

private extension GalleryViewController {
    
    func configureAppearance() {
        view.backgroundColor = .white
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: "\(GalleryCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(GalleryCollectionViewCell.self)")
        
        setConstraints()
        configureNavBar()
        updateData()
        
    }
    
    func updateData() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: TokenManager.token),
            URLQueryItem(name: "owner_id", value: "-128666765"),
            URLQueryItem(name: "album_id", value: "266310117"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [ weak self ] (data, response, error) in
            guard let sself = self, let data = data else { return }
            guard let newGallery = try? JSONDecoder().decode(GalleryModel.self, from: data) else { return }
            print("AAAAA: \(newGallery.response.items.count)")
            sself.gallery = newGallery
            
            DispatchQueue.main.async { [ weak self] in
                self?.galleryCollectionView.reloadData()
            }
        }
        task.resume()
        
        print("HHH: \(self.gallery.response.items.count)")
    }
    
    func configureNavBar() {
        let rightBarButtonItem = UIBarButtonItem(title: Constants.titleNavigationBarButtom, style: .plain, target: self, action: #selector(exitButton))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.navigationItem.title = Constants.navigationItemTile
    }
    
    func setConstraints() {
        view.addSubview(galleryCollectionView)
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func exitButton() {
        TokenManager.token = ""
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .overFullScreen
        self.dismiss(animated: false)
        present(mainVC, animated: true)
        
        print("EXIT")
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.response.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "\(GalleryCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let sizeNumber = gallery.response.items[indexPath.row].sizes.count - 1
        cell.imageURLString = gallery.response.items[indexPath.row].sizes[sizeNumber].url
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moreInfoVC = MoreInfoViewController()
        moreInfoVC.creationDate = gallery.response.items[indexPath.row].date
        let sizeNumber = gallery.response.items[indexPath.row].sizes.count - 1
        moreInfoVC.imageURLString = gallery.response.items[indexPath.row].sizes[sizeNumber].url
        navigationController?.pushViewController(moreInfoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 2 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}
