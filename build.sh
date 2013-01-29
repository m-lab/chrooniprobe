#!/bin/bash
$DART_SDK/bin/pub update
$DART_SDK/bin/dart --package-root=packages/ packages/web_ui/dwc.dart index.html
$DART_SDK/bin/dart2js _index.html_bootstrap.dart -o_index.html_bootstrap.dart.js --disallow-unsafe-eval
