# Head Hunter Api  testing framework

For run test execute:
```sh
➜  hh rspec hh_api_spec.rb --format doc 
```
Output example:
```sh
Head Hunter API
  /areas endpoint
    /areas should return required areas number
    /areas should return required sub-areas number
    /areas should return required attributes
    /areas should return required sub-area attributes
  /employers endpoint
    /employers?text=<> should be responded
    /employers should return required attributes
  /vacancies endpoint
    /vacancies?text=<>&area=<>&emploer_id=<> should be responded
    /vacancies should return required attributes

Finished in 1.32 seconds (files took 0.27224 seconds to load)
8 examples, 0 failures
```
