# Benchmark Results 06/12/2025 12:15:05

## System Information
```
Hostname: tpX13
Kernel: Linux 6.14.6-2-MANJARO x86_64 GNU/Linux
Distro: Manjaro Linux
CPU: 12th Gen Intel(R) Core(TM) i7-1270P
Disk: WD PC SN740 SDDQNQD-512G-1201
Memory: 31Gi
```

## Overall Results

![benchmark results](benchmark_tp_line.svg)


### behemoth.xml (3232.62 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 3.228      | 1,001.435         | 1.86         |
| 2    | C++ (pugixml)             | 4.943      | 653.967           | 7,596.75     |
| 3    | C++ (rapidxml)            | 5.658      | 571.314           | 9,491.59     |
| 4    | .NET 8 - XmlReader        | 6.115      | 528.651           | 43.88        |
| 5    | java-21 - SAX             | 9.296      | 347.740           | 83.89        |
| 6    | java-21 - StAX            | 10.966     | 294.776           | 120.19       |
| 7    | Scala                     | 11.400     | 283.554           | 5.23         |
| 8    | C++ (libxml2 - SAX)       | 12.770     | 253.140           | 6.78         |
| 9    | PowerShell Core           | 15.250     | 211.979           | 122.48       |
| 10   | C++ (libxml2 XMLReader)   | 23.536     | 137.346           | 7.12         |
| 11   | C++ (xsde)                | 31.626     | 102.213           | 3.62         |
| 12   | Saxon HE 12               | 34.899     | 92.628            | 10,998.40    |
| 13   | C++ (Apache Xerces)       | 42.526     | 76.015            | 14.86        |
| 14   | Julia (LightXML)          | 44.951     | 71.914            | 28,238.82    |
| 15   | Go - std                  | 64.372     | 50.218            | 8.36         |
| 16   | Python 3                  | 76.377     | 42.325            | 12,611.12    |
| 17   | Go - xmlquery             | 79.850     | 40.483            | 16,754.89    |
| 18   | Node.js                   | 101.656    | 31.800            | 83.14        |
| 19   | Rust (xml-rs)             | 103.429    | 31.254            | 2.04         |


### giant.xml (1939.36 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 2.432      | 797.538           | 1.93         |
| 2    | .NET 8 - XmlReader        | 3.387      | 572.545           | 44.08        |
| 3    | C++ (pugixml)             | 3.751      | 517.053           | 4,558.82     |
| 4    | C++ (rapidxml)            | 4.129      | 469.641           | 5,695.69     |
| 5    | java-21 - SAX             | 6.904      | 280.911           | 82.79        |
| 6    | java-21 - StAX            | 7.600      | 255.168           | 119.14       |
| 7    | Scala                     | 8.263      | 234.700           | 5.25         |
| 8    | C++ (libxml2 - SAX)       | 8.958      | 216.506           | 6.80         |
| 9    | PowerShell Core           | 10.630     | 182.450           | 124.00       |
| 10   | C++ (libxml2 XMLReader)   | 14.697     | 131.952           | 7.29         |
| 11   | C++ (xsde)                | 20.133     | 96.325            | 3.61         |
| 12   | Julia (LightXML)          | 23.567     | 82.292            | 17,073.18    |
| 13   | Saxon HE 12               | 23.882     | 81.206            | 6,490.09     |
| 14   | C++ (Apache Xerces)       | 27.888     | 69.541            | 15.12        |
| 15   | Go - std                  | 39.754     | 48.784            | 8.55         |
| 16   | Python 3                  | 47.769     | 40.599            | 7,571.22     |
| 17   | Go - xmlquery             | 48.972     | 39.602            | 10,007.64    |
| 18   | Node.js                   | 61.365     | 31.604            | 80.93        |
| 19   | Rust (xml-rs)             | 63.000     | 30.784            | 2.08         |


