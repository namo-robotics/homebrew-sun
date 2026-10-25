# Installs the tested Apple Silicon release and its Homebrew runtime dependencies.
class SunVideoEditor < Formula
  desc "Convert, compress, and trim local videos"
  homepage "https://github.com/namo-robotics/sun_video_editor"
  url "https://github.com/namo-robotics/sun_video_editor/releases/download/dev/sun-video-editor-b33f74ad4e4631db94509244c4495dc11303da17-arm64-apple-darwin.tar.gz"
  version "0.1.0.dev.8"
  sha256 "ca70e7715f2c970cc0f3f175dbd4868897117e8522d61421a063ad26bd174cee"
  license "MIT"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  depends_on "namo-robotics/sun/sun-gtk4"
  depends_on "librsvg"
  depends_on "ffmpeg"
  depends_on "gstreamer"
  depends_on "coreutils"

  # Keep GNU utility behavior consistent with the tested Linux media workflow.
  def install
    libexec.install "bin/sun_video_editor"
    (share/"sun-video-editor").install Dir["share/sun-video-editor/*"]
    (bin/"sun_video_editor").write_env_script libexec/"sun_video_editor",
      PATH: "#{Formula["coreutils"].opt_libexec}/gnubin:#{HOMEBREW_PREFIX}/bin:$PATH"
  end

  # Check actual media capabilities without needing a window server in brew test.
  test do
    assert_match "FFmpeg 8+ ready", shell_output("#{bin}/sun_video_editor --check-dependencies")
  end
end
