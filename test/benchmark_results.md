# Benchmark Results 06/14/2025 21:40:02

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
| 1    | Rust (quick-xml)          | 3.086      | 1,047.509         | 1.91         |
| 2    | C++ (pugixml)             | 4.968      | 650.657           | 7,596.66     |
| 3    | .NET 8 - XmlReader        | 5.469      | 591.077           | 46.05        |
| 4    | C++ (rapidxml)            | 5.598      | 577.452           | 9,491.81     |
| 5    | Julia - XML               | 8.325      | 388.283           | 3,523.30     |
| 6    | java-21 - SAX             | 9.215      | 350.816           | 85.39        |
| 7    | Scala                     | 10.813     | 298.959           | 364.36       |
| 8    | java-21 - StAX            | 10.905     | 296.424           | 119.16       |
| 9    | C++ (libxml2 - SAX)       | 11.179     | 289.169           | 7.00         |
| 10   | PowerShell Core           | 15.130     | 213.662           | 141.28       |
| 11   | C++ (libxml2 XMLReader)   | 22.363     | 144.552           | 6.87         |
| 12   | C++ (xsde)                | 31.290     | 103.312           | 3.58         |
| 13   | C++ (Apache Xerces)       | 34.112     | 94.766            | 15.33        |
| 14   | Saxon HE 12               | 35.617     | 90.760            | 10,815.36    |
| 15   | Go - std                  | 63.465     | 50.935            | 8.44         |
| 16   | Julia - LightXML          | 66.701     | 48.464            | 28,222.04    |
| 17   | Python 3                  | 75.393     | 42.877            | 12,611.29    |
| 18   | Go - xmlquery             | 78.395     | 41.235            | 16,729.11    |
| 19   | Node.js                   | 99.003     | 32.652            | 85.27        |
| 20   | Rust (xml-rs)             | 102.499    | 31.538            | 2.00         |


### giant.xml (1939.36 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 1.911      | 1,014.817         | 2.00         |
| 2    | .NET 8 - XmlReader        | 3.496      | 554.775           | 46.14        |
| 3    | C++ (pugixml)             | 3.760      | 515.759           | 4,558.86     |
| 4    | C++ (rapidxml)            | 4.116      | 471.233           | 5,695.96     |
| 5    | Julia - XML               | 5.216      | 371.777           | 2,212.05     |
| 6    | java-21 - SAX             | 6.727      | 288.316           | 80.06        |
| 7    | java-21 - StAX            | 7.501      | 258.548           | 118.99       |
| 8    | Scala                     | 7.685      | 252.356           | 249.03       |
| 9    | C++ (libxml2 - SAX)       | 8.919      | 217.437           | 6.73         |
| 10   | PowerShell Core           | 10.542     | 183.968           | 141.41       |
| 11   | C++ (libxml2 XMLReader)   | 14.348     | 135.166           | 6.77         |
| 12   | Julia - LightXML          | 18.206     | 106.526           | 17,068.02    |
| 13   | C++ (xsde)                | 19.879     | 97.559            | 3.67         |
| 14   | C++ (Apache Xerces)       | 21.576     | 89.884            | 15.43        |
| 15   | Saxon HE 12               | 23.208     | 83.565            | 6,708.20     |
| 16   | Go - std                  | 39.204     | 49.468            | 8.45         |
| 17   | Python 3                  | 47.089     | 41.185            | 7,571.42     |
| 18   | Go - xmlquery             | 48.531     | 39.961            | 9,976.71     |
| 19   | Node.js                   | 61.038     | 31.773            | 83.16        |
| 20   | Rust (xml-rs)             | 62.261     | 31.149            | 2.02         |


