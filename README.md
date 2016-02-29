# Turbolinks vs Clearwater

[Check the demo](https://turbolinks-vs-clearwater.herokuapp.com)

This project was created to confirm or deny claims that Turbolinks is faster than a virtual DOM and therefore better to use for old/low-performance clients. Turns out, Turbolinks performance is an order of magnitude worse than Clearwater on a realistic number of DOM elements when only a small number of those change.

Granted, a 4k-article blog is not a realistic app, but it does represent a realistic number of DOM changes between two renders.
