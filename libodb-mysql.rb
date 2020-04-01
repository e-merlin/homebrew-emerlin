class LibodbMysql < Formula
  desc "mysql database driver for ODD"
  homepage "https://www.codesynthesis.com/products/odb/"
  url "http://www.codesynthesis.com/download/odb/2.4/libodb-mysql-2.4.0.tar.gz"
  sha256 "95e5b7a4ef3cc5abbb91e7f155b6b74d5e143df99258da1d49097bb7498eefef"

  depends_on "mysql@5.6" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    args = %W[
     --disable-dependency-tracking
     --prefix=#{prefix}
     LDFLAGS=-L#{Formula["mysql@5.6"].opt_prefix}
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do

    system "true"
  end
end