### huge.xml (646.47 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.614      | 1,052.498         | 2.04         |
| 2    | C++ (pugixml)             | 1.228      | 526.278           | 1,522.15     |
| 3    | .NET 8 - XmlReader        | 1.315      | 491.469           | 46.24        |
| 4    | C++ (rapidxml)            | 1.364      | 473.885           | 1,900.98     |
| 5    | Julia - XML               | 2.266      | 285.262           | 919.19       |
| 6    | java-21 - SAX             | 2.409      | 268.328           | 76.14        |
| 7    | java-21 - StAX            | 2.611      | 247.579           | 119.82       |
| 8    | Scala                     | 2.852      | 226.691           | 134.94       |
| 9    | C++ (libxml2 - SAX)       | 2.958      | 218.558           | 6.79         |
| 10   | PowerShell Core           | 4.083      | 158.326           | 141.19       |
| 11   | C++ (libxml2 XMLReader)   | 4.796      | 134.802           | 7.33         |
| 12   | Julia - LightXML          | 6.291      | 102.760           | 5,869.42     |
| 13   | C++ (xsde)                | 6.654      | 97.160            | 3.62         |
| 14   | C++ (Apache Xerces)       | 7.206      | 89.715            | 15.43        |
| 15   | Saxon HE 12               | 7.862      | 82.229            | 3,094.81     |
| 16   | Go - std                  | 13.099     | 49.352            | 8.38         |
| 17   | Python 3                  | 15.531     | 41.625            | 2,532.25     |
| 18   | Go - xmlquery             | 15.987     | 40.437            | 3,412.45     |
| 19   | Node.js                   | 20.038     | 32.262            | 68.97        |
| 20   | Rust (xml-rs)             | 20.860     | 30.991            | 1.95         |


### large.xml (129.47 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.128      | 1,009.930         | 1.88         |
| 2    | C++ (pugixml)             | 0.254      | 509.111           | 307.42       |
| 3    | C++ (rapidxml)            | 0.286      | 452.067           | 383.36       |
| 4    | .NET 8 - XmlReader        | 0.509      | 254.253           | 43.47        |
| 5    | java-21 - SAX             | 0.599      | 216.300           | 75.62        |
| 6    | C++ (libxml2 - SAX)       | 0.599      | 216.285           | 6.88         |
| 7    | java-21 - StAX            | 0.676      | 191.506           | 98.93        |
| 8    | Scala                     | 0.949      | 136.356           | 102.95       |
| 9    | C++ (libxml2 XMLReader)   | 0.965      | 134.107           | 7.34         |
| 10   | Julia - XML               | 1.068      | 121.232           | 402.39       |
| 11   | C++ (xsde)                | 1.338      | 96.743            | 3.69         |
| 12   | C++ (Apache Xerces)       | 1.446      | 89.503            | 15.48        |
| 13   | PowerShell Core           | 1.524      | 84.938            | 141.54       |
| 14   | Julia - LightXML          | 1.625      | 79.648            | 1,390.86     |
| 15   | Saxon HE 12               | 2.603      | 49.732            | 845.49       |
| 16   | Go - std                  | 2.624      | 49.330            | 8.13         |
| 17   | Python 3                  | 2.904      | 44.581            | 517.12       |
| 18   | Go - xmlquery             | 3.240      | 39.955            | 701.94       |
| 19   | Node.js                   | 4.121      | 31.415            | 60.95        |
| 20   | Rust (xml-rs)             | 4.186      | 30.929            | 2.03         |


### mid.xml (12.9 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.017      | 774.243           | 2.09         |
| 2    | C++ (pugixml)             | 0.028      | 456.677           | 33.60        |
| 3    | C++ (rapidxml)            | 0.033      | 387.783           | 41.10        |
| 4    | C++ (libxml2 - SAX)       | 0.061      | 210.151           | 6.88         |
| 5    | C++ (libxml2 XMLReader)   | 0.101      | 128.130           | 7.35         |
| 6    | .NET 8 - XmlReader        | 0.121      | 106.188           | 35.34        |
| 7    | C++ (xsde)                | 0.143      | 90.188            | 3.88         |
| 8    | C++ (Apache Xerces)       | 0.156      | 82.734            | 15.32        |
| 9    | java-21 - SAX             | 0.167      | 77.085            | 67.95        |
| 10   | java-21 - StAX            | 0.179      | 72.054            | 92.16        |
| 11   | Python 3                  | 0.268      | 48.075            | 63.05        |
| 12   | Go - std                  | 0.269      | 47.973            | 8.20         |
| 13   | Go - xmlquery             | 0.341      | 37.807            | 75.82        |
| 14   | Rust (xml-rs)             | 0.420      | 30.679            | 2.01         |
| 15   | Scala                     | 0.456      | 28.302            | 94.64        |
| 16   | PowerShell Core           | 0.473      | 27.270            | 140.52       |
| 17   | Node.js                   | 0.486      | 26.547            | 57.39        |
| 18   | Julia - LightXML          | 0.514      | 25.112            | 358.74       |
| 19   | Julia - XML               | 0.783      | 16.470            | 283.45       |
| 20   | Saxon HE 12               | 1.286      | 10.026            | 237.11       |


