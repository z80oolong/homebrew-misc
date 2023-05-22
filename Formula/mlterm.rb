class Mlterm < Formula
  desc "Multilingual terminal emulator"
  homepage "https://mlterm.sourceforge.io/"
  url "https://github.com/arakiken/mlterm/archive/refs/tags/3.9.3.tar.gz"
  version "3.9.3"
  sha256 "b5b76721391de134bd64afb7de6b4256805cf2fc883a2bf2e5d29602ac1b50d9"
  license "GPL-2.0-or-later"

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "fontconfig"
  depends_on "libx11"
  depends_on "libxft"
  depends_on "libxinerama"
  depends_on "libxt"
  depends_on "libice"
  depends_on "libsm"
  depends_on "pango"
  depends_on "cairo"
  depends_on "atk"
  depends_on "librsvg"
  depends_on "fribidi"
  depends_on "gobject-introspection"
  depends_on "harfbuzz"
  depends_on "gnutls"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "z80oolong/misc/fcitx@4.2.9.8"

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-gtk3",
                          "--with-im-module=fcitx"
                          "--enable-fcitx"
    system "make", "install"
  end

  def caveats
    <<~EOS
      MLTerm is a multilingual terminal emulator. In order to use it, you may need to
      install additional fonts or font packages.

      For fcitx users, make sure to set the following environment variables in your shell startup script:

        export XMODIFIERS=@im=fcitx
        export GTK_IM_MODULE=fcitx
        export QT_IM_MODULE=fcitx
        export DefaultIMModule=fcitx

      To launch MLTerm, run the following command:

        mlterm
    EOS
  end

  test do
    system "#{bin}/mlterm", "--version"
  end
end
