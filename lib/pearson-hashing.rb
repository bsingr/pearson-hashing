require File.join(File.dirname(__FILE__), 'pearson-hashing/version')

module PearsonHashing
  TABLE = [49, 118,  63, 252,  13, 155, 114, 130, 137,  40, 210,  62, 219, 246, 136, 221,
           174, 106,  37, 227, 166,  25, 139,  19, 204, 212,  64, 176,  70,  11, 170,  58,
           146,  24, 123,  77, 184, 248, 108, 251,  43, 171,  12, 141, 126,  41,  95, 142,
           167,  46, 178, 235,  30,  75,  45, 208, 110, 230, 226,  50,  32, 112, 156, 180,
           205,  68, 202, 203,  82,   7, 247, 217, 223,  71, 116,  76,   6,  31, 194, 183,
            15, 102,  97, 215, 234, 240,  53, 119,  52,  47, 179,  99, 199,   8, 101,  35,
            65, 132, 154, 239, 148,  51, 216,  74,  93, 192,  42,  86, 165, 113,  89,  48,
           100, 195,  29, 211, 169,  38,  57, 214, 127, 117,  59,  39, 209,  88,   1, 134,
            92, 163,   0,  66, 237,  22, 164, 200,  85,   9, 190, 129, 111, 172, 231,  14,
           181, 206, 128,  23, 187,  73, 149, 193, 241, 236, 197, 159,  55, 125, 196,  60,
           161, 238, 245,  94,  87, 157, 122, 158, 115, 207,  17,  20, 145, 232, 107,  16,
            21, 185,  33, 225, 175, 253,  81, 182,  67, 243,  69, 220, 153,   5, 143,   3,
            26, 213, 147, 222, 105, 188, 229, 191,  72, 177, 250, 135, 152, 121, 218,  44,
           120, 140, 138,  28,  84, 186, 198, 131,  54,   2,  56,  78, 173, 151,  83,  27,
           255, 144, 249, 189, 104,   4, 168,  98, 162, 150, 254, 242, 109,  34, 133, 224,
           228,  79, 103, 201, 160,  90,  18,  61,  10, 233,  91,  80, 124,  96, 244,  36]



  # Calculates a 8bit hash based on pearson hashing algorithm
  # (values range from 0 to 256)
  # 
  # Further descriptions can be found here:
  #  * http://en.wikipedia.org/wiki/Pearson_hashing
  #  * http://cs.mwsu.edu/~griffin/courses/2133/downloads/Old_Assignments/p677-pearson.pdf
  # @param [String] string
  # @return [Fixnum] hash
  def self.digest8(string)
    hash = string.size % 256
    string.each_byte do |byte|
      hash = TABLE[ (hash + byte) % 256 ]
    end
    hash
  end
  
  # make #digest8 the default
  class << self
    alias :digest :digest8
  end

  # Calculates a bit more complex 16bit hash, as describe in page 679 of:
  # (values range from 0 to 65536)
  #
  # http://cs.mwsu.edu/~griffin/courses/2133/downloads/Old_Assignments/p677-pearson.pdf
  # @param [String] string
  # @return [Fixnum] hash
  def self.digest16(string)
    h1 = PearsonHashing.digest8 string
    h2 = PearsonHashing.digest8 shift string
    format = '%03d'
    (format % h1 + format % h2).to_i
  end
  
  # 32 bit hash
  # @param [String] string
  # @param [Fixnum] hashvalue
  def self.digest32(string)
    h1 = PearsonHashing.digest8 string
    h2 = PearsonHashing.digest8 shift string
    h3 = PearsonHashing.digest8 shift shift string
    format = '%03d'
    (format % h1 + format % h2 + format % h3).to_i
  end
  
private
  
  # @param [String] str
  # @return [String] str with first byte moved up
  def self.shift(str)
    [(str.bytes.first+1)%256].pack('U*') + str[1,str.size]
  end
end