### small.xml (2.6 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.006      | 458.712           | 2.09         |
| 2    | C++ (pugixml)             | 0.010      | 270.384           | 9.39         |
| 3    | C++ (rapidxml)            | 0.012      | 225.095           | 10.77        |
| 4    | C++ (libxml2 - SAX)       | 0.016      | 162.200           | 7.00         |
| 5    | C++ (libxml2 XMLReader)   | 0.027      | 96.570            | 6.91         |
| 6    | C++ (xsde)                | 0.033      | 77.935            | 3.66         |
| 7    | C++ (Apache Xerces)       | 0.042      | 62.175            | 15.21        |
| 8    | .NET 8 - XmlReader        | 0.051      | 50.560            | 34.84        |
| 9    | Go - std                  | 0.058      | 45.126            | 8.19         |
| 10   | Go - xmlquery             | 0.075      | 34.550            | 28.35        |
| 11   | Python 3                  | 0.078      | 33.281            | 23.07        |
| 12   | Rust (xml-rs)             | 0.089      | 29.309            | 2.02         |
| 13   | java-21 - SAX             | 0.133      | 19.581            | 66.51        |
| 14   | java-21 - StAX            | 0.144      | 18.082            | 82.48        |
| 15   | Node.js                   | 0.147      | 17.720            | 57.70        |
| 16   | Julia - LightXML          | 0.312      | 8.335             | 263.57       |
| 17   | PowerShell Core           | 0.329      | 7.914             | 140.13       |
| 18   | Scala                     | 0.408      | 6.371             | 92.94        |
| 19   | Julia - XML               | 0.763      | 3.408             | 271.47       |
| 20   | Saxon HE 12               | 0.998      | 2.606             | 169.02       |


### tiny.xml (1.28 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.004      | 317.588           | 2.03         |
| 2    | C++ (rapidxml)            | 0.007      | 186.414           | 7.04         |
| 3    | C++ (pugixml)             | 0.007      | 173.804           | 6.44         |
| 4    | C++ (libxml2 - SAX)       | 0.010      | 130.934           | 6.68         |
| 5    | C++ (libxml2 XMLReader)   | 0.013      | 97.339            | 6.77         |
| 6    | C++ (xsde)                | 0.020      | 64.126            | 3.38         |
| 7    | C++ (Apache Xerces)       | 0.023      | 55.757            | 15.41        |
| 8    | Go - std                  | 0.034      | 37.483            | 7.95         |
| 9    | Go - xmlquery             | 0.042      | 30.548            | 18.09        |
| 10   | Rust (xml-rs)             | 0.046      | 28.110            | 1.96         |
| 11   | Python 3                  | 0.051      | 24.884            | 17.80        |
| 12   | .NET 8 - XmlReader        | 0.065      | 19.569            | 34.79        |
| 13   | Node.js                   | 0.104      | 12.367            | 57.25        |
| 14   | java-21 - SAX             | 0.129      | 9.951             | 61.77        |
| 15   | java-21 - StAX            | 0.132      | 9.740             | 78.10        |
| 16   | PowerShell Core           | 0.308      | 4.164             | 136.64       |
| 17   | Julia - LightXML          | 0.379      | 3.378             | 250.15       |
| 18   | Scala                     | 0.401      | 3.197             | 88.15        |
| 19   | Julia - XML               | 0.764      | 1.678             | 269.87       |
| 20   | Saxon HE 12               | 0.932      | 1.375             | 152.95       |


### micro.xml (0.2 KB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Go - std                  | 0.002      | 0.097             | 3.39         |
| 2    | Rust (xml-rs)             | 0.002      | 0.096             | 1.96         |
| 3    | Rust (quick-xml)          | 0.003      | 0.082             | 2.06         |
| 4    | C++ (rapidxml)            | 0.003      | 0.076             | 3.46         |
| 5    | C++ (xsde)                | 0.003      | 0.072             | 3.66         |
| 6    | C++ (pugixml)             | 0.003      | 0.065             | 3.16         |
| 7    | C++ (libxml2 - SAX)       | 0.003      | 0.063             | 7.27         |
| 8    | Go - xmlquery             | 0.004      | 0.062             | 6.58         |
| 9    | C++ (libxml2 XMLReader)   | 0.004      | 0.059             | 7.18         |
| 10   | C++ (Apache Xerces)       | 0.011      | 0.019             | 15.68        |
| 11   | Python 3                  | 0.030      | 0.007             | 12.80        |
| 12   | Node.js                   | 0.036      | 0.006             | 45.25        |
| 13   | java-21 - StAX            | 0.055      | 0.004             | 60.23        |
| 14   | .NET 8 - XmlReader        | 0.061      | 0.004             | 33.70        |
| 15   | java-21 - SAX             | 0.077      | 0.003             | 46.45        |
| 16   | PowerShell Core           | 0.262      | 0.001             | 130.66       |
| 17   | Scala                     | 0.311      | 0.001             | 74.59        |
| 18   | Julia - LightXML          | 0.324      | 0.001             | 240.79       |
| 19   | Julia - XML               | 0.760      | 0.000             | 270.27       |
| 20   | Saxon HE 12               | 0.856      | 0.000             | 114.50       |


