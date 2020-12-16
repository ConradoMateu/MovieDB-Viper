
# MovieDB Viper

MovieDB Viper is an application that  uses Viper Architecture with an Abstract and Reactive Network Layer, combined with latests technologies as SwiftUI and Combine.
Works with [The Movie Database API](https://developers.themoviedb.org/3) in order to retrieve Popular movies to show in the App.


![App Image](Art/MovieDB-Viper.jpg?)


## Architecture

The architecture is based in a Viper approach:

![Image](Art/VIPER-Diagram.png?)

In SwiftUI in order to do the Routing, A Navigation Link has to be created throught the Presenter, Specifying the destination that has the Router or Wireframe.

Router:
```swift
  func makeDetailView(for movie: MovieEntity) -> some View {
    let presenter = MovieDetailPresenter(movie: movie)
    return MovieDetailView(presenter: presenter)
  }
```

Presenter:
```swift
  func linkBuilder<Content: View>(for movie: MovieEntity, @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) {
      content()
    }
  }

```

Another thing to mention is the Data Binding that is done in the presenter in Order to connect the entity throught the Interactor

```swift
 func bindVariablesToModel(){
    self.interactor.model.$movies
      .assign(to: \.movies, on: self)
      .store(in: &cancellables)
    self.interactor.model.$error
      .assign(to: \.error, on: self)
      .store(in: &cancellables)
  }

```


## Network Layer

In order to have an abstract network layer, we need an API Router to assemble the URL Request in order to decode the Generic URLSession:


```swift
  func run<T: Decodable>(_ router: Router, params:  [String:Any]? = nil) -> AnyPublisher<T, ApiError> {
    let request = assembleURLRequest(router: router, parameters: params)
    return URLSession.shared.dataTaskPublisher(for: request!)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw ApiError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
          throw ApiError.statusCode(httpResponse.statusCode)
        }
        return data
      }
      .decode(type:T.self, decoder: JSONDecoder())
      .mapError{error -> ApiError in
        if let httpError = error as? ApiError {
          return httpError
        }
        return ApiError.unknown(error)
      }
      .eraseToAnyPublisher()
  }
```

After that we just simply have to call the desired path throught the API Router in order to perform the call in the Interactor:


```swift
  func fetch()  -> AnyPublisher<mainEntity, ApiError>{
    return ServiceLayer.shared.run(Router.popular)
  }
```

And after calling this function in the presenter we should update the Entity via the Interactor:

```swift
   request = self.interactor.fetch().on(queue: .main)
      .on(success: { [weak self] data in
        self?.interactor.sucess(for: data.results)
      }, failure: { [weak self] error in
        self?.interactor.error(for: error)
      })
```

## Requirements

- iOS 14+
- XCode 12+


## Source

[The Movie Database API](https://developers.themoviedb.org/3)

## License

Apache-2.0 License
