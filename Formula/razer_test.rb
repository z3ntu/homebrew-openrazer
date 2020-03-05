class RazerTest < Formula
  desc "Next-gen OpenRazer!"
  homepage "https://github.com/z3ntu/razer_test"
  url "https://github.com/z3ntu/razer_test/archive/master.tar.gz"
  version "0.0.1"
  sha256 ""

  head do
    url "https://github.com/z3ntu/razer_test.git"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "dbus"
  depends_on "qt"

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
      # TODO: should use homebrew version of hidapi
      lib.install "subprojects/hidapi/libhidapi.dylib"
    end
  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>

        <key>ProgramArguments</key>
        <array>
            <string>#{bin}/razer_test</string>
            <string>--verbose</string>
        </array>
      </dict>
    </plist>
  EOS
  end

  plist_options :startup => true, :manual => "razer_test"

  test do
    system "#{bin}/razer_test", "--version"
  end
end