## App - Results


### .NET 8 - XmlReader

xml-i in .NET

```
9.0.105
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 5.469      | 591.077           | 46.05        |
| giant.xml                 | 3.496      | 554.775           | 46.14        |
| huge.xml                  | 1.315      | 491.469           | 46.24        |
| large.xml                 | 0.509      | 254.253           | 43.47        |
| mid.xml                   | 0.121      | 106.188           | 35.34        |
| tiny.xml                  | 0.065      | 19.569            | 34.79        |
| micro.xml                 | 0.061      | 0.004             | 33.70        |
| small.xml                 | 0.051      | 50.560            | 34.84        |

### C++ (Apache Xerces)

xml-i in C++ powered by Apache Xerces


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 34.112     | 94.766            | 15.33        |
| giant.xml                 | 21.576     | 89.884            | 15.43        |
| huge.xml                  | 7.206      | 89.715            | 15.43        |
| large.xml                 | 1.446      | 89.503            | 15.48        |
| mid.xml                   | 0.156      | 82.734            | 15.32        |
| small.xml                 | 0.042      | 62.175            | 15.21        |
| tiny.xml                  | 0.023      | 55.757            | 15.41        |
| micro.xml                 | 0.011      | 0.019             | 15.68        |

### C++ (libxml2 - SAX)

xml-i in C++ powered by libxml2


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 11.179     | 289.169           | 7.00         |
| giant.xml                 | 8.919      | 217.437           | 6.73         |
| huge.xml                  | 2.958      | 218.558           | 6.79         |
| large.xml                 | 0.599      | 216.285           | 6.88         |
| mid.xml                   | 0.061      | 210.151           | 6.88         |
| small.xml                 | 0.016      | 162.200           | 7.00         |
| tiny.xml                  | 0.010      | 130.934           | 6.68         |
| micro.xml                 | 0.003      | 0.063             | 7.27         |

### C++ (libxml2 XMLReader)

xml-i in C++ powered by libxml2 XMLReader


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 22.363     | 144.552           | 6.87         |
| giant.xml                 | 14.348     | 135.166           | 6.77         |
| huge.xml                  | 4.796      | 134.802           | 7.33         |
| large.xml                 | 0.965      | 134.107           | 7.34         |
| mid.xml                   | 0.101      | 128.130           | 7.35         |
| small.xml                 | 0.027      | 96.570            | 6.91         |
| tiny.xml                  | 0.013      | 97.339            | 6.77         |
| micro.xml                 | 0.004      | 0.059             | 7.18         |

### C++ (pugixml)

xml-i in C++ powered by pugixml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 4.968      | 650.657           | 7,596.66     |
| giant.xml                 | 3.760      | 515.759           | 4,558.86     |
| huge.xml                  | 1.228      | 526.278           | 1,522.15     |
| large.xml                 | 0.254      | 509.111           | 307.42       |
| mid.xml                   | 0.028      | 456.677           | 33.60        |
| small.xml                 | 0.010      | 270.384           | 9.39         |
| tiny.xml                  | 0.007      | 173.804           | 6.44         |
| micro.xml                 | 0.003      | 0.065             | 3.16         |

### C++ (rapidxml)

xml-i in C++ powered by rapidxml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 5.598      | 577.452           | 9,491.81     |
| giant.xml                 | 4.116      | 471.233           | 5,695.96     |
| huge.xml                  | 1.364      | 473.885           | 1,900.98     |
| large.xml                 | 0.286      | 452.067           | 383.36       |
| mid.xml                   | 0.033      | 387.783           | 41.10        |
| small.xml                 | 0.012      | 225.095           | 10.77        |
| tiny.xml                  | 0.007      | 186.414           | 7.04         |
| micro.xml                 | 0.003      | 0.076             | 3.46         |

### C++ (xsde)

xml-i in C++ powered by CodeSynthesis xsde


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 31.290     | 103.312           | 3.58         |
| giant.xml                 | 19.879     | 97.559            | 3.67         |
| huge.xml                  | 6.654      | 97.160            | 3.62         |
| large.xml                 | 1.338      | 96.743            | 3.69         |
| mid.xml                   | 0.143      | 90.188            | 3.88         |
| small.xml                 | 0.033      | 77.935            | 3.66         |
| tiny.xml                  | 0.020      | 64.126            | 3.38         |
| micro.xml                 | 0.003      | 0.072             | 3.66         |

### Go - std

xml-i in Go (using standard library encoding/xml)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 63.465     | 50.935            | 8.44         |
| giant.xml                 | 39.204     | 49.468            | 8.45         |
| huge.xml                  | 13.099     | 49.352            | 8.38         |
| large.xml                 | 2.624      | 49.330            | 8.13         |
| mid.xml                   | 0.269      | 47.973            | 8.20         |
| small.xml                 | 0.058      | 45.126            | 8.19         |
| tiny.xml                  | 0.034      | 37.483            | 7.95         |
| micro.xml                 | 0.002      | 0.097             | 3.39         |

### Go - xmlquery

xml-i in Go (using antchfx/xmlquery)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 78.395     | 41.235            | 16,729.11    |
| giant.xml                 | 48.531     | 39.961            | 9,976.71     |
| huge.xml                  | 15.987     | 40.437            | 3,412.45     |
| large.xml                 | 3.240      | 39.955            | 701.94       |
| mid.xml                   | 0.341      | 37.807            | 75.82        |
| small.xml                 | 0.075      | 34.550            | 28.35        |
| tiny.xml                  | 0.042      | 30.548            | 18.09        |
| micro.xml                 | 0.004      | 0.062             | 6.58         |

### java-21 - SAX

xml-i in pure Java (java-21-openjdk), using org.xml.sax

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 9.215      | 350.816           | 85.39        |
| giant.xml                 | 6.727      | 288.316           | 80.06        |
| huge.xml                  | 2.409      | 268.328           | 76.14        |
| large.xml                 | 0.599      | 216.300           | 75.62        |
| mid.xml                   | 0.167      | 77.085            | 67.95        |
| small.xml                 | 0.133      | 19.581            | 66.51        |
| tiny.xml                  | 0.129      | 9.951             | 61.77        |
| micro.xml                 | 0.077      | 0.003             | 46.45        |

### java-21 - StAX

xml-i in pure Java (java-21-openjdk), using javax.xml.stream

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 10.905     | 296.424           | 119.16       |
| giant.xml                 | 7.501      | 258.548           | 118.99       |
| huge.xml                  | 2.611      | 247.579           | 119.82       |
| large.xml                 | 0.676      | 191.506           | 98.93        |
| mid.xml                   | 0.179      | 72.054            | 92.16        |
| small.xml                 | 0.144      | 18.082            | 82.48        |
| tiny.xml                  | 0.132      | 9.740             | 78.10        |
| micro.xml                 | 0.055      | 0.004             | 60.23        |

### Julia - LightXML

xml-i in Julia with LightXML

```
julia version 1.11.5
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 66.701     | 48.464            | 28,222.04    |
| giant.xml                 | 18.206     | 106.526           | 17,068.02    |
| huge.xml                  | 6.291      | 102.760           | 5,869.42     |
| large.xml                 | 1.625      | 79.648            | 1,390.86     |
| mid.xml                   | 0.514      | 25.112            | 358.74       |
| tiny.xml                  | 0.379      | 3.378             | 250.15       |
| micro.xml                 | 0.324      | 0.001             | 240.79       |
| small.xml                 | 0.312      | 8.335             | 263.57       |

