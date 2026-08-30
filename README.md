# Homebrew tap for the Sun programming language

Sun is a compiled language with Rust-style memory safety and an LLVM backend.
Documentation lives at <https://namo-robotics.github.io/sun/>.

```bash
brew install namo-robotics/sun/sun
```

That one command installs the `sun` compiler, the `sun-lsp` language server,
the standard library and the TLS bundle, and pulls in `llvm@20` — the
compiler's only runtime dependency. Apple Silicon only for now.

To update:

```bash
brew update && brew upgrade sun
```

Hello world:

```sun
using sun;

function main() i32 {
    println("Hello from Sun!");
    return 0;
}

manifest {
    moons: ["stdlib.moon"]
}
```

```bash
sun hello.sun            # run it through the JIT
sun -c -o hello hello.sun  # or compile a native binary
```

## About the formula

`Formula/sun.rb` is generated. It is rendered from `homebrew/sun.rb.in` in
[namo-robotics/sun](https://github.com/namo-robotics/sun) and pushed here by
that repository's Packages workflow every time a build passes its install
test, so the version and checksum always name the newest download. Send
changes to the template there rather than editing this copy.
