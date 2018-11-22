Multimedia Technology Basics: FourCCs, AVI Codecs, ASF Codecs, WAV Codecs, 
MOV Codecs, RM Codecs, YUV Codecs, RGB Codecs, Lossy and Lossless Codecs 
and More
by Mike Melanson (mike at multimedia.cx)
v1.1: September 25, 2005


  Copyright (c) 2003-2005 Mike Melanson
  Permission is granted to copy, distribute and/or modify this document
  under the terms of the GNU Free Documentation License, Version 1.2
  or any later version published by the Free Software Foundation;
  with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
  A copy of the license is included in the section entitled "GNU
  Free Documentation License".


Contents
--------
 * Introduction
 * Codecs
 * FourCCs
 * Multimedia Files
 * What Application Can "Play" This File?
 * RGB and YUV Colorspaces
 * References
 * Acknowledgements
 * Changelog
 * GNU Free Documentation License


Introduction
------------
This document is intended as a very brief overview of assorted technical
topics that will help a developer begin to understand computer
multimedia technology. There are many other references for the verbose
theory underlying certain of the presented concepts, particularly YUV
colorspaces; this document is long on technical explanation and short on
abstract concepts.

I run a technical multimedia website. Occasionally, I browse my ISP's web 
server logs which contain information about search engine queries that 
brought visitors to my site. I am curious to know if people are actually 
finding what they are looking for.

I often see web log records that indicate visitors looking for "asf codec" 
or "mov codec" or "yuv codec". With any luck, the search engines will 
index this document and point visitors to more useful information.


Codecs
------
"Codec" is an abbreviation for COder/DECoder. Briefly, this refers to any
algorithm that codes data into another form and then decodes the coded
data in order to recover the original data (more or less). In the context
of multimedia technology, this means taking raw audio or video data, which
tends to be enormous, and sending it through a coder algorithm to 
compress it to a considerably smaller size. Then it is stored on disk,
transmitted over the network, etc. until it is time to play it back. At
such time, the compressed data is sent through the decoder portion of the
decoder algorithm which reconstructs the original audio or video data for 
playback.

Actually, a large majority of multimedia codecs do not reconstruct the
original audio or video data upon decompression. These codecs fall into
the category "lossy". Codecs that reconstruct the original data exactly
upon decompression are categorized as "lossless". Why would it be okay to
lose information during encoding? Many multimedia codecs throw away subtle
pieces of information which, according to empirical research, have little
impact on human perception. As a very simple example, 2 adjacent pixels
might be so close in color that the coder declares them to be the same
color and codes them together as "2 x color1" instead of "1 x color1, 1 x
color2". The decoded data will not be exactly the same as the original
data, but the goal is to be able to reconstruct a picture that will be
"good enough".


FourCCs
-------
A FourCC is short for "four-character code". FourCCs are very commonly 
seen in multimedia files in order to identify audio or video codecs, as 
well as to mark boundaries within the file.

A FourCC is generally comprised of 4 ASCII range characters which, when 
examined as a hex dump, form a human-readable, four-character string. For 
example:

   08 77 73 74  62 6C 00 00  00 7F 73 74  73 64 00 00  .wstbl....stsd..
   00 00 00 00  00 01 00 00  00 6F 53 56  51 33 00 00  .........oSVQ3..

This is taken from an Apple QuickTime file. There is at least one FourCC
('stsd') and two more ('stbl' and 'SVQ3') which are not immediately 
discernible since the 'w' and 'o' characters preceding them are valid
ASCII characters.

Since a FourCC is made up of 4 ASCII bytes and each byte is 8 bits, a 
FourCC is 32 bits long. This works well with modern 32-bit CPUs. As seen 
in the above example, 'SVQ3' is also represented as 0x53565133 in 
big-endian hexadecimal notation, or 0x33515653 in little-endian hex 
notation. Such knowledge alleviates the need for memcmp() and strncmp() 
functions when scanning for FourCCs.

It is important to note that FourCCs do not necessarily need to contain 
4 valid alphanumeric ASCII characters. For example, there are a variety of 
FourCCs in the QuickTime format which are well outside the range.


Multimedia Files
----------------
Many multimedia files that carry both audio and video bear extensions 
such as .avi (Microsoft AVI files), .asf (a.k.a., .wmv and .wma, 
collectively known as Microsoft ASF files), .mov (Apple QuickTime files),
and .rm (RealMedia files). Confusion often arises as one wonders what 
application can, for example, "play .mov files". That is a very difficult 
question to answer and here is why:

