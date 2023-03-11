class Msmtp < Formula
  desc "SMTP client that can be used as an SMTP plugin for Mutt"
  homepage "https://marlam.de/msmtp/"
  url "https://marlam.de/msmtp/releases/msmtp-1.8.23.tar.xz"
  head "https://git.marlam.de/git/msmtp.git"
  sha256 "cf04c16b099b3d414db4b5b93fc5ed9d46aad564c81a352aa107a33964c356b8"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://marlam.de/msmtp/download/"
    regex(/href=.*?msmtp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gnutls"
  depends_on "libidn2"
  depends_on "libsecret"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "texinfo" => :build

  def install
    if head? then
      system "autoreconf", "-i"
    end
    system "./configure", *std_configure_args, "--disable-silent-rules", "--with-macosx-keyring"
    system "make", "install"
    (pkgshare/"scripts").install "scripts/msmtpq"
  end

  test do
    system bin/"msmtp", "--help"
  end
end
