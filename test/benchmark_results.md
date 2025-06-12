# Benchmark Results 06/12/2025 17:31:48

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

![benchmark results x/y](benchmark_xy.svg)


### behemoth.xml (3232.62 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 3.113      | 1,038.351         | 1.92         |
| 2    | C++ (pugixml)             | 4.790      | 674.933           | 7,596.45     |
| 3    | .NET 8 - XmlReader        | 5.416      | 596.838           | 44.45        |
| 4    | C++ (rapidxml)            | 5.539      | 583.658           | 9,491.79     |
| 5    | java-21 - SAX             | 8.529      | 379.009           | 84.10        |
| 6    | java-21 - StAX            | 10.562     | 306.054           | 118.90       |
| 7    | Scala                     | 12.283     | 263.170           | 5.28         |
| 8    | C++ (libxml2 - SAX)       | 14.146     | 228.520           | 6.96         |
| 9    | PowerShell Core           | 14.481     | 223.228           | 122.80       |
| 10   | C++ (libxml2 XMLReader)   | 21.779     | 148.425           | 7.04         |
| 11   | C++ (xsde)                | 30.047     | 107.584           | 3.71         |
| 12   | Saxon HE 12               | 32.651     | 99.005            | 10,904.73    |
| 13   | C++ (Apache Xerces)       | 38.396     | 84.191            | 15.11        |
| 14   | Julia (LightXML)          | 41.375     | 78.131            | 28,275.55    |
| 15   | Go - std                  | 59.900     | 53.967            | 8.38         |
| 16   | Python 3                  | 71.849     | 44.992            | 12,611.14    |
| 17   | Go - xmlquery             | 77.297     | 41.821            | 17,028.48    |
| 18   | Node.js                   | 96.984     | 33.331            | 84.99        |
| 19   | Rust (xml-rs)             | 99.201     | 32.587            | 2.09         |


### giant.xml (1939.36 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 1.956      | 991.533           | 2.02         |
| 2    | C++ (pugixml)             | 3.503      | 553.626           | 4,558.77     |
| 3    | .NET 8 - XmlReader        | 3.643      | 532.403           | 43.95        |
| 4    | C++ (rapidxml)            | 4.021      | 482.330           | 5,695.89     |
| 5    | java-21 - SAX             | 6.702      | 289.354           | 81.87        |
| 6    | java-21 - StAX            | 7.492      | 258.856           | 121.74       |
| 7    | Scala                     | 7.735      | 250.727           | 5.26         |
| 8    | C++ (libxml2 - SAX)       | 9.640      | 201.178           | 6.96         |
| 9    | PowerShell Core           | 9.843      | 197.026           | 124.18       |
| 10   | C++ (libxml2 XMLReader)   | 14.204     | 136.534           | 7.23         |
| 11   | C++ (xsde)                | 21.729     | 89.254            | 3.50         |
| 12   | Julia (LightXML)          | 22.746     | 85.261            | 17,073.27    |
| 13   | Saxon HE 12               | 23.224     | 83.508            | 6,583.74     |
| 14   | C++ (Apache Xerces)       | 24.209     | 80.108            | 15.44        |
| 15   | Go - std                  | 38.285     | 50.655            | 8.81         |
| 16   | Python 3                  | 46.235     | 41.946            | 7,571.53     |
| 17   | Go - xmlquery             | 47.398     | 40.917            | 10,149.11    |
| 18   | Node.js                   | 59.098     | 32.816            | 83.09        |
| 19   | Rust (xml-rs)             | 61.227     | 31.675            | 1.95         |