### huge.xml (646.47 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.974      | 663.518           | 2.09         |
| 2    | C++ (pugixml)             | 1.255      | 515.249           | 1,522.02     |
| 3    | C++ (rapidxml)            | 1.366      | 473.386           | 1,900.57     |
| 4    | .NET 8 - XmlReader        | 1.424      | 453.920           | 43.92        |
| 5    | java-21 - SAX             | 2.408      | 268.439           | 78.70        |
| 6    | java-21 - StAX            | 2.657      | 243.322           | 122.48       |
| 7    | C++ (libxml2 - SAX)       | 3.038      | 212.821           | 7.02         |
| 8    | Scala                     | 3.304      | 195.640           | 5.29         |
| 9    | PowerShell Core           | 4.216      | 153.326           | 123.68       |
| 10   | C++ (libxml2 XMLReader)   | 4.867      | 132.839           | 6.69         |
| 11   | C++ (xsde)                | 6.718      | 96.231            | 3.59         |
| 12   | Julia (LightXML)          | 8.302      | 77.867            | 5,873.26     |
| 13   | Saxon HE 12               | 8.431      | 76.675            | 3,069.20     |
| 14   | C++ (Apache Xerces)       | 9.420      | 68.629            | 15.12        |
| 15   | Go - std                  | 13.256     | 48.768            | 8.50         |
| 16   | Python 3                  | 15.636     | 41.345            | 2,532.28     |
| 17   | Go - xmlquery             | 16.193     | 39.923            | 3,461.21     |
| 18   | Node.js                   | 20.933     | 30.883            | 67.32        |
| 19   | Rust (xml-rs)             | 21.108     | 30.626            | 2.09         |


### large.xml (129.47 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.199      | 649.133           | 1.74         |
| 2    | C++ (pugixml)             | 0.256      | 505.249           | 307.46       |
| 3    | C++ (rapidxml)            | 0.284      | 455.841           | 383.01       |
| 4    | C++ (libxml2 - SAX)       | 0.596      | 217.307           | 6.99         |
| 5    | java-21 - SAX             | 0.618      | 209.586           | 75.59        |
| 6    | .NET 8 - XmlReader        | 0.650      | 199.174           | 41.55        |
| 7    | java-21 - StAX            | 0.683      | 189.456           | 98.13        |
| 8    | C++ (libxml2 XMLReader)   | 0.993      | 130.324           | 6.88         |
| 9    | Scala                     | 1.290      | 100.333           | 5.39         |
| 10   | C++ (xsde)                | 1.353      | 95.702            | 3.48         |
| 11   | PowerShell Core           | 1.551      | 83.451            | 124.07       |
| 12   | C++ (Apache Xerces)       | 1.839      | 70.408            | 15.24        |
| 13   | Julia (LightXML)          | 2.012      | 64.354            | 1,394.96     |
| 14   | Saxon HE 12               | 2.704      | 47.885            | 918.47       |
| 15   | Go - std                  | 2.712      | 47.735            | 8.22         |
| 16   | Python 3                  | 2.901      | 44.635            | 517.10       |
| 17   | Go - xmlquery             | 3.301      | 39.225            | 739.40       |
| 18   | Rust (xml-rs)             | 4.231      | 30.602            | 2.17         |
| 19   | Node.js                   | 4.239      | 30.544            | 58.64        |


### mid.xml (12.9 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.022      | 579.424           | 2.04         |
| 2    | C++ (pugixml)             | 0.030      | 431.077           | 33.54        |
| 3    | C++ (rapidxml)            | 0.033      | 389.668           | 40.93        |
| 4    | C++ (libxml2 - SAX)       | 0.067      | 193.498           | 7.24         |
| 5    | C++ (libxml2 XMLReader)   | 0.106      | 121.571           | 6.83         |
| 6    | C++ (xsde)                | 0.139      | 92.574            | 3.68         |
| 7    | .NET 8 - XmlReader        | 0.166      | 77.843            | 33.54        |
| 8    | java-21 - SAX             | 0.190      | 67.921            | 69.39        |
| 9    | C++ (Apache Xerces)       | 0.196      | 65.910            | 15.26        |
| 10   | java-21 - StAX            | 0.203      | 63.597            | 89.89        |
| 11   | Python 3                  | 0.271      | 47.629            | 63.28        |
| 12   | Go - std                  | 0.316      | 40.830            | 8.20         |
| 13   | Go - xmlquery             | 0.367      | 35.132            | 81.93        |
| 14   | Rust (xml-rs)             | 0.425      | 30.351            | 2.16         |
| 15   | Julia (LightXML)          | 0.479      | 26.906            | 363.20       |
| 16   | PowerShell Core           | 0.485      | 26.607            | 124.13       |
| 17   | Node.js                   | 0.495      | 26.038            | 55.35        |
| 18   | Scala                     | 0.809      | 15.940            | 5.26         |
| 19   | Saxon HE 12               | 1.374      | 9.384             | 263.94       |


