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
  depends_on "z80oolong/dep/gnome-desktop@3.36"
  depends_on "z80oolong/dep/bamf@0.5"

  def install
    ENV["LC_ALL"] = "C"

    args  = std_configure_args
    args << "--disable-schemas-compile"
    args << "--bindir=#{libexec}/bin"

    system "sh", "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"

    gschema_dirs = [share/"glib-2.0/schemas"]
    gschema_dirs << (HOMEBREW_PREFIX/"share/glib-2.0/schemas")
    gschema_dirs << "${GSETTINGS_SCHEMA_DIR}"

    xdg_data_dirs = [share]
    xdg_data_dirs << (HOMEBREW_PREFIX/"share")
    xdg_data_dirs << "/usr/local/share"
    xdg_data_dirs << "/usr/share"
    xdg_data_dirs << "${XDG_DATA_DIRS}"
    
    script  = "#!/bin/sh\n"
    script << "export GSETTINGS_SCHEMA_DIR=\"#{gschema_dirs.join(":")}\"\n"
    script << "export XDG_DATA_DIRS=\"#{xdg_data_dirs.join(":")}\"\n"
    script << "export XDG_SESSION_TYPE=\"x11\"\n"
    script << "export XDG_SESSION_CLASS=\"user\"\n"
    script << "export XDG_SESSION_DESKTOP=\"ubuntu\"\n"
    script << "exec #{libexec}/bin/plank $@\n"

    ohai "Create #{bin}/plank script."
    (bin/"plank").write(script)
    (bin/"plank").chmod(0755)
  end

  def post_install
    system Formula["glib"].opt_bin/"glib-compile-schemas", HOMEBREW_PREFIX/"share/glib-2.0/schemas"
  end

  test do
    system "#{bin}/plank", "--version"
  end
end