### huge.xml (646.47 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.620      | 1,043.420         | 1.98         |
| 2    | C++ (pugixml)             | 1.232      | 524.604           | 1,522.08     |
| 3    | C++ (rapidxml)            | 1.338      | 483.308           | 1,900.75     |
| 4    | .NET 8 - XmlReader        | 1.697      | 381.036           | 44.00        |
| 5    | java-21 - SAX             | 2.342      | 275.993           | 77.46        |
| 6    | java-21 - StAX            | 2.594      | 249.256           | 120.44       |
| 7    | C++ (libxml2 - SAX)       | 2.774      | 233.076           | 7.04         |
| 8    | Scala                     | 3.100      | 208.522           | 5.22         |
| 9    | PowerShell Core           | 4.061      | 159.184           | 124.27       |
| 10   | C++ (libxml2 XMLReader)   | 4.700      | 137.554           | 7.27         |
| 11   | C++ (xsde)                | 6.257      | 103.315           | 3.69         |
| 12   | Saxon HE 12               | 7.719      | 83.752            | 3,115.53     |
| 13   | Julia (LightXML)          | 7.774      | 83.154            | 5,872.74     |
| 14   | C++ (Apache Xerces)       | 8.234      | 78.514            | 14.98        |
| 15   | Go - std                  | 12.826     | 50.403            | 8.55         |
| 16   | Python 3                  | 15.342     | 42.137            | 2,532.27     |
| 17   | Go - xmlquery             | 15.749     | 41.047            | 3,381.89     |
| 18   | Node.js                   | 20.116     | 32.137            | 68.85        |
| 19   | Rust (xml-rs)             | 20.460     | 31.596            | 1.98         |


### large.xml (129.47 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.136      | 949.610           | 2.03         |
| 2    | C++ (pugixml)             | 0.248      | 521.839           | 307.30       |
| 3    | C++ (rapidxml)            | 0.278      | 466.218           | 383.16       |
| 4    | C++ (libxml2 - SAX)       | 0.575      | 225.288           | 6.76         |
| 5    | java-21 - SAX             | 0.606      | 213.481           | 73.65        |
| 6    | .NET 8 - XmlReader        | 0.616      | 210.336           | 41.65        |
| 7    | java-21 - StAX            | 0.647      | 200.083           | 99.86        |
| 8    | C++ (libxml2 XMLReader)   | 0.939      | 137.950           | 6.64         |
| 9    | Scala                     | 1.230      | 105.246           | 5.25         |
| 10   | C++ (xsde)                | 1.282      | 100.957           | 3.61         |
| 11   | PowerShell Core           | 1.506      | 85.945            | 124.26       |
| 12   | C++ (Apache Xerces)       | 1.686      | 76.810            | 15.37        |
| 13   | Julia (LightXML)          | 1.878      | 68.932            | 1,394.34     |
| 14   | Go - std                  | 2.579      | 50.201            | 8.33         |
| 15   | Saxon HE 12               | 2.615      | 49.516            | 909.00       |
| 16   | Python 3                  | 2.819      | 45.928            | 517.03       |
| 17   | Go - xmlquery             | 3.183      | 40.671            | 695.74       |
| 18   | Node.js                   | 4.043      | 32.024            | 60.60        |
| 19   | Rust (xml-rs)             | 4.101      | 31.573            | 2.04         |


### mid.xml (12.9 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.015      | 863.358           | 1.94         |
| 2    | C++ (pugixml)             | 0.029      | 451.957           | 33.68        |
| 3    | C++ (rapidxml)            | 0.032      | 407.586           | 40.91        |
| 4    | C++ (libxml2 - SAX)       | 0.064      | 200.759           | 7.10         |
| 5    | C++ (libxml2 XMLReader)   | 0.099      | 130.232           | 6.91         |
| 6    | C++ (xsde)                | 0.135      | 95.561            | 3.71         |
| 7    | java-21 - SAX             | 0.169      | 76.144            | 67.60        |
| 8    | .NET 8 - XmlReader        | 0.170      | 75.880            | 33.39        |
| 9    | C++ (Apache Xerces)       | 0.181      | 71.096            | 15.50        |
| 10   | java-21 - StAX            | 0.189      | 68.367            | 90.87        |
| 11   | Go - std                  | 0.261      | 49.493            | 8.35         |
| 12   | Python 3                  | 0.266      | 48.521            | 63.11        |
| 13   | Go - xmlquery             | 0.335      | 38.489            | 77.77        |
| 14   | Rust (xml-rs)             | 0.413      | 31.228            | 2.04         |
| 15   | PowerShell Core           | 0.466      | 27.665            | 122.73       |
| 16   | Julia (LightXML)          | 0.473      | 27.291            | 362.21       |
| 17   | Node.js                   | 0.475      | 27.124            | 58.18        |
| 18   | Scala                     | 0.782      | 16.492            | 5.23         |
| 19   | Saxon HE 12               | 1.203      | 10.719            | 245.93       |