### small.xml (2.6 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.007      | 356.969           | 1.96         |
| 2    | C++ (rapidxml)            | 0.009      | 294.175           | 10.63        |
| 3    | C++ (pugixml)             | 0.010      | 268.642           | 9.64         |
| 4    | C++ (libxml2 - SAX)       | 0.017      | 153.040           | 6.96         |
| 5    | C++ (libxml2 XMLReader)   | 0.024      | 110.081           | 6.73         |
| 6    | C++ (xsde)                | 0.035      | 74.533            | 3.76         |
| 7    | C++ (Apache Xerces)       | 0.050      | 51.920            | 15.34        |
| 8    | Go - std                  | 0.062      | 41.782            | 8.19         |
| 9    | Python 3                  | 0.079      | 32.917            | 22.86        |
| 10   | .NET 8 - XmlReader        | 0.081      | 32.090            | 32.61        |
| 11   | Go - xmlquery             | 0.081      | 31.943            | 26.15        |
| 12   | Rust (xml-rs)             | 0.089      | 29.205            | 2.01         |
| 13   | java-21 - StAX            | 0.136      | 19.098            | 78.21        |
| 14   | java-21 - SAX             | 0.142      | 18.297            | 64.95        |
| 15   | Node.js                   | 0.150      | 17.311            | 55.77        |
| 16   | PowerShell Core           | 0.340      | 7.658             | 122.17       |
| 17   | Julia (LightXML)          | 0.353      | 7.368             | 267.87       |
| 18   | Scala                     | 0.749      | 3.472             | 5.22         |
| 19   | Saxon HE 12               | 1.027      | 2.533             | 169.30       |


### tiny.xml (1.28 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.004      | 286.165           | 1.95         |
| 2    | C++ (pugixml)             | 0.006      | 212.099           | 6.57         |
| 3    | C++ (rapidxml)            | 0.007      | 180.401           | 6.89         |
| 4    | C++ (libxml2 - SAX)       | 0.011      | 119.565           | 6.51         |
| 5    | C++ (xsde)                | 0.016      | 79.170            | 3.91         |
| 6    | C++ (libxml2 XMLReader)   | 0.018      | 69.309            | 7.32         |
| 7    | C++ (Apache Xerces)       | 0.030      | 42.982            | 15.34        |
| 8    | Go - std                  | 0.035      | 36.315            | 7.86         |
| 9    | Go - xmlquery             | 0.043      | 29.926            | 16.04        |
| 10   | Rust (xml-rs)             | 0.046      | 27.997            | 1.97         |
| 11   | Python 3                  | 0.058      | 22.251            | 17.79        |
| 12   | .NET 8 - XmlReader        | 0.064      | 20.132            | 32.61        |
| 13   | Node.js                   | 0.109      | 11.711            | 55.65        |
| 14   | java-21 - SAX             | 0.133      | 9.666             | 59.56        |
| 15   | java-21 - StAX            | 0.142      | 8.995             | 79.46        |
| 16   | PowerShell Core           | 0.327      | 3.915             | 119.44       |
| 17   | Julia (LightXML)          | 0.335      | 3.820             | 254.73       |
| 18   | Scala                     | 0.749      | 1.710             | 5.23         |
| 19   | Saxon HE 12               | 0.958      | 1.337             | 149.51       |


