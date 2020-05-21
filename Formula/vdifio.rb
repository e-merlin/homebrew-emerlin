class Vdifio < Formula
  desc "a library for reading and writing vdif files"
  homepage "https://www.atnf.csiro.au/vlbi/dokuwiki/doku.php/difx/vdifio"
  head "https://github.com/pahjbo/vdifio.git", :branch => "python3"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "python" => :optional

  def install
    # ENV.deparallelize
    system "aclocal -I m4"
    system "glibtoolize -f -c -i"
    system "autoreconf -fvi"
    system "autoheader"
    system "automake -a -c"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    if build.with? "python"
      #need the prefix otherwise silently fails
      Dir.chdir('python')
      system  Formula["python"].opt_bin/"pip3", "install",  "--prefix=#{prefix}",  "."
    end
  end

  test do
    system "true"
  end
end
