import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private let GifManager = GifAPIClient.shared
    
    private let gifView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    init(searchResult: SearchResult) {
        super.init(nibName: nil, bundle: nil)
        title = "Gif Info Details"
        view.backgroundColor = .systemBackground
        // Download the details from the gif id
        GifManager.getGifs(newSession: false, url: Constants.searchByGifURL(searchResult.id), type: APIGifInfoResponse.self) { [weak self] result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.setLabel(from: data.data)
                    // KingFisher to download from the gif url
                    self?.gifView.kf.setImage(with: data.data.images.downsized_large.url, placeholder: nil)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(gifView)
        view.addSubview(label)
        gifView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(gifView.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
        }
    }
    
    private func setLabel(from data: GifInfo) {
        gifView.snp.makeConstraints({ make in
            make.height.equalTo(Int(data.images.downsized_large.height)!)
        })
        label.text = "Title: \(data.title)\nSource: \(data.source_tld)\nRating: \(data.rating)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