All of the formats mentioned in the preceding paragraph are also
referred to as multimedia container formats. All they do is pack chunks
of audio and video data together, interleaved, along with some
instructions to inform a playback application how the data is to be
decoded and presented to the user. This is the typical layout of many
multimedia file formats:

    file header
      title, creator, other meta-info
      video header
        video codec FourCC
        width, height, colorspace, playback framerate
      audio header
        audio codec FourCC
        bits/sample, playback frequency, channel count
    file data
      encoded audio chunk #0
      encoded video chunk #0
      encoded audio chunk #1
      encoded video chunk #1
      encoded audio chunk #2
      encoded video chunk #2
      encoded audio chunk #3
      encoded video chunk #3
       ..
       ..

Those audio and video chunks can be encoded with any number of audio or 
video codecs, the FourCCs of which are specified in the file header.

See The Almost Definitive FourCC Definition List listed in the reference 
for more information on the jungle of FourCCs out there, and where they 
commonly appear.


What Application Can "Play" This File?
--------------------------------------
Here comes the big question. You have some random Apple QuickTime file.
Perhaps you are running some non-Microsoft, non-Apple operating system and 
there is no official Apple QuickTime application available. Is there a
program that can "play" the QT file?

Since a QuickTime file can contain many different types of audio or video
data, it is not enough to be able to simply decode the QuickTime container
format; the audio and video codec formats must be supported as well.

This is why there is no simple answer to whether or not a particular 
multimedia application can "play" a type of multimedia container file 
format. A player application needs to be able to decode the container
format and decode the audio and video codec formats inside.


Interleaving
------------
Interleaving is the process of storing alternating audio and video chunks 
in the data section of a multimedia file:

      encoded audio chunk #0
      encoded video chunk #0
      encoded audio chunk #1
      encoded video chunk #1
      encoded audio chunk #2
      encoded video chunk #2
       ..
       ..
      encoded audio chunk #n
      encoded video chunk #n

Why is this done? Why not just place all of the video data in the file, 
followed by all of the audio data? For example:

      encoded video chunk #0
      encoded video chunk #1
      encoded video chunk #2
       ..
       ..
      encoded video chunk #n
      encoded audio chunk #0
      encoded audio chunk #1
      encoded audio chunk #2
       ..
       ..
      encoded audio chunk #n

Conceptually, this appears to be a valid solution. In practice, however, 
it falls over. Assuming these audio and video streams are part of the same 
file on the same disk (almost always the case), there is a physical 
mechanism called the disk read head which has to constantly make a leap 
between two different positions on the disk. When the chunks are 
interleaved, the read head does not need to seek at all; it can read all 
the data off in a contiguous fashion.


RGB and YUV Colorspaces
-----------------------

There are two general families of colorspaces for video: RGB and YUV. If
you have any experience with computer graphics at all, you have probably
been exposed to the red-green-blue (RGB) colorspace. More specifically,
you have probably seen packed RGB colorspaces. A packed colorspace has
all of the elements interleaved. For example, a packed RGB24 colorspace
with 8 bits for each R, G, or B element, is laid out in memory as:

  R G B R G B R G B ...

Sometimes, the opposite ordering is required. This would be expressed as 
BGR24:

  B G R B G R B G R ...

24 bits is awkward for many CPUs; 32 bits is far more conducive. 
Therefore, packed 32-bit RGB formats are often used for video output in 
the interest of speed. When this is done, a fourth component, usually 
labeled 'A', is added.

  ARGB: A R G B  A R G B  A R G B
  BGRA: B G R A  B G R A  B G R A

Sometimes, the 'A' component actually represents an alpha transparency
value, used for blending RGB images together. For video playback, it is
generally ignored.

There are also many variations of 15- and 16-bit packed RGB formats. For 
example, a RGB15 format may pack 5 bits for each component into the lower 
15 bits of a 2-byte word and leave the top bit for some other use:

   byte 0   byte 1
  Xrrrrrgg gggbbbbb

Of course, how those 2 bytes are stored in memory (high or low byte
first) is dependent upon the application. BGR15 may also be seen. RGB16
formats typically allocate an extra bit for green:

   byte 0   byte 1
  rrrrrggg gggbbbbb

Many older video codecs rely on packed RGB colorspaces since that is
what the hardware was capable of displaying natively. Certain modern
codecs still used RGB colorspaces if the source material is conducive,
i.e., if it is non-photorealistic or just plain simple.

