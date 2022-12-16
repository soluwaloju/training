
Below is an example of how you can use conditions to decide when to run steps for a job in your pipeline
```shell
version: 2.1


jobs:
  test:
    parameters:
      run_test:
        type: boolean
    docker:
      - image: cimg/base:2022.03
    steps:
      - checkout
      - when:
          condition:
            equal: [ true, << parameters.run_test >> ]
          steps:
            - run:
                name: Run test
                command: |
                  bash src/test.sh

workflows:
  build-workflow:
    jobs:      
      - test:
          run_test: true
```