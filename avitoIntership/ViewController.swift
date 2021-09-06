import UIKit
import SnapKit

enum Fonts: CGFloat {
    case title = 24
    case basic = 17
}

class ViewController: UIViewController {

    private let host = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    private let session = URLSession.shared
    private var companyModel: model? = nil
    private var countCells = 0
    private var heightOfTableView: CGFloat = 0.0

    private let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCall()
        setupView()
        setupTableView()
        setupInfoStackView()
    }

    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(infoStackView)
    }

    private func setupInfoStackView() {
        let nameLabel = BasicLabel("Name", Fonts.title.rawValue)
        let phoneLabel = BasicLabel("Phone", Fonts.title.rawValue)
        let skillsLabel = BasicLabel("Skills", Fonts.title.rawValue)

        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(phoneLabel)
        infoStackView.addArrangedSubview(skillsLabel)
        
        infoStackView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellTableView.self, forCellReuseIdentifier: "CellTableView")
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .clear

        tableView.snp.makeConstraints { (make) -> Void in
            make.topMargin.equalTo(infoStackView.snp_bottomMargin).offset(10)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func updateTableView() {
        if let countEmployers = companyModel?.company.employees.count {
            countCells = countEmployers
            companyModel?.company.employees.sort { $0.name < $1.name }
            tableView.reloadData()
        }
    }

    private func getCall() {

        guard let url = URL(string: host) else {
            print("Failed url :(")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }

            guard let responseData = data else {
                print("Error data :(")
                return
            }
            do {
                let json = try JSONDecoder().decode(model.self, from: responseData)
                self.companyModel = json

                guard let cm = self.companyModel else {
                    print("Can`t get company model")
                    return
                }

                DispatchQueue.main.async {
                    self.updateTableView()
                }
            } catch {
                print("Error json :(")
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellTableView", for: indexPath) as? CellTableView
        else {
            fatalError("Don't create CellTableView cell")
        }
        if let employer = companyModel?.company.employees[indexPath.row] {
            cell.setupCell(name: employer.name, phone: employer.phoneNumber, skills: employer.skills)
            if (indexPath.row % 2) == 0 {
                cell.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            }
        }
        return cell
    }
}
