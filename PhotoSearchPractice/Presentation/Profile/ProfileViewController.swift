//
//  ProfileViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit
import Then

final class ProfileViewController: BaseViewController, PassBirthdayDelegate {
    
    private let nicknameButton = UIButton()
    private let birthdayButton = UIButton()
    private let levelButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let birthdayLabel = UILabel()
    private let levelLabel = UILabel()
    private var config = UIButton.Configuration.plain()
    private var isCancel = false
    
    private var nickname = Nickname(text: "NO NAME") {
        didSet {
            nicknameLabel.text = nickname.text.isEmpty ? "NO NAME" : nickname.text
        }
    }
    private var birthday = Birthday(date: Date(), text: "NO DATE") {
        didSet {
            birthdayLabel.text = birthday.text.isEmpty ? "NO DATE" : birthday.text
        }
    }
    private var level = Level(index: 0, text: "NO LEVEL") {
        didSet {
            levelLabel.text = level.text.isEmpty ? "NO LEVEL" : level.text
        }
    }
    
    @objc private func okButtonTapped() {
        print(#function)
        UserDefaultsManager.shared.resetProfile()
        isCancel.toggle()
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = scene.windows.first else { return }
        window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        window.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNotificationCenter()
        getProfile()
    }

    deinit {
        // TODO: 그룹의 리브나 엔터가 남아있는지? 확인 필요. 만약 남아있다면 여러번 반복하는 과정에서 엣지 케이스 생길 수 있음.
        print(#function)
        if isCancel {
        } else {
            self.saveProfile()
        }
    }
    
    override func configHierarchy() {
        [ nicknameButton, birthdayButton, levelButton, nicknameLabel, birthdayLabel, levelLabel ].forEach { view.addSubview($0) }
    }
    
    override func configLayout() {
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
    }
    
    override func configView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.largeTitleDisplayMode = .inline
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(okButtonTapped))
        
        config.baseForegroundColor = .black
        config.background.backgroundColor = .clear
        
        nicknameButton.do {
            config.title = "닉네임"
            $0.configuration = config
            $0.tag = 0
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        birthdayButton.do {
            config.title = "생일"
            $0.configuration = config
            $0.tag = 1
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        levelButton.do {
            config.title = "레벨"
            $0.configuration = config
            $0.tag = 2
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        nicknameLabel.do {
            $0.textColor = .lightGray
            $0.textAlignment = .right
        }
        
        birthdayLabel.do {
            $0.textColor = .lightGray
            $0.textAlignment = .right
        }
        levelLabel.do {
            $0.textColor = .lightGray
            $0.textAlignment = .right
        }
    }
    
    private func configNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveLevelNotification), name: NSNotification.Name("level"), object: nil)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = NicknameViewController()
            vc.nickname = self.nickname
            vc.contents = {
                self.nickname.text = $0
            }
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 1:
            let vc = BirthdayViewController()
            vc.birthday = self.birthday
            vc.contents = self
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 2:
            let vc = LevelViewController()
            vc.level = self.level
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            return
        }
    }
    
    @objc private func receiveLevelNotification(notification: NSNotification) {
        print(#function, "신호받음")
        if let index = notification.userInfo!["index"] as? Int,
           let text = notification.userInfo!["text"] as? String {
            level.index = index
            level.text = text
        } else {
            level.index = -1
            level.text = "레벨 설정 오류! 레벨을 다시 설정해주세요."
        }
    }
    
    private func getProfile() {
        if let nickname = UserDefaultsManager.shared.getProfile(kind: .nickname, type: Nickname.self) {
            self.nickname = nickname
        } else {
            self.nickname = Nickname(text: "NO NAME")
        }
        if let birthday = UserDefaultsManager.shared.getProfile(kind: .birthday, type: Birthday.self) {
            self.birthday = birthday
        } else {
            self.birthday = Birthday(date: Date(), text: "NO DATE")
        }
        if let level = UserDefaultsManager.shared.getProfile(kind: .level, type: Level.self) {
            self.level = level
        } else {
            self.level = Level(index: 0, text: "NO LEVEL")
        }
    }
    
    private func saveProfile() {
        print(#function)
        UserDefaultsManager.shared.setProfile(kind: .nickname, type: Nickname.self, data: nickname)
        UserDefaultsManager.shared.setProfile(kind: .birthday, type: Birthday.self, data: birthday)
        UserDefaultsManager.shared.setProfile(kind: .level, type: Level.self, data: level)
    }
    
    // MARK: PassBirthdayDelegate
    func receiveBirthday(value: String, date: Date) {
        birthday.text = value
        birthday.date = date
    }
    
}
