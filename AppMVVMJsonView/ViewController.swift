//
//  ViewController.swift
//  AppMVVMJsonView
//
//  Created by Admin on 29.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var myTableView = UITableView()
    var structJson = [jsonStruct]()
    let indetifire = "MyCell"
    var myScrollView = UIScrollView()
    let screenSize = UIScreen.main.bounds
    var dataJson:[String] = ["22","33","44","66"]
    var testfunc = "testOne"
    var yPositonView = 100
    override func viewDidLoad() {
        super.viewDidLoad()
      //  createTable()
        var itemint = 20
        myScrollView.frame = self.view.bounds
        myScrollView.backgroundColor = .red
      //  decJson()
        print(testfunc)
        print("eshe asa \(dataJson)")
      /*  dataJson.forEach({ item in
            print("tut posmotri \(item) ")
            let label = UILabel()
            label.text = item
            label.frame = CGRect(x: 10, y: CGFloat(itemint), width: self.screenSize.width, height: 30)
            self.myScrollView.addSubview(label)
            itemint = itemint + 50
        })*/
        myScrollView.backgroundColor = .red
        self.myScrollView.contentSize = CGSize(width: self.screenSize.width, height: CGFloat(itemint))
        
      /*  let viewOne = UIView()
        viewOne.frame = CGRect(x: 0, y: 100, width: screenSize.width, height: 300)
        viewOne.backgroundColor = .blue
        let labelView = UILabel()
        labelView.text = "viewText"
        labelView.frame = CGRect(x: 0, y: (viewOne.bounds.height - 100) / 2 , width: screenSize.width, height: 100)
        viewOne.addSubview(labelView)
        myScrollView.addSubview(viewOne)*/
        downloadJSON {
            let viewArray = self.structJson[0].view
            self.addViewPosition(viewArray: viewArray)
        }
        
        
        
       

        self.view.addSubview(self.myScrollView)
       // testJson()
        // Do any additional setup after loading the view.
    }

    func addViewPosition(viewArray:[String]) {
        
        viewArray.forEach { viewItem in
            switch viewItem {
            case "hz":
                //code

                for item in structJson[0].data {
                    if item.name == "hz" {
                      let hzView = UIView()
                        hzView.frame = CGRect(x: 0, y: CGFloat(yPositonView), width: screenSize.width, height: 200)
                        hzView.backgroundColor = .blue
                        let label = UILabel()
                        label.text = item.data.text
                        label.frame = CGRect(x: 5, y: CGFloat(100), width: hzView.bounds.width, height: 50)
                        hzView.addSubview(label)
                        myScrollView.addSubview(hzView)
                        yPositonView = yPositonView + 300
                    }
                }
            case "selector":
                //code
                print("selector")
            case "picture":
                //code
                print("picture")
            default:
                print("end")
            }
        }
       
    }
    
    func decJson() {
        let url = URL(string: "https://pryaniky.com/static/json/sample.json")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data,responce , error in
          //  let httpResponse = responce as? HTTPURLResponse
            if(error != nil) {
                print(error!)
            } else {
            //    print(httpResponse!)
            }
            
            let test = try! JSONDecoder().decode(jsonStruct.self, from: data!)
        
            
            print(test)
        }
        dataTask.resume()
    }


    
    func downloadJSON(completed: @escaping () -> ()) {
       // let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let url = URL(string: "https://pryaniky.com/static/json/sample.json")
        URLSession.shared.dataTask(with: url!) {(data, response,error) in
            if error == nil {
                do {
                    self.structJson = try [JSONDecoder().decode(jsonStruct.self, from: data!)]
                 //   let test = try JSONDecoder().decode(jsonStruct.self, from: data!)
                  //  self.structJson = [test]
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("json Error \(error)")
                }
            }
        }.resume()
    }

   
func testJson(){
    
    
    guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else {return}
    let session = URLSession.shared
    session.dataTask(with: url) { data, response, error in
        if let response = response {
            print(response)
           
        }
        
        guard let data = data else {return}
        print(data)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }.resume()
}

}
/*  func createTable() {
      self.myTableView = UITableView(frame: view.bounds, style: .plain)
      myTableView.register(UITableViewCell.self, forCellReuseIdentifier: indetifire)
     
      self.myTableView.delegate = self
      self.myTableView.dataSource = self
      myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
      view.addSubview(myTableView)
  }

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indetifire, for: indexPath)
        cell.textLabel?.text = structJsonn[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structJsonn.count
    }
}*/

