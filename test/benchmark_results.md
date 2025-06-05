# Benchmark Results 06/05/2025 07:04:57

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
 Mem:            31Gi       6,5Gi        17Gi       1,3Gi       8,4Gi        24Gi 
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

***scala***
```
Scala code runner version: 1.8.0 
 Scala version (default): 3.7.1 

```

***PowerShell***
```
7.4.7 

```


## giant.xml (2,585.49 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 2.060      | 1,255.391         | 1.96         |
| 2    | C++ (pugixml)             | 3.573      | 723.645           | 6,076.69     |
| 3    | C++ (rapidxml)            | 4.029      | 641.763           | 7,592.69     |
| 4    | .NET                      | 5.621      | 459.997           | 46.06        |
| 5    | C++ (libxml2 - sax)       | 9.485      | 272.601           | 7.03         |
| 6    | Java                      | 9.615      | 268.891           | 300.21       |
| 7    | Scala                     | 9.729      | 265.741           | 5.43         |
| 8    | pwsh                      | 11.901     | 217.244           | 148.34       |
| 9    | C++ (libxml2 - reader)    | 15.772     | 163.925           | 7.27         |
| 10   | C++ (xerces)              | 26.435     | 97.805            | 15.40        |
| 11   | xsl - saxon-he-12.7       | 38.390     | 67.349            | 8,433.43     |
| 12   | Python                    | 60.494     | 42.739            | 10,090.16    |
| 13   | node                      | 78.687     | 32.858            | 86.28        |

## huge.xml (646.91 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.507      | 1,277.210         | 1.89         |
| 2    | C++ (pugixml)             | 0.900      | 718.647           | 1,522.84     |
| 3    | C++ (rapidxml)            | 1.013      | 638.667           | 1,901.77     |
| 4    | .NET                      | 1.440      | 449.326           | 45.68        |
| 5    | C++ (libxml2 - sax)       | 2.374      | 272.509           | 6.49         |
| 6    | Java                      | 2.568      | 251.888           | 127.40       |
| 7    | Scala                     | 3.056      | 211.699           | 5.26         |
| 8    | pwsh                      | 3.564      | 181.491           | 149.16       |
| 9    | C++ (libxml2 - reader)    | 3.963      | 163.250           | 6.93         |
| 10   | C++ (xerces)              | 5.965      | 108.453           | 15.28        |
| 11   | xsl - saxon-he-12.7       | 8.987      | 71.985            | 2,721.00     |
| 12   | Python                    | 13.755     | 47.032            | 2,533.02     |
| 13   | node                      | 19.660     | 32.906            | 69.82        |

## large.xml (129.20 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.126      | 1,026.885         | 1.88         |
| 2    | C++ (pugixml)             | 0.189      | 683.373           | 306.78       |
| 3    | C++ (rapidxml)            | 0.209      | 618.644           | 382.48       |
| 4    | C++ (libxml2 - sax)       | 0.509      | 253.950           | 6.99         |
| 5    | .NET                      | 0.536      | 241.235           | 43.76        |
| 6    | Java                      | 0.758      | 170.530           | 99.03        |
| 7    | C++ (libxml2 - reader)    | 0.793      | 162.850           | 7.11         |
| 8    | C++ (xerces)              | 1.196      | 108.014           | 15.67        |
| 9    | Scala                     | 1.246      | 103.656           | 5.39         |
| 10   | pwsh                      | 1.491      | 86.639            | 148.63       |
| 11   | Python                    | 2.434      | 53.087            | 516.60       |
| 12   | xsl - saxon-he-12.7       | 2.517      | 51.339            | 910.52       |
| 13   | node                      | 3.974      | 32.508            | 61.08        |

## mid.xml (12.91 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.012      | 1,042.811         | 1.87         |
| 2    | C++ (pugixml)             | 0.021      | 625.355           | 33.96        |
| 3    | C++ (rapidxml)            | 0.027      | 470.308           | 41.07        |
| 4    | C++ (libxml2 - sax)       | 0.052      | 246.361           | 7.20         |
| 5    | C++ (libxml2 - reader)    | 0.087      | 148.310           | 7.41         |
| 6    | C++ (xerces)              | 0.117      | 110.128           | 15.49        |
| 7    | .NET                      | 0.141      | 91.723            | 35.08        |
| 8    | Python                    | 0.254      | 50.899            | 62.91        |
| 9    | Java                      | 0.272      | 47.512            | 86.38        |
| 10   | node                      | 0.494      | 26.122            | 57.73        |
| 11   | pwsh                      | 0.523      | 24.669            | 146.35       |
| 12   | Scala                     | 0.798      | 16.175            | 5.36         |
| 13   | xsl - saxon-he-12.7       | 1.263      | 10.224            | 270.07       |

## small.xml (1.30 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | C++ (rapidxml)            | 0.004      | 320.704           | 7.03         |
| 2    | Rust (quick-xml)          | 0.004      | 308.504           | 2.10         |
| 3    | C++ (pugixml)             | 0.005      | 251.185           | 6.46         |
| 4    | C++ (libxml2 - reader)    | 0.010      | 126.170           | 7.11         |
| 5    | C++ (libxml2 - sax)       | 0.011      | 118.300           | 6.93         |
| 6    | C++ (xerces)              | 0.019      | 66.997            | 15.34        |
| 7    | Python                    | 0.045      | 28.586            | 17.93        |
| 8    | .NET                      | 0.064      | 20.108            | 34.82        |
| 9    | node                      | 0.116      | 11.152            | 58.00        |
| 10   | Java                      | 0.169      | 7.660             | 80.97        |
| 11   | pwsh                      | 0.381      | 3.402             | 142.73       |
| 12   | Scala                     | 0.717      | 1.808             | 5.38         |
| 13   | xsl - saxon-he-12.7       | 0.854      | 1.518             | 171.06       |

## tiny.xml (0.00 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.002      | 0.129             | 1.80         |
| 2    | C++ (libxml2 - sax)       | 0.002      | 0.091             | 7.08         |
| 3    | C++ (libxml2 - reader)    | 0.002      | 0.088             | 6.91         |
| 4    | C++ (rapidxml)            | 0.003      | 0.086             | 1.68         |
| 5    | C++ (pugixml)             | 0.003      | 0.080             | 3.49         |
| 6    | C++ (xerces)              | 0.009      | 0.024             | 15.17        |
| 7    | Python                    | 0.022      | 0.010             | 12.83        |
| 8    | node                      | 0.047      | 0.005             | 45.50        |
| 9    | .NET                      | 0.066      | 0.003             | 33.22        |
| 10   | Java                      | 0.125      | 0.002             | 57.48        |
| 11   | pwsh                      | 0.365      | 0.001             | 139.17       |
| 12   | Scala                     | 0.642      | 0.000             | 5.30         |
| 13   | xsl - saxon-he-12.7       | 0.763      | 0.000             | 141.12       |

