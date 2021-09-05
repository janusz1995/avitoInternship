//
//  ViewController.swift
//  avitoIntership
//
//  Created by Janusz on 9/1/21.
//

import UIKit
import SnapKit

//private var countCells = 4
let sideConstraint = 10
let host = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
let session = URLSession.shared

enum Fonts: CGFloat {
    case title = 24
    case basic = 17
}

let m = model(company: Company(name: "avito", employees: [Employee(name: "Jack", phoneNumber: "12345", skills: ["Kotlin", "Android", "Java"]), Employee(name: "Rasel", phoneNumber: "678910", skills: ["iOS", "Swift"])]))

class ViewController: UIViewController {

    private var companyModel: model? = nil
    private var countCells = m.company.employees.count

    private let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 10.0
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        getCall()
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
            make.left.equalTo(view.safeAreaLayoutGuide).offset(sideConstraint)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-sideConstraint)
            make.height.equalTo(50)
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellTableView.self, forCellReuseIdentifier: "CellTableView")
        tableView.isScrollEnabled = false
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(sideConstraint)
            make.right.equalTo(view).offset(-sideConstraint)
            make.top.equalTo(view).offset(100)
            make.bottom.equalTo(view).offset(-10)
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
                self.countCells = cm.company.employees.count
                print(self.countCells)
                print(json)
//                heightTV = countCells * heightCell
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    print(countCells)
//                }
//                countCells = json.company.employees.count
            } catch {
                print("Error json :(")
            }
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
//                print("The Response is : ",json)
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//            print(responseData)
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
        let empoyer = m.company.employees[indexPath.row]
        cell.setupCell(name: empoyer.name, phone: empoyer.phoneNumber, skills: empoyer.skills)
//        cell.setupCell(labelForCell: sideMenuButtonArray[indexPath.row].label, pathForImage: sideMenuButtonArray[indexPath.row].iconName)
//        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        cell.selectionStyle = .none
        return cell
    }
}

