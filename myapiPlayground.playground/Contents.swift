import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string:"https://polls.apiblueprint.org/questions")!
var request = URLRequest(url: url)

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  if let response = response {
    print(response)

    if let data = data, let body = String(data: data, encoding: .utf8) {
      print(body)
    }
  } else {
    print(error ?? "Unknown error")
  }
}

task.resume()
