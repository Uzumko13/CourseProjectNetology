
import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Info Data
    
    private var infoTitle = title3
    private var info = infoText
    
    //MARK: Subviews
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleInfo = UILabel()
    private let textInfo = UILabel()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
}
    //MARK: Setup method

private extension InfoViewController {
    
    func setupLayout() {
        setupView()
        addSubview()
        configureScrollView()
        configureContentView()
        configureTitleInfo()
        configureTextInfo()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "LigthGray2")
        navigationItem.title = "Информация"
        navigationController?.navigationBar.barTintColor = UIColor(named: "GrayHeader")
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func addSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleInfo)
        contentView.addSubview(textInfo)
    }
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureTitleInfo() {
        titleInfo.translatesAutoresizingMaskIntoConstraints = false
        titleInfo.textAlignment = .left
        titleInfo.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleInfo.textColor = .black
        titleInfo.text = infoTitle
        
        NSLayoutConstraint.activate([
            titleInfo.widthAnchor.constraint(equalToConstant: 218),
            titleInfo.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureTextInfo() {
        textInfo.translatesAutoresizingMaskIntoConstraints = false
        textInfo.textAlignment = .left
        textInfo.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textInfo.textColor = .black
        textInfo.text = info
        textInfo.numberOfLines = 0
    }
    
    func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            textInfo.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 16),
            textInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textInfo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}