### micro.xml (0.2 KB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.002      | 0.087             | 2.05         |
| 2    | C++ (rapidxml)            | 0.003      | 0.075             | 3.37         |
| 3    | Rust (xml-rs)             | 0.003      | 0.070             | 2.22         |
| 4    | Go - std                  | 0.003      | 0.070             | 3.52         |
| 5    | C++ (pugixml)             | 0.003      | 0.069             | 3.66         |
| 6    | C++ (xsde)                | 0.003      | 0.069             | 3.70         |
| 7    | C++ (libxml2 XMLReader)   | 0.004      | 0.061             | 7.09         |
| 8    | C++ (libxml2 - SAX)       | 0.004      | 0.059             | 7.24         |
| 9    | Go - xmlquery             | 0.004      | 0.055             | 6.95         |
| 10   | C++ (Apache Xerces)       | 0.011      | 0.019             | 15.33        |
| 11   | Python 3                  | 0.029      | 0.008             | 12.84        |
| 12   | Node.js                   | 0.042      | 0.005             | 43.14        |
| 13   | .NET 8 - XmlReader        | 0.056      | 0.004             | 31.74        |
| 14   | java-21 - StAX            | 0.071      | 0.003             | 61.07        |
| 15   | java-21 - SAX             | 0.073      | 0.003             | 46.09        |
| 16   | PowerShell Core           | 0.290      | 0.001             | 112.36       |
| 17   | Julia (LightXML)          | 0.323      | 0.001             | 243.86       |
| 18   | Scala                     | 0.662      | 0.000             | 5.29         |
| 19   | Saxon HE 12               | 0.867      | 0.000             | 117.22       |



## App - Results


### .NET 8 - XmlReader

xml-i in .NET

