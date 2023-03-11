class Xfe < Formula
  desc ""
  homepage ""
  url "https://sourceforge.net/projects/xfe/files/xfe/1.45/xfe-1.45.tar.xz"
  sha256 "466bd5533a82b114705e00b861a6ede3ab851e72f45c55a77107d70c6fa8c037"
  license ""

  depends_on "libpng"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxft"
  depends_on "intltool"
  depends_on "perl"
  depends_on "fox"
  depends_on "xcb-util"
  depends_on "libxcb"
  depends_on "pkg-config" => :build

  def install
    ENV.prepend_path "PERL5LIB", "#{Formula["intltool"].libexec}/lib/perl5" unless OS.mac?

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
