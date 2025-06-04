# Benchmark Results 06/04/2025 22:49:03

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
 Mem:            31Gi       4,8Gi        16Gi       1,2Gi        11Gi        26Gi 
 Swap:          4,0Gi          0B       4,0Gi 

```

***rustc***
```
rustc 1.86.0 (05f9846f8 2025-03-31) 

```

***G++***
```
g++ (GCC) 15.1.1 20250425 
 Copyright (C) 2025 Free Software Foundation, Inc. 
 This is free software; see the source for copying conditions.  There is NO 
 warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
  

```

***Java***
```
openjdk 11.0.27 2025-04-15 
 OpenJDK Runtime Environment (build 11.0.27+6) 
 OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode) 

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

***node***
```
v22.15.1 

```

***PowerShell***
```
7.4.7 

```


## giant.xml (2,585.49 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 2.020      | 1,279.738         | 1.72         |
| 2    | C++ (pugixml)             | 3.773      | 685.282           | 6,077.05     |
| 3    | C++ (rapidxml)            | 4.099      | 630.702           | 7,592.70     |
| 4    | .NET                      | 4.774      | 541.559           | 45.69        |
| 5    | C++ (libxml2 - sax)       | 9.280      | 278.609           | 6.96         |
| 6    | java                      | 9.802      | 263.778           | 298.64       |
| 7    | pwsh                      | 12.831     | 201.505           | 164.98       |
| 8    | C++ (libxml2 - reader)    | 15.587     | 165.873           | 7.23         |
| 9    | C++ (xerces)              | 26.753     | 96.642            | 15.00        |
| 10   | xsl - saxon-he-12.7       | 41.039     | 63.001            | 8,504.96     |
| 11   | python                    | 63.065     | 40.998            | 10,089.97    |
| 12   | node                      | 81.977     | 31.539            | 88.28        |

## huge.xml (646.91 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.511      | 1,266.623         | 2.08         |
| 2    | C++ (pugixml)             | 0.970      | 666.818           | 1,522.75     |
| 3    | C++ (rapidxml)            | 1.116      | 579.788           | 1,901.76     |
| 4    | .NET                      | 1.405      | 460.423           | 45.96        |
| 5    | C++ (libxml2 - sax)       | 2.324      | 278.378           | 6.98         |
| 6    | java                      | 2.696      | 239.939           | 123.24       |
| 7    | pwsh                      | 3.796      | 170.405           | 164.02       |
| 8    | C++ (libxml2 - reader)    | 3.882      | 166.640           | 7.42         |
| 9    | C++ (xerces)              | 5.789      | 111.750           | 15.39        |
| 10   | xsl - saxon-he-12.7       | 9.338      | 69.276            | 2,662.02     |
| 11   | python                    | 15.330     | 42.199            | 2,533.31     |
| 12   | node                      | 20.510     | 31.541            | 70.13        |

## large.xml (129.20 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.127      | 1,020.108         | 2.02         |
| 2    | C++ (pugixml)             | 0.198      | 652.041           | 307.07       |
| 3    | C++ (rapidxml)            | 0.225      | 574.982           | 382.66       |
| 4    | C++ (libxml2 - sax)       | 0.471      | 274.131           | 7.05         |
| 5    | .NET                      | 0.549      | 235.131           | 43.76        |
| 6    | java                      | 0.785      | 164.565           | 99.28        |
| 7    | C++ (libxml2 - reader)    | 0.816      | 158.416           | 7.00         |
| 8    | C++ (xerces)              | 1.183      | 109.243           | 15.51        |
| 9    | pwsh                      | 1.484      | 87.079            | 164.59       |
| 10   | xsl - saxon-he-12.7       | 2.686      | 48.109            | 948.07       |
| 11   | python                    | 2.810      | 45.974            | 516.63       |
| 12   | node                      | 4.053      | 31.877            | 62.36        |

## mid.xml (12.91 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.017      | 759.786           | 1.93         |
| 2    | C++ (pugixml)             | 0.021      | 602.073           | 33.84        |
| 3    | C++ (rapidxml)            | 0.026      | 487.835           | 41.13        |
| 4    | C++ (libxml2 - sax)       | 0.050      | 256.899           | 7.07         |
| 5    | C++ (libxml2 - reader)    | 0.084      | 153.268           | 7.17         |
| 6    | C++ (xerces)              | 0.125      | 103.296           | 15.45        |
| 7    | .NET                      | 0.138      | 93.761            | 35.17        |
| 8    | python                    | 0.259      | 49.864            | 63.19        |
| 9    | java                      | 0.285      | 45.268            | 89.70        |
| 10   | pwsh                      | 0.507      | 25.445            | 162.86       |
| 11   | node                      | 0.527      | 24.523            | 59.05        |
| 12   | xsl - saxon-he-12.7       | 1.338      | 9.651             | 261.77       |

## small.xml (1.30 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.003      | 475.061           | 1.89         |
| 2    | C++ (pugixml)             | 0.005      | 281.175           | 6.16         |
| 3    | C++ (rapidxml)            | 0.006      | 227.690           | 7.11         |
| 4    | C++ (libxml2 - reader)    | 0.010      | 127.026           | 7.22         |
| 5    | C++ (libxml2 - sax)       | 0.011      | 122.857           | 6.98         |
| 6    | C++ (xerces)              | 0.021      | 60.781            | 15.44        |
| 7    | python                    | 0.050      | 25.815            | 17.83        |
| 8    | .NET                      | 0.056      | 23.247            | 34.59        |
| 9    | node                      | 0.124      | 10.418            | 58.73        |
| 10   | java                      | 0.184      | 7.060             | 77.19        |
| 11   | pwsh                      | 0.382      | 3.391             | 157.84       |
| 12   | xsl - saxon-he-12.7       | 0.924      | 1.403             | 166.12       |

## tiny.xml (0.00 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.002      | 0.127             | 1.98         |
| 2    | C++ (libxml2 - sax)       | 0.002      | 0.102             | 7.13         |
| 3    | C++ (rapidxml)            | 0.002      | 0.097             | 3.29         |
| 4    | C++ (pugixml)             | 0.002      | 0.091             | 3.50         |
| 5    | C++ (libxml2 - reader)    | 0.003      | 0.070             | 7.10         |
| 6    | C++ (xerces)              | 0.007      | 0.033             | 15.24        |
| 7    | python                    | 0.027      | 0.008             | 12.83        |
| 8    | .NET                      | 0.044      | 0.005             | 33.77        |
| 9    | node                      | 0.045      | 0.005             | 46.14        |
| 10   | java                      | 0.119      | 0.002             | 55.81        |
| 11   | pwsh                      | 0.351      | 0.001             | 160.05       |
| 12   | xsl - saxon-he-12.7       | 0.811      | 0.000             | 138.83       |

