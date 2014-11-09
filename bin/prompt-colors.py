#!/usr/bin/python
# generate a shell script containing acceptable colors to use
# for usernames and hostnames in prompts

# colors for non-256 color capable terms
colors_16 = []
# 0 is black, we use 1 (red) and 2 (green) for git branches, 7 is gray
colors_16 += range(3,7)
# we use 9 for error
colors_16.append(10)
# we use 11 for git branches, 15 is white
colors_16 += range(12,15)

def to_term(num):
	return '"%s;%s"' % (1 * (num / 8), 30 + (num % 8))

print "export COLORS_16=(%s)" % ' '.join(map(to_term, colors_16))

# colors for cool terminals
colors_256 = list(colors_16)
colors_256 += range(22,46)
colors_256 += range(58,82)
colors_256 += range(99,113)
colors_256 += range(124,154)
colors_256 += range(160,188)
colors_256 += range(196,220)

print "export COLORS_256=(%s)" % ' '.join(map(str, colors_256))
