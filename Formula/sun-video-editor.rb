# Installs the tested Apple Silicon release and its Homebrew runtime dependencies.
class SunVideoEditor < Formula
  desc "Convert, compress, and trim local videos"
  homepage "https://github.com/namo-robotics/sun_video_editor"
  url "https://github.com/namo-robotics/sun_video_editor/releases/download/dev/sun-video-editor-700852a5d4a4ea5ebb7f06ca5257b47aeacf4742-arm64-apple-darwin.tar.gz"
  version "0.1.0.dev.5"
  sha256 "6c1bd35ec23a44f6bc51f9e7d9d3f34de61ba7dfbb42e0aea8b6a11297748b13"
  license "MIT"

  depends_on :macos
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