### Julia - XML

xml-i in Julia with XML

```
julia version 1.11.5
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 8.325      | 388.283           | 3,523.30     |
| giant.xml                 | 5.216      | 371.777           | 2,212.05     |
| huge.xml                  | 2.266      | 285.262           | 919.19       |
| large.xml                 | 1.068      | 121.232           | 402.39       |
| mid.xml                   | 0.783      | 16.470            | 283.45       |
| tiny.xml                  | 0.764      | 1.678             | 269.87       |
| small.xml                 | 0.763      | 3.408             | 271.47       |
| micro.xml                 | 0.760      | 0.000             | 270.27       |

### Node.js

xml-i in Node.js

```
v22.15.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 99.003     | 32.652            | 85.27        |
| giant.xml                 | 61.038     | 31.773            | 83.16        |
| huge.xml                  | 20.038     | 32.262            | 68.97        |
| large.xml                 | 4.121      | 31.415            | 60.95        |
| mid.xml                   | 0.486      | 26.547            | 57.39        |
| small.xml                 | 0.147      | 17.720            | 57.70        |
| tiny.xml                  | 0.104      | 12.367            | 57.25        |
| micro.xml                 | 0.036      | 0.006             | 45.25        |

### PowerShell Core

xml-i in pwsh

```

Name                           Value
----                           -----
PSVersion                      {[Major, 7], [Minor, 4], [Patch, 7], [PreReleaseLabel, ]…
PSEdition                      Core
BuildVersion                   
CLRVersion                     
OS                             Manjaro Linux
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 15.130     | 213.662           | 141.28       |
| giant.xml                 | 10.542     | 183.968           | 141.41       |
| huge.xml                  | 4.083      | 158.326           | 141.19       |
| large.xml                 | 1.524      | 84.938            | 141.54       |
| mid.xml                   | 0.473      | 27.270            | 140.52       |
| small.xml                 | 0.329      | 7.914             | 140.13       |
| tiny.xml                  | 0.308      | 4.164             | 136.64       |
| micro.xml                 | 0.262      | 0.001             | 130.66       |

### Python 3

xml-i in Python 3

```
Python 3.13.3
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 75.393     | 42.877            | 12,611.29    |
| giant.xml                 | 47.089     | 41.185            | 7,571.42     |
| huge.xml                  | 15.531     | 41.625            | 2,532.25     |
| large.xml                 | 2.904      | 44.581            | 517.12       |
| mid.xml                   | 0.268      | 48.075            | 63.05        |
| small.xml                 | 0.078      | 33.281            | 23.07        |
| tiny.xml                  | 0.051      | 24.884            | 17.80        |
| micro.xml                 | 0.030      | 0.007             | 12.80        |

