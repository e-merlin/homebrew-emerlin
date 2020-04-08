class Libodb < Formula
  desc "object relational mapping for C++"
  homepage "https://www.codesynthesis.com/products/odb/"
  url "http://www.codesynthesis.com/download/odb/2.4/libodb-2.4.0.tar.gz"
  sha256 "bfb9c398a6fdec675e33b320a1f80bdf74d8fbb700073bf17062f5b3ae1a2d5c"


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "true"
  end
end
