#!/bin/bash
$DART_SDK/bin/pub update
cp packages/browser/dart.js .
$DART_SDK/bin/dart --package-root=packages/ packages/web_ui/dwc.dart --out out/ index.html
$DART_SDK/bin/dart2js out/index.html_bootstrap.dart -oout/index.html_bootstrap.dart.js --disallow-unsafe-eval
