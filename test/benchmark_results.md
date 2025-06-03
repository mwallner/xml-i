# Benchmark Results 06/03/2025 22:36:22

## System Information
***Kernel***
```
Linux tpX13 6.14.6-2-MANJARO #1 SMP PREEMPT_DYNAMIC Wed, 14 May 2025 14:56:34 +0000 x86_64 GNU/Linux
```

***CPU***
```
12th Gen Intel(R) Core(TM) i7-1270P
```

***Memory***
```
               total        used        free      shared  buff/cache   available 
Mem:            31Gi       6,9Gi        15Gi       1,3Gi        10Gi        24Gi 
Swap:          4,0Gi          0B       4,0Gi
```

***rustc***
```
rustc 1.86.0 (05f9846f8 2025-03-31)
```

***G++***
```
g++ (GCC) 15.1.1 20250425 Copyright (C) 2025 Free Software Foundation, Inc. This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
```

***Java***
```
openjdk 11.0.27 2025-04-15 OpenJDK Runtime Environment (build 11.0.27+6) OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode)
```

***.NET***
```
net8.0
```

***python***
```
Python 3.13.3
```

***Saxon***
```
SaxonHE12-7J.zip
```

***PowerShell***
```
7.4.7
```


## giant.xml (2,585.49 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 2.024      | 1,277.279         | 2.02         |
| 2    | C++ (pugixml)             | 4.167      | 620.423           | 6,077.05     |
| 3    | .NET                      | 6.634      | 389.720           | 46.21        |
| 4    | java                      | 9.397      | 275.142           | 280.33       |
| 5    | C++ (libxml2 - sax)       | 11.272     | 229.369           | 7.17         |
| 6    | pwsh                      | 13.220     | 195.576           | 164.15       |
| 7    | C++ (libxml2 - reader)    | 19.462     | 132.850           | 6.86         |
| 8    | C++ (xerces)              | 33.159     | 77.972            | 15.05        |
| 9    | xsl - saxon-he-12.7       | 40.986     | 63.082            | 8,432.64     |
| 10   | python                    | 61.047     | 42.353            | 10,090.41    |

## huge.xml (646.91 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.513      | 1,260.352         | 1.99         |
| 2    | C++ (pugixml)             | 1.103      | 586.341           | 1,522.80     |
| 3    | .NET                      | 1.754      | 368.827           | 46.19        |
| 4    | java                      | 2.703      | 239.342           | 102.46       |
| 5    | C++ (libxml2 - sax)       | 2.748      | 235.411           | 7.32         |
| 6    | pwsh                      | 4.218      | 153.353           | 164.11       |
| 7    | C++ (libxml2 - reader)    | 4.688      | 138.003           | 7.05         |
| 8    | C++ (xerces)              | 5.943      | 108.858           | 15.35        |
| 9    | xsl - saxon-he-12.7       | 8.912      | 72.592            | 2,676.26     |
| 10   | python                    | 15.484     | 41.779            | 2,533.02     |

## large.xml (129.20 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.114      | 1,133.743         | 1.94         |
| 2    | C++ (pugixml)             | 0.237      | 544.321           | 306.73       |
| 3    | C++ (libxml2 - sax)       | 0.554      | 233.253           | 7.14         |
| 4    | .NET                      | 0.606      | 213.330           | 43.17        |
| 5    | java                      | 0.800      | 161.596           | 77.38        |
| 6    | C++ (libxml2 - reader)    | 0.912      | 141.703           | 7.34         |
| 7    | C++ (xerces)              | 1.120      | 115.362           | 15.39        |
| 8    | pwsh                      | 1.711      | 75.494            | 163.82       |
| 9    | xsl - saxon-he-12.7       | 2.774      | 46.582            | 904.77       |
| 10   | python                    | 2.828      | 45.682            | 516.35       |

## mid.xml (12.91 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.016      | 797.607           | 2.00         |
| 2    | C++ (pugixml)             | 0.027      | 484.333           | 33.90        |
| 3    | C++ (libxml2 - sax)       | 0.057      | 225.784           | 6.76         |
| 4    | C++ (libxml2 - reader)    | 0.100      | 129.225           | 7.27         |
| 5    | C++ (xerces)              | 0.116      | 111.639           | 15.61        |
| 6    | .NET                      | 0.176      | 73.411            | 35.27        |
| 7    | python                    | 0.260      | 49.711            | 63.12        |
| 8    | java                      | 0.277      | 46.623            | 72.28        |
| 9    | pwsh                      | 0.683      | 18.915            | 163.86       |
| 10   | xsl - saxon-he-12.7       | 1.493      | 8.647             | 272.26       |

## small.xml (1.30 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.003      | 394.666           | 0.83         |
| 2    | C++ (pugixml)             | 0.006      | 212.998           | 6.58         |
| 3    | C++ (libxml2 - sax)       | 0.008      | 169.496           | 7.34         |
| 4    | C++ (libxml2 - reader)    | 0.016      | 82.506            | 7.23         |
| 5    | C++ (xerces)              | 0.020      | 65.772            | 15.45        |
| 6    | python                    | 0.049      | 26.193            | 17.98        |
| 7    | .NET                      | 0.065      | 20.033            | 34.60        |
| 8    | java                      | 0.207      | 6.266             | 66.64        |
| 9    | pwsh                      | 0.450      | 2.878             | 158.07       |
| 10   | xsl - saxon-he-12.7       | 0.939      | 1.380             | 169.88       |

## tiny.xml (0.00 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.002      | 0.120             | 1.99         |
| 2    | C++ (pugixml)             | 0.003      | 0.082             | 3.45         |
| 3    | C++ (libxml2 - sax)       | 0.003      | 0.067             | 7.23         |
| 4    | C++ (libxml2 - reader)    | 0.003      | 0.065             | 7.20         |
| 5    | C++ (xerces)              | 0.009      | 0.024             | 15.68        |
| 6    | python                    | 0.027      | 0.008             | 12.78        |
| 7    | .NET                      | 0.062      | 0.004             | 33.64        |
| 8    | java                      | 0.125      | 0.002             | 45.20        |
| 9    | pwsh                      | 0.392      | 0.001             | 155.05       |
| 10   | xsl - saxon-he-12.7       | 0.930      | 0.000             | 144.27       |