### Rust (quick-xml)

xml-i in Rust with quick-xml

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 3.086      | 1,047.509         | 1.91         |
| giant.xml                 | 1.911      | 1,014.817         | 2.00         |
| huge.xml                  | 0.614      | 1,052.498         | 2.04         |
| large.xml                 | 0.128      | 1,009.930         | 1.88         |
| mid.xml                   | 0.017      | 774.243           | 2.09         |
| small.xml                 | 0.006      | 458.712           | 2.09         |
| tiny.xml                  | 0.004      | 317.588           | 2.03         |
| micro.xml                 | 0.003      | 0.082             | 2.06         |

### Rust (xml-rs)

xml-i in Rust with xml-rs

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 102.499    | 31.538            | 2.00         |
| giant.xml                 | 62.261     | 31.149            | 2.02         |
| huge.xml                  | 20.860     | 30.991            | 1.95         |
| large.xml                 | 4.186      | 30.929            | 2.03         |
| mid.xml                   | 0.420      | 30.679            | 2.01         |
| small.xml                 | 0.089      | 29.309            | 2.02         |
| tiny.xml                  | 0.046      | 28.110            | 1.96         |
| micro.xml                 | 0.002      | 0.096             | 1.96         |

### Saxon HE 12

xml-i in xslt powered by Saxon HE 12

```
SaxonHE12-7J.zip
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 35.617     | 90.760            | 10,815.36    |
| giant.xml                 | 23.208     | 83.565            | 6,708.20     |
| huge.xml                  | 7.862      | 82.229            | 3,094.81     |
| large.xml                 | 2.603      | 49.732            | 845.49       |
| mid.xml                   | 1.286      | 10.026            | 237.11       |
| small.xml                 | 0.998      | 2.606             | 169.02       |
| tiny.xml                  | 0.932      | 1.375             | 152.95       |
| micro.xml                 | 0.856      | 0.000             | 114.50       |

### Scala

xml-i in Scala

```
Scala code runner version: 1.8.0
Scala version (default): 3.7.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| behemoth.xml              | 10.813     | 298.959           | 364.36       |
| giant.xml                 | 7.685      | 252.356           | 249.03       |
| huge.xml                  | 2.852      | 226.691           | 134.94       |
| large.xml                 | 0.949      | 136.356           | 102.95       |
| mid.xml                   | 0.456      | 28.302            | 94.64        |
| small.xml                 | 0.408      | 6.371             | 92.94        |
| tiny.xml                  | 0.401      | 3.197             | 88.15        |
| micro.xml                 | 0.311      | 0.001             | 74.59        |

