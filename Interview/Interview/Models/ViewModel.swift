import Foundation

protocol ViewModelType {
    associatedtype Inputs
    associatedtype Outputs

    var inputs: Inputs { get }
    var outputs: Outputs { get }
}
