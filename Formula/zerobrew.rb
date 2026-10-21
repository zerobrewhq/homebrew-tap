class Zerobrew < Formula
  desc "Fast package manager for Homebrew packages, written in Rust"
  homepage "https://github.com/zerobrewhq/zerobrew"
  # Explicit: Homebrew misreads the version from binary names like zb-linux-x64.
  version "0.4.2"
  license all_of: ["Apache-2.0", "MIT"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zb-darwin-arm64"
      sha256 "c58b0167df1da80f7daf65caf3815150b1eaf369991867da9fe087155e3f98dc"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zbx-darwin-arm64"
        sha256 "8dda57c208c829f73456a55a5c6cd154584e2b80179aaf063f30c4e8a0beab45"
      end
    end
    on_intel do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zb-darwin-x64"
      sha256 "51089e993a22a676cc7d25a2c733c367acff2de4005508a97b692aab790ff2da"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zbx-darwin-x64"
        sha256 "450f2079fa8bf3e57dba19b58709a6fed12f850a62fa4fdd7801c6adb730047d"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zb-linux-arm64"
      sha256 "5a3c3d37884bfd2e3c4283f28432543826e2e350c309c579d93c4cd735348374"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zbx-linux-arm64"
        sha256 "12fc260ca93deaf19de6b86fd496d32dcd94268ac05410f75fe3bac9c9ac1340"
      end
    end
    on_intel do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zb-linux-x64"
      sha256 "a70770ec75e124b43b91e90828d1e60c03a6361c47f5a35ed2ad3eb1051fb014"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.2/zbx-linux-x64"
        sha256 "e3af1bfb92113ee66515a1f99eb96bb93a564472ce270467d9f2087062fbb510"
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