### small.xml (2.6 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.006      | 444.403           | 1.90         |
| 2    | C++ (rapidxml)            | 0.009      | 277.556           | 10.80        |
| 3    | C++ (pugixml)             | 0.011      | 246.499           | 9.52         |
| 4    | C++ (libxml2 - SAX)       | 0.018      | 142.939           | 7.06         |
| 5    | C++ (libxml2 XMLReader)   | 0.023      | 115.440           | 6.88         |
| 6    | C++ (xsde)                | 0.029      | 88.507            | 3.45         |
| 7    | C++ (Apache Xerces)       | 0.050      | 52.317            | 15.17        |
| 8    | Go - std                  | 0.058      | 45.050            | 8.20         |
| 9    | Python 3                  | 0.076      | 34.150            | 22.90        |
| 10   | .NET 8 - XmlReader        | 0.077      | 33.914            | 32.92        |
| 11   | Go - xmlquery             | 0.078      | 33.339            | 24.45        |
| 12   | Rust (xml-rs)             | 0.090      | 29.059            | 2.02         |
| 13   | java-21 - SAX             | 0.135      | 19.322            | 63.34        |
| 14   | java-21 - StAX            | 0.141      | 18.483            | 80.71        |
| 15   | Node.js                   | 0.147      | 17.663            | 57.21        |
| 16   | PowerShell Core           | 0.322      | 8.077             | 122.81       |
| 17   | Julia (LightXML)          | 0.351      | 7.414             | 267.19       |
| 18   | Scala                     | 0.734      | 3.543             | 5.25         |
| 19   | Saxon HE 12               | 1.023      | 2.544             | 170.26       |


### tiny.xml (1.28 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.004      | 345.629           | 1.98         |
| 2    | C++ (pugixml)             | 0.006      | 200.643           | 6.32         |
| 3    | C++ (rapidxml)            | 0.008      | 154.020           | 7.00         |
| 4    | C++ (libxml2 - SAX)       | 0.011      | 121.457           | 6.90         |
| 5    | C++ (libxml2 XMLReader)   | 0.016      | 82.586            | 7.45         |
| 6    | C++ (xsde)                | 0.022      | 59.035            | 3.56         |
| 7    | Go - std                  | 0.030      | 42.913            | 7.71         |
| 8    | C++ (Apache Xerces)       | 0.031      | 41.197            | 15.29        |
| 9    | Go - xmlquery             | 0.043      | 29.767            | 18.02        |
| 10   | Rust (xml-rs)             | 0.048      | 26.752            | 2.03         |
| 11   | Python 3                  | 0.051      | 24.994            | 17.59        |
| 12   | .NET 8 - XmlReader        | 0.069      | 18.486            | 32.77        |
| 13   | Node.js                   | 0.112      | 11.460            | 57.86        |
| 14   | java-21 - StAX            | 0.125      | 10.250            | 78.01        |
| 15   | java-21 - SAX             | 0.128      | 9.991             | 60.97        |
| 16   | PowerShell Core           | 0.312      | 4.104             | 119.59       |
| 17   | Julia (LightXML)          | 0.332      | 3.862             | 253.55       |
| 18   | Scala                     | 0.704      | 1.821             | 5.30         |
| 19   | Saxon HE 12               | 0.934      | 1.372             | 152.86       |


### micro.xml (0.2 KB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Go - std                  | 0.002      | 0.101             | 3.52         |
| 2    | Rust (quick-xml)          | 0.002      | 0.094             | 1.91         |
| 3    | Rust (xml-rs)             | 0.003      | 0.082             | 2.02         |
| 4    | C++ (pugixml)             | 0.003      | 0.076             | 3.63         |
| 5    | C++ (rapidxml)            | 0.003      | 0.072             | 3.45         |
| 6    | C++ (xsde)                | 0.003      | 0.070             | 3.45         |
| 7    | C++ (libxml2 - SAX)       | 0.004      | 0.059             | 6.61         |
| 8    | Go - xmlquery             | 0.004      | 0.058             | 6.87         |
| 9    | C++ (libxml2 XMLReader)   | 0.004      | 0.054             | 7.08         |
| 10   | C++ (Apache Xerces)       | 0.011      | 0.020             | 15.25        |
| 11   | Python 3                  | 0.027      | 0.008             | 12.74        |
| 12   | Node.js                   | 0.035      | 0.006             | 44.95        |
| 13   | .NET 8 - XmlReader        | 0.059      | 0.004             | 31.76        |
| 14   | java-21 - SAX             | 0.069      | 0.003             | 45.91        |
| 15   | java-21 - StAX            | 0.069      | 0.003             | 60.20        |
| 16   | PowerShell Core           | 0.272      | 0.001             | 112.57       |
| 17   | Julia (LightXML)          | 0.325      | 0.001             | 244.39       |
| 18   | Scala                     | 0.647      | 0.000             | 5.35         |
| 19   | Saxon HE 12               | 0.795      | 0.000             | 116.89       |


