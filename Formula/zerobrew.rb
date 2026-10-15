class Zerobrew < Formula
  desc "Fast package manager for Homebrew packages, written in Rust"
  homepage "https://github.com/zerobrewhq/zerobrew"
  # Explicit: Homebrew misreads the version from binary names like zb-linux-x64.
  version "0.4.1"
  license all_of: ["Apache-2.0", "MIT"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zb-darwin-arm64"
      sha256 "eb8fd97bc3605767f0239e998ef9192d92bd8f1731d9be17d530b00624725101"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zbx-darwin-arm64"
        sha256 "cb88cba7bf6ff93993049cb4cb5e2edc552924fa3733e86b386819d29d75aca1"
      end
    end
    on_intel do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zb-darwin-x64"
      sha256 "4a3a6a7ead0d14de6c67a52d515bfa173c8b4e7f087b94db401c37eb1cdf4416"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zbx-darwin-x64"
        sha256 "8d9c7b5cdf14b81b2bdd99aaaa16ec83daa1ef64b5bcda01ed611480d4907bf6"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zb-linux-arm64"
      sha256 "fb3d5f44fd2d6fb6dea6bb303f665f8fbb683ef06791313414de1d4487d56a96"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zbx-linux-arm64"
        sha256 "eed2e11c2b827f24b4074d81f5f58291eaba2e0d44fd72501819e63752d2b0e1"
      end
    end
    on_intel do
      url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zb-linux-x64"
      sha256 "471b4735efbb07ff6affb985df455d6c8e67a292878c3d00912ad7942639002d"

      resource "zbx" do
        url "https://github.com/zerobrewhq/zerobrew/releases/download/v0.4.1/zbx-linux-x64"
        sha256 "7ae8a38c679efc95a3b90620e5549b51fae5af0b3bc358b092b889dbb6c3df8f"
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
