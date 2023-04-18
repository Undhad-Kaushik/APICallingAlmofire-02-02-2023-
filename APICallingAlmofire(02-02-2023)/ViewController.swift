//
//  ViewController.swift
//  APICallingAlmofire(02-02-2023)
//
//  Created by undhad kaushik on 02/02/23.
//




import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var userTabelView: UITableView!
    var arrUsers: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        callLoginApi()
//getUsers()
        callEmployeeDetaialsAPI()
    }

    private func getUsers(){
        AF.request("https://gorest.co.in/public/v2/users").responseData { response in debugPrint("Response: \(response)")
            guard let apiData = response.data else { return }
            do {
                self.arrUsers = try JSONDecoder().decode([User].self, from: apiData)
                self.userTabelView.reloadData()
            }catch{
                print("Parsing Error")
            }
        }
    }

    private func getUserss(){
        AF.request("https://reqres.in/api/users/1").responseData { response in debugPrint("Response: \(response)")
            guard let apiData = response.data else { return }
            do{
                self.arrUsers = try JSONDecoder().decode([User].self, from: apiData)
                self.userTabelView.reloadData()
            }catch{
                print("Parsing Error")
            }
        }
    }
    
    private func callEmployeeDetaialsAPI(){
        let parameters: Parameters = ["name": "Terenaam", "job": "Avarapan"]
        AF.request("https://reqres.in/api/users",method: .post ,parameters: parameters).responseData{
            response in
            debugPrint("Response: \(response)")
            if response.response?.statusCode == 201 {
                guard let apiData = response.data else { return }
                do{
                    let employeeDetails = try JSONDecoder().decode(LoginApiResponse.self, from: apiData)
                    print(employeeDetails)
                }catch{
                    print("Parsing error")
                }
            }else {
                print("Tame Kai Locho Karelo")
            }
        }
    }
    
    private func callLoginApi(){
        let parameters: Parameters = ["email": "eve.holt@reqres.in", "password": "cityslicka"]
        AF.request("https://reqres.in/api/login",method: .post ,parameters: parameters).responseData{
            response in
            debugPrint("Response: \(response)")
            if response.response?.statusCode == 200 {
                guard let apiData = response.data else { return }
                do{
                    let loginApiResponse = try JSONDecoder().decode(LoginApiResponse.self, from: apiData)
                    print(loginApiResponse)
                }catch{
                    print("Parsing error")
                }
            }else {
                print("Tame Kai Locho Karelo")
            }
        }
    
    }
}

extension ViewController: UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
//        let rowDictionary = arrUsers[indexPath.row]

        let user = arrUsers[indexPath.row]
        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.text = rowDictionary["name"] as! String
        cell.textLabel?.text = "\(user.name) \n \(user.email)"
        return cell
    }
}


struct EmployeeDetails: Decodable{
    var name: String
    var job: String
    var id: String
    var createdAT: String
}

struct LoginApiResponse: Decodable{
    var token: String
    
}
