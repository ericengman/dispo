# Dispo iOS Take Home

Create an iOS app with two views, `MainViewController` and `DetailViewController`. The `MainViewController` contains a list of GIFs from the [Tenor API](https://tenor.com/gifapi/documentation). (Get an API key [here](https://tenor.com/developer/keyregistration) and put it into `Constants.swift`).

When there is no query, the view should display the featured gifs. When there is a query, it should display the search results from the API.

Tapping on a cell should push the `DetailViewController`. When the `DetailViewController` loads, it should request more information from the API like share count, tags, and background color, and display it. This data must be requested from `DetailViewController`, not passed from the previous view controller.

As much as possible, stick to the Combine ViewModel structure implemented in the `MainViewController`. The `DetailViewController` should use a similar system for loading additional information from the API.

![Main View](assets/main-view.png)

![Detail View](assets/detail-view.png)
