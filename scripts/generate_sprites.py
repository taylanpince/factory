template = "<key>%(key)d</key><integer>%(val)d</integer>"

for i in range(1, 157):
    if i % 24 == 0 or i % 24 > 12:
        if (i + 3) % 4 == 0:
            val = i + 3
        else:
            val = i - 1
        print template % {
            "key": i,
            "val": val,
        }
    else:
        if i % 4 == 0:
            val = i - 3
        else:
            val = i + 1
        print template % {
            "key": i,
            "val": val,
        }
