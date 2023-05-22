class GnomeMenusAT336 < Formula
  desc "Bag of Auxiliary Metadata Files"
  homepage "https://packages.ubuntu.com/source/focal/gnome-menus"
  url "git://git.launchpad.net/~ubuntu-desktop/ubuntu/+source/gnome-menus",
      :tag => "ubuntu/3.36.0-1ubuntu1",
      :revision => "1616bac40677ae209ea82323585a0721862b5da4"
  version "3.36.0"

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "gnome-common" => :build
  depends_on "gtk-doc" => :build
  depends_on "libtool" => :build
  depends_on "vala" => :build
  depends_on "z80oolong/misc/lxml@4.9" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "libgtop"
  depends_on "startup-notification"
  depends_on "libx11"
  depends_on "libxcomposite"
  depends_on "libxdamage"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "libxrender"

  def install
    ENV["PYTHON"] = "#{Formula["python@3.11"].opt_bin}/python3"
    ENV.prepend_path "PYTHONPATH", "#{Formula["z80oolong/misc/lxml@4.9"].opt_prefix}/libexec/lib/python3.11/site-packages"

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "false"
  end
end
