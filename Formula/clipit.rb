class Clipit < Formula
  desc "ClipIt clipboard manager for GTK+"
  homepage "https://github.com/CristianHenzel/ClipIt"
  license "GPL-3.0-or-later"

  stable do
    url "https://github.com/CristianHenzel/ClipIt/archive/refs/tags/v1.4.5.tar.gz"
    sha256 "f0bbd1b4ff07bb4509388cf5b7f7a25fd72ec02cdd8f4c8f5ff3f5f9ca6da514"
  end

  head do
    url "https://github.com/CristianHenzel/ClipIt.git"
  end

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "perl" => :build
  depends_on "glibc"
  depends_on "intltool"
  depends_on "xdotool"
  depends_on "gtk+3"

  def install
    ENV.cxx11
    ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
    ENV.append "CFLAGS", "-Wno-int-conversion"
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    ENV["LC_ALL"] = "C"

    args  = std_configure_args
    args << "--disable-silent-rules"
    args << "--with-gtk3"

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
