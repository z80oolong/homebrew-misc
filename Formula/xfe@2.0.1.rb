class XfeAT201 < Formula
  desc "A lightweight file manager for X."
  homepage "http://roland65.free.fr/xfe/"
  url "https://sourceforge.net/projects/xfe/files/xfe/2.0.1/xfe-2.0.1.tar.xz"
  sha256 "be5bb4cac853ef6ad6401d1aa8295e22c749499e2410bf0c52c6044f556a25b3"
  license "GPL-2.0"

  depends_on "glibc"
  depends_on "libpng"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxft"
  depends_on "intltool"
  depends_on "perl-xml-parser"
  depends_on "perl"
  depends_on "fox"
  depends_on "xcb-util"
  depends_on "libxcb"
  depends_on "polkit"
  depends_on "z80oolong/dep/gettext@0.22.5" => :build
  depends_on "pkg-config" => :build

  keg_only :versioned_formula

  def install
    ENV.prepend_path "PERL5LIB", "#{Formula["intltool"].libexec}/lib/perl5" unless OS.mac?
    ENV.prepend_path "PERL5LIB", "#{Formula["perl-xml-parser"].libexec}/lib/perl5" unless OS.mac?

    ENV.append "FREETYPE_CFLAGS", "-I#{Formula["freetype"].opt_include}/freetype2"
    ENV.append "FREETYPE_LIBS", "-lfreetype"
    ENV.append "LDFLAGS", "-L#{Formula["freetype"].opt_lib}"

    ENV.append "XFT_CFLAGS", "-I#{Formula["libxft"].opt_include}"
    ENV.append "XFT_LIBS", "-lXft"
    ENV.append "LDFLAGS", "-L#{Formula["libxft"].opt_lib}"

    system "./configure", "--disable-silent-rules", *std_configure_args, "--with-x", "--with-xrandr"
    system "make", "install"
  end

  test do
    system "#{bin}/xfe", "--help"
  end
end