```
9.0.105
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 6.115      | 528.651           | 43.88        |
| giant.xml                 | 3.387      | 572.545           | 44.08        |
| huge.xml                  | 1.424      | 453.920           | 43.92        |
| large.xml                 | 0.650      | 199.174           | 41.55        |
| mid.xml                   | 0.166      | 77.843            | 33.54        |
| small.xml                 | 0.081      | 32.090            | 32.61        |
| tiny.xml                  | 0.064      | 20.132            | 32.61        |
| micro.xml                 | 0.056      | 0.004             | 31.74        |

### C++ (Apache Xerces)

xml-i in C++ powered by Apache Xerces


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 42.526     | 76.015            | 14.86        |
| giant.xml                 | 27.888     | 69.541            | 15.12        |
| huge.xml                  | 9.420      | 68.629            | 15.12        |
| large.xml                 | 1.839      | 70.408            | 15.24        |
| mid.xml                   | 0.196      | 65.910            | 15.26        |
| small.xml                 | 0.050      | 51.920            | 15.34        |
| tiny.xml                  | 0.030      | 42.982            | 15.34        |
| micro.xml                 | 0.011      | 0.019             | 15.33        |

### C++ (libxml2 - SAX)

xml-i in C++ powered by libxml2


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 12.770     | 253.140           | 6.78         |
| giant.xml                 | 8.958      | 216.506           | 6.80         |
| huge.xml                  | 3.038      | 212.821           | 7.02         |
| large.xml                 | 0.596      | 217.307           | 6.99         |
| mid.xml                   | 0.067      | 193.498           | 7.24         |
| small.xml                 | 0.017      | 153.040           | 6.96         |
| tiny.xml                  | 0.011      | 119.565           | 6.51         |
| micro.xml                 | 0.004      | 0.059             | 7.24         |

### C++ (libxml2 XMLReader)

xml-i in C++ powered by libxml2 XMLReader


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 23.536     | 137.346           | 7.12         |
| giant.xml                 | 14.697     | 131.952           | 7.29         |
| huge.xml                  | 4.867      | 132.839           | 6.69         |
| large.xml                 | 0.993      | 130.324           | 6.88         |
| mid.xml                   | 0.106      | 121.571           | 6.83         |
| small.xml                 | 0.024      | 110.081           | 6.73         |
| tiny.xml                  | 0.018      | 69.309            | 7.32         |
| micro.xml                 | 0.004      | 0.061             | 7.09         |

### C++ (pugixml)

xml-i in C++ powered by pugixml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 4.943      | 653.967           | 7,596.75     |
| giant.xml                 | 3.751      | 517.053           | 4,558.82     |
| huge.xml                  | 1.255      | 515.249           | 1,522.02     |
| large.xml                 | 0.256      | 505.249           | 307.46       |
| mid.xml                   | 0.030      | 431.077           | 33.54        |
| small.xml                 | 0.010      | 268.642           | 9.64         |
| tiny.xml                  | 0.006      | 212.099           | 6.57         |
| micro.xml                 | 0.003      | 0.069             | 3.66         |

### C++ (rapidxml)

xml-i in C++ powered by rapidxml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 5.658      | 571.314           | 9,491.59     |
| giant.xml                 | 4.129      | 469.641           | 5,695.69     |
| huge.xml                  | 1.366      | 473.386           | 1,900.57     |
| large.xml                 | 0.284      | 455.841           | 383.01       |
| mid.xml                   | 0.033      | 389.668           | 40.93        |
| small.xml                 | 0.009      | 294.175           | 10.63        |
| tiny.xml                  | 0.007      | 180.401           | 6.89         |
| micro.xml                 | 0.003      | 0.075             | 3.37         |

### C++ (xsde)

xml-i in C++ powered by CodeSynthesis xsde


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 31.626     | 102.213           | 3.62         |
| giant.xml                 | 20.133     | 96.325            | 3.61         |
| huge.xml                  | 6.718      | 96.231            | 3.59         |
| large.xml                 | 1.353      | 95.702            | 3.48         |
| mid.xml                   | 0.139      | 92.574            | 3.68         |
| small.xml                 | 0.035      | 74.533            | 3.76         |
| tiny.xml                  | 0.016      | 79.170            | 3.91         |
| micro.xml                 | 0.003      | 0.069             | 3.70         |

### Go - std

xml-i in Go (using standard library encoding/xml)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 64.372     | 50.218            | 8.36         |
| giant.xml                 | 39.754     | 48.784            | 8.55         |
| huge.xml                  | 13.256     | 48.768            | 8.50         |
| large.xml                 | 2.712      | 47.735            | 8.22         |
| mid.xml                   | 0.316      | 40.830            | 8.20         |
| small.xml                 | 0.062      | 41.782            | 8.19         |
| tiny.xml                  | 0.035      | 36.315            | 7.86         |
| micro.xml                 | 0.003      | 0.070             | 3.52         |

### Go - xmlquery

xml-i in Go (using antchfx/xmlquery)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 79.850     | 40.483            | 16,754.89    |
| giant.xml                 | 48.972     | 39.602            | 10,007.64    |
| huge.xml                  | 16.193     | 39.923            | 3,461.21     |
| large.xml                 | 3.301      | 39.225            | 739.40       |
| mid.xml                   | 0.367      | 35.132            | 81.93        |
| small.xml                 | 0.081      | 31.943            | 26.15        |
| tiny.xml                  | 0.043      | 29.926            | 16.04        |
| micro.xml                 | 0.004      | 0.055             | 6.95         |

### java-21 - SAX

xml-i in pure Java (java-21-openjdk), using org.xml.sax

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 9.296      | 347.740           | 83.89        |
| giant.xml                 | 6.904      | 280.911           | 82.79        |
| huge.xml                  | 2.408      | 268.439           | 78.70        |
| large.xml                 | 0.618      | 209.586           | 75.59        |
| mid.xml                   | 0.190      | 67.921            | 69.39        |
| small.xml                 | 0.142      | 18.297            | 64.95        |
| tiny.xml                  | 0.133      | 9.666             | 59.56        |
| micro.xml                 | 0.073      | 0.003             | 46.09        |

### java-21 - StAX

xml-i in pure Java (java-21-openjdk), using javax.xml.stream

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 10.966     | 294.776           | 120.19       |
| giant.xml                 | 7.600      | 255.168           | 119.14       |
| huge.xml                  | 2.657      | 243.322           | 122.48       |
| large.xml                 | 0.683      | 189.456           | 98.13        |
| mid.xml                   | 0.203      | 63.597            | 89.89        |
| tiny.xml                  | 0.142      | 8.995             | 79.46        |
| small.xml                 | 0.136      | 19.098            | 78.21        |
| micro.xml                 | 0.071      | 0.003             | 61.07        |

### Julia (LightXML)

xml-i in Julia with LightXML

```
julia version 1.11.5
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 44.951     | 71.914            | 28,238.82    |
| giant.xml                 | 23.567     | 82.292            | 17,073.18    |
| huge.xml                  | 8.302      | 77.867            | 5,873.26     |
| large.xml                 | 2.012      | 64.354            | 1,394.96     |
| mid.xml                   | 0.479      | 26.906            | 363.20       |
| small.xml                 | 0.353      | 7.368             | 267.87       |
| tiny.xml                  | 0.335      | 3.820             | 254.73       |
| micro.xml                 | 0.323      | 0.001             | 243.86       |

### Node.js

xml-i in Node.js

