# Adding proptest to a project

In addition to embedded manually created unit tests, proptests can be added to a project 
to be invoked by `cargo test`.

1. Add proptest as a dependency to `Cargo.toml`
    ```toml
    [dev-dependencies]
    proptest = "0.10.1"
    ```
2. Create the tests directory:
    ```sh
    mkdir tests
    ```
3. Create your proptest driver, for example `tests/feature_proptest.rs`:
    > Note: the mdbook generator wraps the rust syntax with a `fn main() { ... }`, these should
    > be included in your file.
    ```rust
    # fn main() { // IGNORE THIS LINE
    use proptest::prelude::*;
    // import your APIs here e.g.
    // use module_name::feature::*;

    // define your strategies for any types defined by your feature...
    // this example provides a strategy for std::time::Duration
        fn duration_strategy() -> impl Strategy<Value = std::time::Duration> {
            any::<u64>().prop_map(std::time::Duration::from_secs)
        }
    }

    // define your invariants
    proptest! {
        fn check_property_of_feature(duration in duration_strategy()) {
            { // crash checks
                // from the wildcard import
                do_something_with(&duration)            
                // or explicitly pathed:
                module_name::feature::do_something_with(&duration)
            }
            { // assertions
                assert_eq!(None, do_something_with(&duration));
            }
        }
    }
    # } // IGNORE THIS LINE
    ```
4. Run your tests
    ```sh
    cargo test
    ```