## App - Results


### .NET 8 - XmlReader

xml-i in .NET

```
9.0.105
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 5.416      | 596.838           | 44.45        |
| giant.xml                 | 3.643      | 532.403           | 43.95        |
| huge.xml                  | 1.697      | 381.036           | 44.00        |
| large.xml                 | 0.616      | 210.336           | 41.65        |
| mid.xml                   | 0.170      | 75.880            | 33.39        |
| small.xml                 | 0.077      | 33.914            | 32.92        |
| tiny.xml                  | 0.069      | 18.486            | 32.77        |
| micro.xml                 | 0.059      | 0.004             | 31.76        |

### C++ (Apache Xerces)

xml-i in C++ powered by Apache Xerces


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 38.396     | 84.191            | 15.11        |
| giant.xml                 | 24.209     | 80.108            | 15.44        |
| huge.xml                  | 8.234      | 78.514            | 14.98        |
| large.xml                 | 1.686      | 76.810            | 15.37        |
| mid.xml                   | 0.181      | 71.096            | 15.50        |
| small.xml                 | 0.050      | 52.317            | 15.17        |
| tiny.xml                  | 0.031      | 41.197            | 15.29        |
| micro.xml                 | 0.011      | 0.020             | 15.25        |

### C++ (libxml2 - SAX)

xml-i in C++ powered by libxml2


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 14.146     | 228.520           | 6.96         |
| giant.xml                 | 9.640      | 201.178           | 6.96         |
| huge.xml                  | 2.774      | 233.076           | 7.04         |
| large.xml                 | 0.575      | 225.288           | 6.76         |
| mid.xml                   | 0.064      | 200.759           | 7.10         |
| small.xml                 | 0.018      | 142.939           | 7.06         |
| tiny.xml                  | 0.011      | 121.457           | 6.90         |
| micro.xml                 | 0.004      | 0.059             | 6.61         |

### C++ (libxml2 XMLReader)

xml-i in C++ powered by libxml2 XMLReader


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 21.779     | 148.425           | 7.04         |
| giant.xml                 | 14.204     | 136.534           | 7.23         |
| huge.xml                  | 4.700      | 137.554           | 7.27         |
| large.xml                 | 0.939      | 137.950           | 6.64         |
| mid.xml                   | 0.099      | 130.232           | 6.91         |
| small.xml                 | 0.023      | 115.440           | 6.88         |
| tiny.xml                  | 0.016      | 82.586            | 7.45         |
| micro.xml                 | 0.004      | 0.054             | 7.08         |

### C++ (pugixml)

xml-i in C++ powered by pugixml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 4.790      | 674.933           | 7,596.45     |
| giant.xml                 | 3.503      | 553.626           | 4,558.77     |
| huge.xml                  | 1.232      | 524.604           | 1,522.08     |
| large.xml                 | 0.248      | 521.839           | 307.30       |
| mid.xml                   | 0.029      | 451.957           | 33.68        |
| small.xml                 | 0.011      | 246.499           | 9.52         |
| tiny.xml                  | 0.006      | 200.643           | 6.32         |
| micro.xml                 | 0.003      | 0.076             | 3.63         |

### C++ (rapidxml)

xml-i in C++ powered by rapidxml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 5.539      | 583.658           | 9,491.79     |
| giant.xml                 | 4.021      | 482.330           | 5,695.89     |
| huge.xml                  | 1.338      | 483.308           | 1,900.75     |
| large.xml                 | 0.278      | 466.218           | 383.16       |
| mid.xml                   | 0.032      | 407.586           | 40.91        |
| small.xml                 | 0.009      | 277.556           | 10.80        |
| tiny.xml                  | 0.008      | 154.020           | 7.00         |
| micro.xml                 | 0.003      | 0.072             | 3.45         |

### C++ (xsde)

xml-i in C++ powered by CodeSynthesis xsde


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 30.047     | 107.584           | 3.71         |
| giant.xml                 | 21.729     | 89.254            | 3.50         |
| huge.xml                  | 6.257      | 103.315           | 3.69         |
| large.xml                 | 1.282      | 100.957           | 3.61         |
| mid.xml                   | 0.135      | 95.561            | 3.71         |
| small.xml                 | 0.029      | 88.507            | 3.45         |
| tiny.xml                  | 0.022      | 59.035            | 3.56         |
| micro.xml                 | 0.003      | 0.070             | 3.45         |

### Go - std

xml-i in Go (using standard library encoding/xml)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 59.900     | 53.967            | 8.38         |
| giant.xml                 | 38.285     | 50.655            | 8.81         |
| huge.xml                  | 12.826     | 50.403            | 8.55         |
| large.xml                 | 2.579      | 50.201            | 8.33         |
| mid.xml                   | 0.261      | 49.493            | 8.35         |
| small.xml                 | 0.058      | 45.050            | 8.20         |
| tiny.xml                  | 0.030      | 42.913            | 7.71         |
| micro.xml                 | 0.002      | 0.101             | 3.52         |

### Go - xmlquery

xml-i in Go (using antchfx/xmlquery)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 77.297     | 41.821            | 17,028.48    |
| giant.xml                 | 47.398     | 40.917            | 10,149.11    |
| huge.xml                  | 15.749     | 41.047            | 3,381.89     |
| large.xml                 | 3.183      | 40.671            | 695.74       |
| mid.xml                   | 0.335      | 38.489            | 77.77        |
| small.xml                 | 0.078      | 33.339            | 24.45        |
| tiny.xml                  | 0.043      | 29.767            | 18.02        |
| micro.xml                 | 0.004      | 0.058             | 6.87         |

### java-21 - SAX

xml-i in pure Java (java-21-openjdk), using org.xml.sax

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 8.529      | 379.009           | 84.10        |
| giant.xml                 | 6.702      | 289.354           | 81.87        |
| huge.xml                  | 2.342      | 275.993           | 77.46        |
| large.xml                 | 0.606      | 213.481           | 73.65        |
| mid.xml                   | 0.169      | 76.144            | 67.60        |
| small.xml                 | 0.135      | 19.322            | 63.34        |
| tiny.xml                  | 0.128      | 9.991             | 60.97        |
| micro.xml                 | 0.069      | 0.003             | 45.91        |

### java-21 - StAX

xml-i in pure Java (java-21-openjdk), using javax.xml.stream

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 10.562     | 306.054           | 118.90       |
| giant.xml                 | 7.492      | 258.856           | 121.74       |
| huge.xml                  | 2.594      | 249.256           | 120.44       |
| large.xml                 | 0.647      | 200.083           | 99.86        |
| mid.xml                   | 0.189      | 68.367            | 90.87        |
| small.xml                 | 0.141      | 18.483            | 80.71        |
| tiny.xml                  | 0.125      | 10.250            | 78.01        |
| micro.xml                 | 0.069      | 0.003             | 60.20        |

### Julia (LightXML)

xml-i in Julia with LightXML

```
julia version 1.11.5
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 41.375     | 78.131            | 28,275.55    |
| giant.xml                 | 22.746     | 85.261            | 17,073.27    |
| huge.xml                  | 7.774      | 83.154            | 5,872.74     |
| large.xml                 | 1.878      | 68.932            | 1,394.34     |
| mid.xml                   | 0.473      | 27.291            | 362.21       |
| small.xml                 | 0.351      | 7.414             | 267.19       |
| tiny.xml                  | 0.332      | 3.862             | 253.55       |
| micro.xml                 | 0.325      | 0.001             | 244.39       |