```
v22.15.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 101.656    | 31.800            | 83.14        |
| giant.xml                 | 61.365     | 31.604            | 80.93        |
| huge.xml                  | 20.933     | 30.883            | 67.32        |
| large.xml                 | 4.239      | 30.544            | 58.64        |
| mid.xml                   | 0.495      | 26.038            | 55.35        |
| small.xml                 | 0.150      | 17.311            | 55.77        |
| tiny.xml                  | 0.109      | 11.711            | 55.65        |
| micro.xml                 | 0.042      | 0.005             | 43.14        |

### PowerShell Core

xml-i in pwsh

```

PSVersion    : 7.4.7
PSEdition    : Core
BuildVersion : 
CLRVersion   : 
OS           : Manjaro Linux

```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 15.250     | 211.979           | 122.48       |
| giant.xml                 | 10.630     | 182.450           | 124.00       |
| huge.xml                  | 4.216      | 153.326           | 123.68       |
| large.xml                 | 1.551      | 83.451            | 124.07       |
| mid.xml                   | 0.485      | 26.607            | 124.13       |
| small.xml                 | 0.340      | 7.658             | 122.17       |
| tiny.xml                  | 0.327      | 3.915             | 119.44       |
| micro.xml                 | 0.290      | 0.001             | 112.36       |

### Python 3

xml-i in Python 3

```
Python 3.13.3
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 76.377     | 42.325            | 12,611.12    |
| giant.xml                 | 47.769     | 40.599            | 7,571.22     |
| huge.xml                  | 15.636     | 41.345            | 2,532.28     |
| large.xml                 | 2.901      | 44.635            | 517.10       |
| mid.xml                   | 0.271      | 47.629            | 63.28        |
| small.xml                 | 0.079      | 32.917            | 22.86        |
| tiny.xml                  | 0.058      | 22.251            | 17.79        |
| micro.xml                 | 0.029      | 0.008             | 12.84        |

### Rust (quick-xml)

xml-i in Rust with quick-xml

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 3.228      | 1,001.435         | 1.86         |
| giant.xml                 | 2.432      | 797.538           | 1.93         |
| huge.xml                  | 0.974      | 663.518           | 2.09         |
| large.xml                 | 0.199      | 649.133           | 1.74         |
| mid.xml                   | 0.022      | 579.424           | 2.04         |
| small.xml                 | 0.007      | 356.969           | 1.96         |
| tiny.xml                  | 0.004      | 286.165           | 1.95         |
| micro.xml                 | 0.002      | 0.087             | 2.05         |

### Rust (xml-rs)

xml-i in Rust with xml-rs

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 103.429    | 31.254            | 2.04         |
| giant.xml                 | 63.000     | 30.784            | 2.08         |
| huge.xml                  | 21.108     | 30.626            | 2.09         |
| large.xml                 | 4.231      | 30.602            | 2.17         |
| mid.xml                   | 0.425      | 30.351            | 2.16         |
| small.xml                 | 0.089      | 29.205            | 2.01         |
| tiny.xml                  | 0.046      | 27.997            | 1.97         |
| micro.xml                 | 0.003      | 0.070             | 2.22         |

### Saxon HE 12

xml-i in xslt powered by Saxon HE 12

```
SaxonHE12-7J.zip
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 34.899     | 92.628            | 10,998.40    |
| giant.xml                 | 23.882     | 81.206            | 6,490.09     |
| huge.xml                  | 8.431      | 76.675            | 3,069.20     |
| large.xml                 | 2.704      | 47.885            | 918.47       |
| mid.xml                   | 1.374      | 9.384             | 263.94       |
| small.xml                 | 1.027      | 2.533             | 169.30       |
| tiny.xml                  | 0.958      | 1.337             | 149.51       |
| micro.xml                 | 0.867      | 0.000             | 117.22       |

### Scala

xml-i in Scala

```
Scala code runner version: 1.8.0
Scala version (default): 3.7.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 11.400     | 283.554           | 5.23         |
| giant.xml                 | 8.263      | 234.700           | 5.25         |
| huge.xml                  | 3.304      | 195.640           | 5.29         |
| large.xml                 | 1.290      | 100.333           | 5.39         |
| mid.xml                   | 0.809      | 15.940            | 5.26         |
| small.xml                 | 0.749      | 3.472             | 5.22         |
| tiny.xml                  | 0.749      | 1.710             | 5.23         |
| micro.xml                 | 0.662      | 0.000             | 5.29         |
