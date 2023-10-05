class PlankAT01189 < Formula
  desc "A simple dock for Linux"
  homepage "https://launchpad.net/plank"
  url "https://launchpad.net/plank/1.0/0.11.89/+download/plank-0.11.89.tar.xz"
  sha256 "a662a46eaeffbd40661d1f36abd2589f7a98baef4b918876b872047b7ca59d9d"

  keg_only :versioned_formula

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build
  depends_on "gtk+3"
  depends_on "libgee"
  depends_on "librsvg"
  depends_on "z80oolong/dep/gnome-menus@3.36"
  depends_on "z80oolong/dep/libwnck3@3.36"
  depends_on "z80oolong/dep/bamf@0.5"

  def install
    system "sh", "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  def caveats; <<~EOS
    When starting plank installed with this Formula, the environment variables should be set as follows.
    
      export GSETTINGS_SCHEMA_DIR="#{opt_share}/glib-2.0/schemas:#{HOMEBREW_PREFIX}/share/glib-2.0/schemas:${GSETTINGS_SCHEMA_DIR}"
      export XDG_DATA_DIRS="#{opt_share}:#{HOMEBREW_PREFIX}/share:${XDG_DATA_DIRS}"
      export XDG_SESSION_TYPE="x11"
      export XDG_SESSION_CLASS="user"
      export XDG_SESSION_DESKTOP="ubuntu"
    EOS
  end

  test do
    system "#{bin}/plank", "--version"
  end
end
