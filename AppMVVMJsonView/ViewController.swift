//
//  ViewController.swift
//  AppMVVMJsonView
//
//  Created by Admin on 29.07.2021.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    var myTableView = UITableView()
    var structJson = [jsonStruct]()
    let indetifire = "MyCell"
    var myScrollView = UIScrollView()
    let screenSize = UIScreen.main.bounds
    var dataJson:[String] = ["22","33","44","66"]
    var testfunc = "testOne"
    var yPositonView = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.frame = self.view.bounds
        myScrollView.backgroundColor = .orange
        print(testfunc)
        print("eshe asa \(dataJson)")
     
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
                        yPositonView = yPositonView + 200
                    }
                }
            case "selector":
                for item in structJson[0].data {
                   if item.name == "selector" {
                     let hzView = UIView()
                       hzView.frame = CGRect(x: 0, y: CGFloat(yPositonView), width: screenSize.width, height: 200)
                       hzView.backgroundColor = .purple
                       //image
                    var yPositionLabel = 50
                    for itemVariant in item.data.variants! {
                        let label = UILabel()
                        label.text = "\(itemVariant.id): \(itemVariant.text)"
                        label.frame = CGRect(x: 5, y: CGFloat(yPositionLabel), width: hzView.bounds.width, height: 50)
                        label.tag = itemVariant.id
                        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
                            tap.numberOfTapsRequired = 1
                            label.isUserInteractionEnabled = true
                            label.addGestureRecognizer(tap)
                        hzView.addSubview(label)
                        yPositionLabel = yPositionLabel + 50
                    }
                    
                       myScrollView.addSubview(hzView)
                       yPositonView = yPositonView + 200
                   }
               }
                print("selector")
            case "picture":
                 for item in structJson[0].data {
                    if item.name == "picture" {
                      let hzView = UIView()
                        hzView.frame = CGRect(x: 0, y: CGFloat(yPositonView), width: screenSize.width, height: 200)
                        hzView.backgroundColor = .red
                        //image
                        let url = item.data.url
                        let image = UIImageView()
                        image.kf.indicatorType = .activity
                        image.kf.setImage(with: URL(string: url!), placeholder: nil, options: [.transition(.fade(0.7))],progressBlock: nil)
                        image.frame = CGRect(x: 5, y: CGFloat(20), width: hzView.bounds.width, height: 100)
                        image.contentMode = .scaleAspectFit
                        hzView.addSubview(image)
                        
                        let label = UILabel()
                        label.text = item.data.text
                        label.frame = CGRect(x: 5, y: CGFloat(100), width: hzView.bounds.width, height: 50)
                        hzView.addSubview(label)
                        myScrollView.addSubview(hzView)
                        yPositonView = yPositonView + 200
                    }
                }
                print("picture")
            default:
                print("end")
            }
        }
        self.myScrollView.contentSize = CGSize(width: screenSize.width, height: CGFloat(yPositonView + 25))
    }
    
    @objc func tapLabel(_ sender: UIGestureRecognizer) {
        let text = (sender.view as! UILabel).text!
        let alert = UIAlertController(title: "Выбрали", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

