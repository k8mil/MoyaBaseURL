import UIKit
import Moya
import Alamofire


enum MyApi {
    case withPath
    case withoutPath
}

extension MyApi: TargetType {

    var baseURL: URL {

        switch self {
        case .withPath:
            return URL(string: "https://google.com")!
        case .withoutPath:
            return URL(string: "https://google.com/123/somepath?X-ABC-Asd=123")!
        }

    }

    var path: String {
        switch self {
        case .withPath:
            return "/123/somepath?X-ABC-Asd=123"
        case .withoutPath:
            return ""
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? {
        return [:]
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .request
    }
}


class ViewController: UIViewController {

    let provider = MoyaProvider<MyApi>()

    override func viewDidLoad() {
        super.viewDidLoad()
        addButtons()
    }

    func alamofire() {
        Alamofire.request(URL(string: "https://google.com/123/somepath?X-ABC-Asd=123")!, method: .get,
                encoding: URLEncoding.default).response {
            response in

            print("alamofire : \(response)")
        }
    }

    @objc func withoutPathRequest() {
        provider.request(.withoutPath) {
            result in
            print(result)
        }
    }

    @objc func withPathRequest() {
        provider.request(.withPath) {
            result in
            print(result)
        }
    }
}

extension ViewController {

    fileprivate func addButtons() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.backgroundColor = UIColor.red
        button.setTitle("AlamofireReq", for: .normal)
        button.addTarget(self, action: #selector(alamofire), for: .touchUpInside)
        self.navigationItem.titleView = button
        let rightButton = UIBarButtonItem(title: "WITH PATH", style: .plain, target: self, action: #selector(withPathRequest))
        let leftButton = UIBarButtonItem(title: "WITHOUT PATH", style: .plain, target: self, action: #selector(withoutPathRequest))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
}
