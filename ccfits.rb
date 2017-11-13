class Ccfits < Formula
  desc "CCFITs patched for performance improvement for emerlin use"
  homepage "https://heasarc.gsfc.nasa.gov/fitsio/CCfits/"
  url "https://heasarc.gsfc.nasa.gov/fitsio/CCfits/CCfits-2.4.tar.gz"
  sha256 "ba6c5012b260adf7633f92581279ea582e331343d8c973981aa7de07242bd7f8"
  version "2.4.1"
  
  option "without-check", "Disable build-time checking (not recommended)"

  depends_on "cfitsio"

  # patch for OS X Mavericks build system
  # see https://heasarc.gsfc.nasa.gov/fitsio/CCfits/html/
  patch :DATA
  patch :p0  do
    url "http://emcc.ast.man.ac.uk/svn/emer/trunk/emerlin/CCfits_changes/CCfits.patch"
    sha256 "6b400f5f9af76626cdd1ef3de1b9dc16f083fd4e120272ab4ffed1b0c50a0a1e"
  end 

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check" if build.with? "check"
    system "make", "install"
  end

  def caveats
  <<~EOS
    this will only build at JBO because the performance patch is stored in svn there.
  EOS
  end
end

__END__
--- a/ColumnVectorData.h
+++ b/ColumnVectorData.h
@@ -260,13 +260,16 @@
           if ( that.m_data.size() != n ) return false;
           for (size_t i = 0; i < n ; i++)
           {
-                size_t nn = m_data[i].size();
-                // first check size (also, == on 2 valarrays is only defined if they
-                // are equal in size).
-                if (that.m_data[i].size() != nn ) return false;
-
-                std::valarray<bool> test = (m_data[i] == that.m_data[i]);
-                for (size_t j = 0; j < nn ; j++ ) if ( !test[j] ) return false;
+                const std::valarray<T>& thisValArray=m_data[i];
+                const std::valarray<T>& thatValArray=that.m_data[i];
+                size_t nn = thisValArray.size();
+                if (thatValArray.size() != nn ) return false;
+     
+                for (size_t j = 0; j < nn ; j++ ) 
+                {
+                   if (thisValArray[j] != thatValArray[j])
+                      return false;
+                }
           }
           return true;
   }

