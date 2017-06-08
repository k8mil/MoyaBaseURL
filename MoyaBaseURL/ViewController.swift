import UIKit
import Moya
import Alamofire

enum MyApi {
    case postWithURLParameters
}

extension MyApi: TargetType {

    var baseURL: URL {
        return URL(string: "https://google.com")!
    }

    var path: String {
        return "/123/somePath"
    }

    var method: Moya.Method {
        return .post
    }

    var parameters: [String: Any]? {
        return ["parameterId": "someId"]
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
        let leftButton = UIBarButtonItem(title: "WITHOUT PATH", style: .plain, target: self, action: #selector(doRequest))
        navigationItem.leftBarButtonItem = leftButton
    }

@objc func doRequest() {
    provider.request(MyApi.postWithURLParameters) {
        result in
        print(result)
    }
}

}