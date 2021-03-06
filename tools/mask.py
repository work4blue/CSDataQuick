#!/usr/bin/env python
"""
    Create the border images for button frame
"""
from PIL import Image
im = Image.new("RGBA", (8, 8))

# top
for y in range(2):
    for x in range(8):
        im.putpixel((x,y), (255,255,255,150))
im.putpixel((7,1), (0, 0, 0, 120))

# left
for x in range(2):
    for y in range(8):
        im.putpixel((x,y), (255,255,255,150))
im.putpixel((1,7), (0, 0, 0, 120))

# bottom
for y in range(6,8):
    for x in range(2,8):
        im.putpixel((x,y), (0, 0, 0, 120))

# right
for x in range(6,8):
    for y in range(2,8):
        im.putpixel((x,y), (0, 0, 0, 120))

im.save('button_up.png')

im = Image.new("RGBA", (8, 8))
# top
for y in range(2):
    for x in range(8):
        im.putpixel((x,y), (0,0,0,150))
im.putpixel((7,1), (255, 255, 255, 120))

# left
for x in range(2):
    for y in range(8):
        im.putpixel((x,y), (0,0,0,150))
im.putpixel((1,7), (255, 255, 255, 120))

# bottom
for y in range(6,8):
    for x in range(2,8):
        im.putpixel((x,y), (255, 255, 255, 120))

# right
for x in range(6,8):
    for y in range(2,8):
        im.putpixel((x,y), (255, 255, 255, 120))

im.save('button_down.png')

im = Image.new("RGBA", (2, 8))
for y in range(8):
    im.putpixel((0,y), (0, 0, 0, 150))
    im.putpixel((1,y), (255, 255, 255, 120))
im.save('vert_groove.png')

im = Image.new("RGBA", (8, 2))
for x in range(8):
    im.putpixel((x,0), (0, 0, 0, 150))
    im.putpixel((x,1), (255, 255, 255, 120))
im.save('horz_groove.png')