However, many modern video codecs rely on a YUV colorspace. 'YUV' is a
frustrating acronym since it is so difficult to guess what the letters
could possibly stand for. The colorspace was originally known as YCbCr,
with the 'b' and 'r' characters written as subscripts. This is what the
components break down as:

  Y = luminance, or intensity
  U = Cb = blue chrominance value
  V = Cr = red chrominance value

Where is green represented? Green can be derived from the Y, U, and V 
values. See the references for more information on converting YUV to RGB 
and back.

Note that with RGB colorspaces, every single pixel has a different R, G,
and B sample. The same is not true with YUV colorspaces. YUV operates on
the empirical evidence that the human eye is more sensitive to variations
in the intensity of a pixel rather than variations in color.  Thus, every
pixel in a YUV image has an associated Y sample, but groups of pixels
share U and V samples.

For example, examine the YUY2 colorspace, a.k.a., YUV 4:2:2 or just
YUV422. This is a packed YUV colorspace, which means that the Y, U, and V
samples are interleaved. The YUV data is laid out in memory as follows
(each sample is one byte):

  Y0 U Y1 V   Y0 U Y1 V  Y0 U Y1 V

Each group of 4 bytes represents 2 pixels. The first pixel is represented 
by (Y0, U, V) and the second by (Y1, U, V). So each pixel gets a Y sample 
but has to share a U and a V sample.

Perhaps the most common YUV format is I420, a.k.a. YUV 4:2:0 or just
YUV420. This is the format used in JPEG, MPEG, and many other modern video
codecs. The most notable difference between this colorspace and any other
discussed up to this point is that it is a planar format, not a packed
format. This means that when the data is stored in memory-- all of the Y
data is stored first, then all of the U data, then all of the V data.

In I420 data, pixels are grouped in 2x2 blocks:

  p0 p1
  p2 p3

For each 2x2 block, each pixel is presented by a Y sample. But each pixel 
in the block shares a U and a V sample:

  Y0 Y1  U  V
  Y2 Y3

As a highly contrived example, consider a I420 image that is 6x2 pixels.

   p0  p1  p2  p3  p4  p5
   p6  p7  p8  p9 p10 p11 

The image will be broken up into 3 2x2 blocks for the purpose of 
representing it as I420:

   p0  p1 |  Y0  Y1  U0 V0
   p6  p7 |  Y6  Y7
          |
   p2  p3 |  Y2  Y3  U1 V1
   p8  p9 |  Y8  Y9
          |
   p4  p5 |  Y4  Y5  U2 V2
  p10 p11 | Y10 Y11

The planes of data will be stored in memory as:

  Y0 Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 Y9 Y10 Y11 U0 U1 U2 V0 V1 V2

Another common planar format is YV12. This is precisely the same as I420 
except that U and V data planes are reversed.

Another planar YUV format occasionally seen is YUV9, a.k.a. YUV 4:1:0 or 
just YUV410. This is equivalent to I420 except that an image is broken 
into 4x4 pixel blocks. Each pixel gets its own Y sample while each block 
shares one U and one V sample over the entire block.

Of course, there is also non-subsampled planar YUV available, YUV 4:4:4. 
In other words, every pixel is represented by a Y, U, and V sample.

Notice that YUY2, I420, and YUV9 are all valid FourCCs. Where do these
FourCCs come from? I strongly suspect it is related to how many bits or
bytes are required to store a single pixel, on average. For YUY2 data, 4
bytes represent 2 pixels, so 2 bytes on average are required to
represent 1 pixel. In I420 data:

  4 + 1 + 1 = 6 bytes * 8 bits/byte = 48 bits / 4 pixels = 12 bits/pixel

And for YUV9 data:

  (16 + 1 + 1) * 8 = 144 bits / 16 pixels = 9 bits/pixel

Note that it is conceptually possible for RGB data to be stored in a
planar manner rather than packed. In practice, this is rarely done.


References
----------
The Almost Definitive FOURCC Definition List
http://www.fourcc.org/

RGB/YUV Pixel Conversion
http://www.fourcc.org/fccyvrgb.htm


Acknowledgements
----------------
Torben Nielsen (torben at Hawaii.Edu) for correcting 

Diego Biurrun (diego at biurrun.de) for cosmetic English composition 
fixes.


Changelog
---------
v1.1: September 25, 2005
- replaced YV12 with I420 (correct FourCC) and noted what YV12 really 
means
- English composition fixes

v1.0: June 14, 2003
- initial release


GNU Free Documentation License
------------------------------
see http://www.gnu.org/licenses/fdl.html
