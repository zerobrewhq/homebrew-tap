class Zerobrew < Formula
  desc "Fast package manager for Homebrew packages, written in Rust"
  homepage "https://github.com/zerobrewhq/zerobrew"
  # Explicit: Homebrew misreads the version from binary names like zb-linux-x64.
  version "0.4.0"
  license all_of: ["Apache-2.0", "MIT"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zb-darwin-arm64"
      sha256 "33cdbc0013bab82b540c7df619d8dc151fe72c94225e657231a17ac5a81fdca4"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zbx-darwin-arm64"
        sha256 "24c451883a8a29d4146884376a4eb36d7c4669385d1ac4a27132158df9fd8123"
      end
    end
    on_intel do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zb-darwin-x64"
      sha256 "08389c0a15501cfbf9471e14bbfe34b28a54443c169d68dc4226954009f8c1fb"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zbx-darwin-x64"
        sha256 "1841861cbf5bc2c35499c11da2c59f61364281e0b61cdb857c31e4d05251550c"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zb-linux-arm64"
      sha256 "092d098fa365b28337bad94804e0d942647fb405f1479a4a02ae53c485ac5449"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zbx-linux-arm64"
        sha256 "7ce6097f8365974518d25549a65773dd265b070b47749d04f09863a9ced0ed59"
      end
    end
    on_intel do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zb-linux-x64"
      sha256 "845277fa4597f0475cdf0cf1ac01cec54e79c20374d1b5757b284448e101362f"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.0/zbx-linux-x64"
        sha256 "280f26ba6f315299b61963e3dc29ab715ff9ef5ca1c20cba1ab68ffc06bd5153"
      end
    end
  end

  def install
    bin.install Dir["zb-*"].first => "zb"
    resource("zbx").stage { bin.install Dir["zbx-*"].first => "zbx" }
  end

  def caveats
    <<~EOS
      Run `zb init` to set up zerobrew's directories and shell config.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zb --version")
    assert_match "Usage: zb run", shell_output("#{bin}/zbx --help")
  end
end
