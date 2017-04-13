import UIKit
import Moya


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
        let rightButton = UIBarButtonItem(title: "WITH PATH", style: .plain, target: self, action: #selector(withPathRequest))
        let leftButton = UIBarButtonItem(title: "WITHOUT PATH", style: .plain, target: self, action: #selector(withoutPathRequest))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
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
