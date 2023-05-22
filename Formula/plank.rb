class Plank < Formula
  desc "A simple dock for Linux"
  homepage "https://launchpad.net/plank"
  url "https://launchpad.net/plank/1.0/0.11.89/+download/plank-0.11.89.tar.xz"
  sha256 "a662a46eaeffbd40661d1f36abd2589f7a98baef4b918876b872047b7ca59d9d"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build
  depends_on "gtk+3"
  depends_on "libgee"
  depends_on "z80oolong/misc/gnome-menus@3.36"
  depends_on "z80oolong/misc/libwnck3@3.36"
  depends_on "z80oolong/misc/bamf@0.5"

  def install
    system "sh", "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
    system "mv", "#{share}/glib-2.0/schemas/gschemas.compiled", "#{share}/glib-2.0/schemas/gschemas.compiled.tmp"
  end

  test do
    system "#{bin}/plank", "--version"
  end
end
