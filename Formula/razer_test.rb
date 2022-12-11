class RazerTest < Formula
  desc "Next-gen OpenRazer!"
  homepage "https://github.com/z3ntu/razer_test"
  url "https://github.com/z3ntu/razer_test/archive/7d866a66e2270fb7ade82eba492106631da9e853.tar.gz"
  version "0.0.1"
  sha256 ""

  head do
    url "https://github.com/z3ntu/razer_test.git"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "dbus"
  depends_on "qt@5"

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
      # TODO: should use homebrew version of hidapi
      lib.install "subprojects/hidapi/libhidapi.dylib"
    end
  end

  service do
    run [opt_bin/"razer_test", "--verbose"]
  end

  test do
    system "#{bin}/razer_test", "--version"
  end
end
