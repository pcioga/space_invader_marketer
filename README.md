# Marketer Space Invaders ruby assignment

## How to run

On your terminal go to the project root folder and simply enter:

```
bin/scan
```

Or if you need to give the execution permission:

```
chmod +x bin/scan
```

You will be asked to load a .txt file containing the radar sample you want to scan:

```
Please enter the radar filename (e.g., radar.txt):
```

Enter the name of your radar file and next you will be prompt to choose which known invaders you want to search for:

```
Please enter an invader type (e.g., invader1) or enter 'all':
```

Enter 'all' if you want to scan for all invader types or simply enter the type of a known invader.

And that's it! You should now see on your terminal all the confirmed locations and false positives for each invader on the provided sample.

## Known invaders:

Type: 'invader1'

```
--o-----o--
---o---o---
--ooooooo--
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
```

Type: 'invader2'

```
---oo---
--oooo--
-oooooo-
oo-oo-oo
oooooooo
--o--o--
-o-oo-o-
o-o--o-o
```

## Included radar samples:

- `radar.txt` - this is the sample included on the assignment description
- `radar_small.txt` - this is a small sample 2x3 to test samples smaller than the invader patterns
- `radar_with_invader1.txt` - this sample simply contains the pattern of the invader1
- `radar_with_two_invader1.txt` - this sample contains the pattern of the invader1 duplicated
- `radar_with_two_invaders.txt` - This sample contains the two known invaders

### Pedro Cioga - November 2024
