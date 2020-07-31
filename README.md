# RRPagingCollectionView
Paging Collection View with image loading

## Example
![alt text](https://github.com/Rahul-Mayani/RRPagingCollectionView/blob/master/sample.gif)

## Requirements

pod 'RxCocoa'

pod 'RxSwift'

pod 'RxGesture'

pod 'Kingfisher'

## Installation

#### Manually
1. Download the project.
2. Add necessary files in your project.
3. Congratulations!  

## Usage example
To run the example project, clone the repo, and run pod install from the Example directory first.


```swift

//Create RRPagingCollectionView class CollectionView outlet and set storyboard file itself
@IBOutlet weak var collectionView: RRPagingCollectionView!

//set pagingDelegate in viewDidLoad method
collectionView.pagingDelegate = self

//Start paging animation while data load from server
// MARK: - PagingCollectionViewDelegate -
func paginateCtn(_ collectionView: RRPagingCollectionView, to page: Int) {
    if !collectionView.isLoading && totalDataCount > dataArray.count {
        collectionView.isLoading = true
        //API call
    }
}

//Set loading CollectionView Loading Footer view
func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    return collectionView.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return collectionView.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return collectionView.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section)
}

//Stop paging animation after get API response
collectionView.reloadData()
collectionView.isLoading = false

```

## Contribute 

We would love you for the contribution to **RRPagingCollectionView**, check the ``LICENSE`` file for more info.


## License

RRPagingCollectionView is available under the MIT license. See the LICENSE file for more info.
