import UIKit

class MainViewController: UIViewController {
    
    var objects: [GifObject] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    var GifManager = GifAPIClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        getTrending()
    }
    
    func getTrending() {
        GifManager.getGifs(newSession: true, url: Constants.trendingURL, type: APIListResponse.self) { [weak self] result in
            switch result {
            case .failure(let error):   print(error.localizedDescription)
            case .success(let data):    self?.objects = data.data
            }
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private var layout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GifCell.self, forCellWithReuseIdentifier: NSStringFromClass(GifCell.self))
        return collectionView
    }()
}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: implement
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            getTrending()
        } else {
            GifManager.getGifs(newSession: true, url: Constants.searchByKeyURL(searchText), type: APIListResponse.self) { [weak self] result in
                switch result {
                case .failure(let error):   print(error.localizedDescription)
                case .success(let data):    self?.objects = data.data
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(GifCell.self), for: indexPath) as? GifCell else { fatalError() }
        let gif = objects[indexPath.row]
        cell.setupCell(from: gif)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchRes = objects[indexPath.row].searchFromObject()
        let detailVC = DetailViewController(searchResult: searchRes)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 16, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 8, bottom: 200, right: 8)
    }
}

