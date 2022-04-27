# Demonstrator for Vaadin Flow Issue [#13624](https://github.com/vaadin/flow/issues/13624)

If a http proxy is required to build a Vaadin app, the build will fail.

This demonstrator tries to build the app in a Docker container, which prevents outbound network traffic on port 80 and 443, but uses a squid proxy as an http proxy.

The proxy is configured in [gradle.properties](gradle.properties) and [.npmrc](.npmrc).

To start the build, just run `docker compose up --build` (due to very slow bind mounts on macOS, I'm not using them 😟).

It will fail due to an error thrown by `esbuild`:

```
vaadin-issue13624-openjdk-1  | > Task :vaadinBuildFrontend FAILED
vaadin-issue13624-openjdk-1  |
vaadin-issue13624-openjdk-1  | FAILURE: Build failed with an exception.
vaadin-issue13624-openjdk-1  |
vaadin-issue13624-openjdk-1  | * What went wrong:
vaadin-issue13624-openjdk-1  | Execution failed for task ':vaadinBuildFrontend'.
vaadin-issue13624-openjdk-1  | > Webpack process exited with non-zero exit code.
vaadin-issue13624-openjdk-1  |   Stderr: '/app/node_modules/esbuild/bin/esbuild:2
vaadin-issue13624-openjdk-1  |   throw new Error(`esbuild: Failed to install correctly
vaadin-issue13624-openjdk-1  |   ^
vaadin-issue13624-openjdk-1  |   
vaadin-issue13624-openjdk-1  |   Error: esbuild: Failed to install correctly
vaadin-issue13624-openjdk-1  |   
vaadin-issue13624-openjdk-1  |   Make sure you don't have "ignore-scripts" set to true. You can check this with
vaadin-issue13624-openjdk-1  |   "npm config get ignore-scripts". If that returns true you can reset it back to
vaadin-issue13624-openjdk-1  |   false using "npm config set ignore-scripts false" and then reinstall esbuild.
vaadin-issue13624-openjdk-1  |   
vaadin-issue13624-openjdk-1  |   If you're using npm v7, make sure your package-lock.json file contains either
vaadin-issue13624-openjdk-1  |   "lockfileVersion": 1 or the code "hasInstallScript": true. If it doesn't have
vaadin-issue13624-openjdk-1  |   either of those, then it is likely the case that a known bug in npm v7 has
vaadin-issue13624-openjdk-1  |   corrupted your package-lock.json file. Regenerating your package-lock.json file
vaadin-issue13624-openjdk-1  |   should fix this issue.
vaadin-issue13624-openjdk-1  |   
vaadin-issue13624-openjdk-1  |       at Object.<anonymous> (/app/node_modules/esbuild/bin/esbuild:2:7)
vaadin-issue13624-openjdk-1  |       at Module._compile (node:internal/modules/cjs/loader:1103:14)
vaadin-issue13624-openjdk-1  |       at Object.Module._extensions..js (node:internal/modules/cjs/loader:1157:10)
vaadin-issue13624-openjdk-1  |       at Module.load (node:internal/modules/cjs/loader:981:32)
vaadin-issue13624-openjdk-1  |       at Function.Module._load (node:internal/modules/cjs/loader:822:12)
vaadin-issue13624-openjdk-1  |       at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:77:12)
vaadin-issue13624-openjdk-1  |       at node:internal/main/run_main_module:17:47
vaadin-issue13624-openjdk-1  |   Hash: 29fa358a62132e0349d8
vaadin-issue13624-openjdk-1  |   Version: webpack 4.46.0
vaadin-issue13624-openjdk-1  |   Time: 12602ms
vaadin-issue13624-openjdk-1  |   Built at: 04/26/2022 7:18:18 PM
vaadin-issue13624-openjdk-1  |                                                      Asset      Size  Chunks               Chunk Names
vaadin-issue13624-openjdk-1  |   VAADIN/build/vaadin-bundle-446c1fbd4a644a93c8e8.cache.js  1.38 KiB       0  [immutable]  bundle
vaadin-issue13624-openjdk-1  |                                                      sw.js  1.38 KiB                       
vaadin-issue13624-openjdk-1  |   Entrypoint bundle = VAADIN/build/vaadin-bundle-446c1fbd4a644a93c8e8.cache.js
vaadin-issue13624-openjdk-1  |   [0] ./generated/vaadin.ts 482 bytes {0} [built] [failed] [1 error]
vaadin-issue13624-openjdk-1  |   
vaadin-issue13624-openjdk-1  |   ERROR in ./generated/vaadin.ts
vaadin-issue13624-openjdk-1  |   Module build failed (from ../node_modules/esbuild-loader/dist/index.js):
vaadin-issue13624-openjdk-1  |   Error: The service was stopped
vaadin-issue13624-openjdk-1  |       at /app/node_modules/esbuild/lib/main.js:1258:29
vaadin-issue13624-openjdk-1  |       at /app/node_modules/esbuild/lib/main.js:611:9
vaadin-issue13624-openjdk-1  |       at Socket.afterClose (/app/node_modules/esbuild/lib/main.js:589:7)
vaadin-issue13624-openjdk-1  |       at Socket.emit (node:events:538:35)
vaadin-issue13624-openjdk-1  |       at endReadableNT (node:internal/streams/readable:1345:12)
vaadin-issue13624-openjdk-1  |       at processTicksAndRejections (node:internal/process/task_queues:83:21)
vaadin-issue13624-openjdk-1  |   
vaadin-issue13624-openjdk-1  |   ERROR in ../build/sw.ts
vaadin-issue13624-openjdk-1  |   Module build failed (from ../node_modules/esbuild-loader/dist/index.js):
vaadin-issue13624-openjdk-1  |   Error: The service was stopped
vaadin-issue13624-openjdk-1  |       at /app/node_modules/esbuild/lib/main.js:1258:29
vaadin-issue13624-openjdk-1  |       at /app/node_modules/esbuild/lib/main.js:611:9
vaadin-issue13624-openjdk-1  |       at Socket.afterClose (/app/node_modules/esbuild/lib/main.js:589:7)
vaadin-issue13624-openjdk-1  |       at Socket.emit (node:events:538:35)
vaadin-issue13624-openjdk-1  |       at endReadableNT (node:internal/streams/readable:1345:12)
vaadin-issue13624-openjdk-1  |       at processTicksAndRejections (node:internal/process/task_queues:83:21)
vaadin-issue13624-openjdk-1  |   Child HtmlWebpackCompiler:
vaadin-issue13624-openjdk-1  |                             Asset      Size  Chunks  Chunk Names
vaadin-issue13624-openjdk-1  |       __child-HtmlWebpackPlugin_0  4.31 KiB       0  HtmlWebpackPlugin_0
vaadin-issue13624-openjdk-1  |       Entrypoint HtmlWebpackPlugin_0 = __child-HtmlWebpackPlugin_0
vaadin-issue13624-openjdk-1  |       [0] ../node_modules/html-webpack-plugin/lib/loader.js!./index.html 740 bytes {0} [built]
vaadin-issue13624-openjdk-1  |   Child InjectManifest:
vaadin-issue13624-openjdk-1  |       Asset      Size  Chunks  Chunk Names
vaadin-issue13624-openjdk-1  |       sw.js  1.38 KiB       0  InjectManifest
vaadin-issue13624-openjdk-1  |       Entrypoint InjectManifest = sw.js
vaadin-issue13624-openjdk-1  |       [0] ../build/sw.ts 482 bytes {0} [built] [failed] [1 error]
vaadin-issue13624-openjdk-1  |       
vaadin-issue13624-openjdk-1  |       ERROR in ../build/sw.ts
vaadin-issue13624-openjdk-1  |       Module build failed (from ../node_modules/esbuild-loader/dist/index.js):
vaadin-issue13624-openjdk-1  |       Error: The service was stopped
vaadin-issue13624-openjdk-1  |           at /app/node_modules/esbuild/lib/main.js:1258:29
vaadin-issue13624-openjdk-1  |           at /app/node_modules/esbuild/lib/main.js:611:9
vaadin-issue13624-openjdk-1  |           at Socket.afterClose (/app/node_modules/esbuild/lib/main.js:589:7)
vaadin-issue13624-openjdk-1  |           at Socket.emit (node:events:538:35)
vaadin-issue13624-openjdk-1  |           at endReadableNT (node:internal/streams/readable:1345:12)
vaadin-issue13624-openjdk-1  |           at processTicksAndRejections (node:internal/process/task_queues:83:21)
vaadin-issue13624-openjdk-1  |   <i> [build-status] 2 errors and 0 warnings were reported.
vaadin-issue13624-openjdk-1  |   <i> [build-status] : Failed to compile.
vaadin-issue13624-openjdk-1  |   '
vaadin-issue13624-openjdk-1  |
vaadin-issue13624-openjdk-1  | * Try:
vaadin-issue13624-openjdk-1  | > Run with --stacktrace option to get the stack trace.
vaadin-issue13624-openjdk-1  | > Run with --info or --debug option to get more log output.
vaadin-issue13624-openjdk-1  | 4 actionable tasks: 3 executed, 1 up-to-date
vaadin-issue13624-openjdk-1  | > Run with --scan to get full insights.
vaadin-issue13624-openjdk-1  |
vaadin-issue13624-openjdk-1  | * Get more help at https://help.gradle.org
vaadin-issue13624-openjdk-1  |
vaadin-issue13624-openjdk-1  | BUILD FAILED in 1m 27s
vaadin-issue13624-openjdk-1 exited with code 1
```

The issue is, that the when the postinstall script from `node_modules/esbuild/package.json` is called by Vaadin's Gradle plugin, neither the http-proxy environment variables nor an npm config located in `node_modules/esbuild/.npmrc`, `~/.npmrc` or `/etc/npmrc` are respected.