### Node.js

xml-i in Node.js

```
v22.15.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 96.984     | 33.331            | 84.99        |
| giant.xml                 | 59.098     | 32.816            | 83.09        |
| huge.xml                  | 20.116     | 32.137            | 68.85        |
| large.xml                 | 4.043      | 32.024            | 60.60        |
| mid.xml                   | 0.475      | 27.124            | 58.18        |
| small.xml                 | 0.147      | 17.663            | 57.21        |
| tiny.xml                  | 0.112      | 11.460            | 57.86        |
| micro.xml                 | 0.035      | 0.006             | 44.95        |

### PowerShell Core

xml-i in pwsh

```

Name                           Value
----                           -----
PSVersion                      {[Major, 7], [Minor, 4], [Patch, 7], [PreReleaseLabel, ]…}
PSEdition                      Core
BuildVersion                   
CLRVersion                     
OS                             Manjaro Linux
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 14.481     | 223.228           | 122.80       |
| giant.xml                 | 9.843      | 197.026           | 124.18       |
| huge.xml                  | 4.061      | 159.184           | 124.27       |
| large.xml                 | 1.506      | 85.945            | 124.26       |
| mid.xml                   | 0.466      | 27.665            | 122.73       |
| small.xml                 | 0.322      | 8.077             | 122.81       |
| tiny.xml                  | 0.312      | 4.104             | 119.59       |
| micro.xml                 | 0.272      | 0.001             | 112.57       |

