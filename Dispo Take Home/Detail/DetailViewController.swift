import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private let GifManager = GifAPIClient.shared
    
    private let gifView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 10
        return imgView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 16)
        return label
    }()
    
    
    init(searchResult: SearchResult) {
        super.init(nibName: nil, bundle: nil)
        title = "Gif Info Details"
        view.backgroundColor = .systemBackground
        // Download the image and details from search result
        GifManager.getGifs(newSession: false, url: Constants.searchByGifURL(searchResult.id), type: APIGifInfoResponse.self) { [weak self] result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    self?.gifView.kf.setImage(with: data.data.url)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        let stack = UIStackView(arrangedSubviews: [gifView, label])
        stack.axis = .vertical
        stack.distribution = .fill
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