### Python 3

xml-i in Python 3

```
Python 3.13.3
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 71.849     | 44.992            | 12,611.14    |
| giant.xml                 | 46.235     | 41.946            | 7,571.53     |
| huge.xml                  | 15.342     | 42.137            | 2,532.27     |
| large.xml                 | 2.819      | 45.928            | 517.03       |
| mid.xml                   | 0.266      | 48.521            | 63.11        |
| small.xml                 | 0.076      | 34.150            | 22.90        |
| tiny.xml                  | 0.051      | 24.994            | 17.59        |
| micro.xml                 | 0.027      | 0.008             | 12.74        |

### Rust (quick-xml)

xml-i in Rust with quick-xml

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 3.113      | 1,038.351         | 1.92         |
| giant.xml                 | 1.956      | 991.533           | 2.02         |
| huge.xml                  | 0.620      | 1,043.420         | 1.98         |
| large.xml                 | 0.136      | 949.610           | 2.03         |
| mid.xml                   | 0.015      | 863.358           | 1.94         |
| small.xml                 | 0.006      | 444.403           | 1.90         |
| tiny.xml                  | 0.004      | 345.629           | 1.98         |
| micro.xml                 | 0.002      | 0.094             | 1.91         |

### Rust (xml-rs)

xml-i in Rust with xml-rs

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 99.201     | 32.587            | 2.09         |
| giant.xml                 | 61.227     | 31.675            | 1.95         |
| huge.xml                  | 20.460     | 31.596            | 1.98         |
| large.xml                 | 4.101      | 31.573            | 2.04         |
| mid.xml                   | 0.413      | 31.228            | 2.04         |
| small.xml                 | 0.090      | 29.059            | 2.02         |
| tiny.xml                  | 0.048      | 26.752            | 2.03         |
| micro.xml                 | 0.003      | 0.082             | 2.02         |

### Saxon HE 12

xml-i in xslt powered by Saxon HE 12

```
SaxonHE12-7J.zip
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 32.651     | 99.005            | 10,904.73    |
| giant.xml                 | 23.224     | 83.508            | 6,583.74     |
| huge.xml                  | 7.719      | 83.752            | 3,115.53     |
| large.xml                 | 2.615      | 49.516            | 909.00       |
| mid.xml                   | 1.203      | 10.719            | 245.93       |
| small.xml                 | 1.023      | 2.544             | 170.26       |
| tiny.xml                  | 0.934      | 1.372             | 152.86       |
| micro.xml                 | 0.795      | 0.000             | 116.89       |

### Scala

xml-i in Scala

```
Scala code runner version: 1.8.0
Scala version (default): 3.7.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 12.283     | 263.170           | 5.28         |
| giant.xml                 | 7.735      | 250.727           | 5.26         |
| huge.xml                  | 3.100      | 208.522           | 5.22         |
| large.xml                 | 1.230      | 105.246           | 5.25         |
| mid.xml                   | 0.782      | 16.492            | 5.23         |
| small.xml                 | 0.734      | 3.543             | 5.25         |
| tiny.xml                  | 0.704      | 1.821             | 5.30         |
| micro.xml                 | 0.647      | 0.000             | 5.35         |

