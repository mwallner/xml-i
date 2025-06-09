# Benchmark Results 06/09/2025 21:33:19

## System Information
```
Hostname: tpX13
Kernel: Linux 6.14.6-2-MANJARO x86_64 GNU/Linux
Distro: Manjaro Linux
CPU: 12th Gen Intel(R) Core(TM) i7-1270P
Disk: Multi-Reader -0
Memory: 31Gi
```

## Overall Results


### giant.xml (2,586.31 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 2.549      | 1,014.595         | 1.96         |
| 2    | C++ (pugixml)             | 3.872      | 667.924           | 6,078.44     |
| 3    | C++ (rapidxml)            | 4.443      | 582.078           | 7,594.83     |
| 4    | .NET                      | 5.304      | 487.578           | 45.98        |
| 5    | java-24 - SAX             | 6.709      | 385.508           | 263.45       |
| 6    | java-21 - SAX             | 6.800      | 380.328           | 201.39       |
| 7    | java-11 - SAX             | 7.810      | 331.166           | 277.48       |
| 8    | java-21 - StAX            | 8.229      | 314.279           | 198.80       |
| 9    | java-24 - StAX            | 8.335      | 310.302           | 274.91       |
| 10   | java-11 - StAX            | 8.685      | 297.783           | 298.51       |
| 11   | C++ (libxml2)             | 9.882      | 261.722           | 6.99         |
| 12   | Scala                     | 11.698     | 221.096           | 5.30         |
| 13   | PowerShell Core           | 11.951     | 216.416           | 137.63       |
| 14   | C++ (libxml2 XMLReader)   | 17.410     | 148.550           | 6.99         |
| 15   | C++ (Apache Xerces)       | 31.092     | 83.181            | 15.57        |
| 16   | Saxon HE 12               | 37.809     | 68.404            | 8,429.43     |
| 17   | Go - std                  | 50.334     | 51.383            | 8.36         |
| 18   | Python 3                  | 60.150     | 42.997            | 10,091.75    |
| 19   | Go - xmlquery             | 61.928     | 41.763            | 14,111.95    |
| 20   | Rust (xml-rs)             | 66.104     | 39.125            | 1.96         |
| 21   | Node.js                   | 78.848     | 32.801            | 86.46        |


### huge.xml (646.40 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.627      | 1,031.549         | 1.97         |
| 2    | C++ (pugixml)             | 1.047      | 617.295           | 1,521.77     |
| 3    | .NET                      | 1.344      | 480.911           | 46.00        |
| 4    | C++ (rapidxml)            | 1.369      | 472.098           | 1,900.74     |
| 5    | java-21 - SAX             | 2.408      | 268.484           | 107.56       |
| 6    | java-24 - SAX             | 2.413      | 267.881           | 118.40       |
| 7    | java-24 - StAX            | 2.619      | 246.796           | 138.05       |
| 8    | java-11 - SAX             | 2.654      | 243.567           | 103.24       |
| 9    | java-21 - StAX            | 2.659      | 243.101           | 129.71       |
| 10   | java-11 - StAX            | 2.792      | 231.513           | 125.44       |
| 11   | C++ (libxml2)             | 2.937      | 220.075           | 6.99         |
| 12   | Scala                     | 3.270      | 197.681           | 5.29         |
| 13   | PowerShell Core           | 4.339      | 148.974           | 138.46       |
| 14   | C++ (libxml2 XMLReader)   | 4.809      | 134.422           | 7.07         |
| 15   | C++ (Apache Xerces)       | 8.523      | 75.842            | 15.44        |
| 16   | Saxon HE 12               | 9.282      | 69.644            | 2,660.73     |
| 17   | Go - std                  | 13.067     | 49.469            | 8.36         |
| 18   | Python 3                  | 15.429     | 41.895            | 2,532.43     |
| 19   | Go - xmlquery             | 15.957     | 40.508            | 3,406.91     |
| 20   | Rust (xml-rs)             | 17.791     | 36.333            | 2.01         |
| 21   | Node.js                   | 20.123     | 32.123            | 69.38        |


### large.xml (129.38 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.136      | 952.900           | 1.86         |
| 2    | C++ (pugixml)             | 0.251      | 514.732           | 307.29       |
| 3    | C++ (rapidxml)            | 0.275      | 471.022           | 382.82       |
| 4    | .NET                      | 0.503      | 257.237           | 43.64        |
| 5    | java-21 - SAX             | 0.600      | 215.700           | 80.04        |
| 6    | C++ (libxml2)             | 0.608      | 212.801           | 6.97         |
| 7    | java-24 - SAX             | 0.615      | 210.295           | 85.16        |
| 8    | java-24 - StAX            | 0.675      | 191.746           | 102.04       |
| 9    | java-21 - StAX            | 0.688      | 188.169           | 103.79       |
| 10   | java-11 - SAX             | 0.713      | 181.405           | 76.96        |
| 11   | java-11 - StAX            | 0.768      | 168.522           | 101.68       |
| 12   | C++ (libxml2 XMLReader)   | 0.964      | 134.153           | 7.09         |
| 13   | Scala                     | 1.282      | 100.932           | 5.29         |
| 14   | PowerShell Core           | 1.538      | 84.097            | 138.88       |
| 15   | C++ (Apache Xerces)       | 1.709      | 75.694            | 15.47        |
| 16   | Saxon HE 12               | 2.543      | 50.879            | 914.61       |
| 17   | Go - std                  | 2.634      | 49.114            | 8.33         |
| 18   | Python 3                  | 2.884      | 44.864            | 516.71       |
| 19   | Go - xmlquery             | 3.234      | 40.005            | 718.23       |
| 20   | Rust (xml-rs)             | 3.504      | 36.923            | 2.03         |
| 21   | Node.js                   | 4.190      | 30.882            | 61.19        |


### mid.xml (12.95 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.018      | 708.018           | 1.96         |
| 2    | C++ (pugixml)             | 0.030      | 428.941           | 33.89        |
| 3    | C++ (rapidxml)            | 0.034      | 382.579           | 41.32        |
| 4    | C++ (libxml2)             | 0.065      | 197.883           | 7.04         |
| 5    | C++ (libxml2 XMLReader)   | 0.102      | 127.397           | 6.91         |
| 6    | .NET                      | 0.118      | 109.899           | 35.09        |
| 7    | java-21 - SAX             | 0.184      | 70.427            | 70.30        |
| 8    | C++ (Apache Xerces)       | 0.185      | 69.874            | 15.35        |
| 9    | java-24 - StAX            | 0.195      | 66.386            | 89.21        |
| 10   | java-24 - SAX             | 0.196      | 66.159            | 71.62        |
| 11   | java-21 - StAX            | 0.206      | 62.830            | 92.34        |
| 12   | java-11 - SAX             | 0.241      | 53.677            | 71.75        |
| 13   | Python 3                  | 0.268      | 48.360            | 63.29        |
| 14   | Go - std                  | 0.276      | 47.011            | 8.05         |
| 15   | java-11 - StAX            | 0.277      | 46.835            | 89.77        |
| 16   | Go - xmlquery             | 0.340      | 38.120            | 85.79        |
| 17   | Rust (xml-rs)             | 0.356      | 36.414            | 2.04         |
| 18   | PowerShell Core           | 0.464      | 27.909            | 137.09       |
| 19   | Node.js                   | 0.480      | 26.983            | 57.80        |
| 20   | Scala                     | 0.792      | 16.364            | 5.17         |
| 21   | Saxon HE 12               | 1.313      | 9.867             | 269.04       |


### small.xml (1.27 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.004      | 302.658           | 2.16         |
| 2    | C++ (rapidxml)            | 0.006      | 221.174           | 6.87         |
| 3    | C++ (pugixml)             | 0.007      | 186.478           | 6.52         |
| 4    | C++ (libxml2)             | 0.012      | 108.304           | 6.71         |
| 5    | C++ (libxml2 XMLReader)   | 0.014      | 88.539            | 6.96         |
| 6    | C++ (Apache Xerces)       | 0.028      | 45.690            | 15.70        |
| 7    | Go - std                  | 0.030      | 42.778            | 7.75         |
| 8    | Go - xmlquery             | 0.042      | 30.497            | 17.79        |
| 9    | Rust (xml-rs)             | 0.042      | 29.915            | 1.98         |
| 10   | Python 3                  | 0.052      | 24.584            | 17.71        |
| 11   | .NET                      | 0.056      | 22.813            | 34.59        |
| 12   | Node.js                   | 0.105      | 12.084            | 57.66        |
| 13   | java-21 - SAX             | 0.119      | 10.618            | 64.71        |
| 14   | java-21 - StAX            | 0.122      | 10.394            | 79.55        |
| 15   | java-24 - SAX             | 0.131      | 9.716             | 65.57        |
| 16   | java-24 - StAX            | 0.131      | 9.658             | 75.16        |
| 17   | java-11 - SAX             | 0.181      | 7.004             | 58.57        |
| 18   | java-11 - StAX            | 0.208      | 6.102             | 76.10        |
| 19   | PowerShell Core           | 0.294      | 4.310             | 133.58       |
| 20   | Scala                     | 0.757      | 1.676             | 5.27         |
| 21   | Saxon HE 12               | 0.909      | 1.395             | 170.06       |


### tiny.xml (0.00 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.002      | 0.245             | 1.82         |
| 2    | Go - std                  | 0.002      | 0.184             | 3.52         |
| 3    | Rust (xml-rs)             | 0.002      | 0.172             | 1.99         |
| 4    | C++ (rapidxml)            | 0.003      | 0.150             | 3.29         |
| 5    | Go - xmlquery             | 0.004      | 0.117             | 6.95         |
| 6    | C++ (libxml2)             | 0.004      | 0.117             | 6.84         |
| 7    | C++ (libxml2 XMLReader)   | 0.004      | 0.117             | 6.87         |
| 8    | C++ (pugixml)             | 0.004      | 0.103             | 3.60         |
| 9    | C++ (Apache Xerces)       | 0.012      | 0.037             | 15.21        |
| 10   | Python 3                  | 0.030      | 0.014             | 12.78        |
| 11   | Node.js                   | 0.039      | 0.011             | 45.12        |
| 12   | .NET                      | 0.057      | 0.007             | 33.59        |
| 13   | java-21 - StAX            | 0.077      | 0.006             | 60.40        |
| 14   | java-21 - SAX             | 0.080      | 0.005             | 48.96        |
| 15   | java-24 - SAX             | 0.092      | 0.005             | 52.25        |
| 16   | java-24 - StAX            | 0.095      | 0.004             | 65.80        |
| 17   | java-11 - StAX            | 0.143      | 0.003             | 55.93        |
| 18   | java-11 - SAX             | 0.144      | 0.003             | 45.85        |
| 19   | PowerShell Core           | 0.271      | 0.002             | 126.93       |
| 20   | Scala                     | 0.679      | 0.001             | 5.42         |
| 21   | Saxon HE 12               | 0.832      | 0.001             | 141.71       |


## App - Results


### .NET

xml-i in .NET

```
9.0.105
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 5.304      | 487.578           | 45.98        |
| huge.xml                  | 1.344      | 480.911           | 46.00        |
| large.xml                 | 0.503      | 257.237           | 43.64        |
| mid.xml                   | 0.118      | 109.899           | 35.09        |
| tiny.xml                  | 0.057      | 0.007             | 33.59        |
| small.xml                 | 0.056      | 22.813            | 34.59        |

### C++ (Apache Xerces)

xml-i in C++ powered by Apache Xerces


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 31.092     | 83.181            | 15.57        |
| huge.xml                  | 8.523      | 75.842            | 15.44        |
| large.xml                 | 1.709      | 75.694            | 15.47        |
| mid.xml                   | 0.185      | 69.874            | 15.35        |
| small.xml                 | 0.028      | 45.690            | 15.70        |
| tiny.xml                  | 0.012      | 0.037             | 15.21        |

### C++ (libxml2 XMLReader)

xml-i in C++ powered by libxml2 XMLReader


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 17.410     | 148.550           | 6.99         |
| huge.xml                  | 4.809      | 134.422           | 7.07         |
| large.xml                 | 0.964      | 134.153           | 7.09         |
| mid.xml                   | 0.102      | 127.397           | 6.91         |
| small.xml                 | 0.014      | 88.539            | 6.96         |
| tiny.xml                  | 0.004      | 0.117             | 6.87         |

### C++ (libxml2)

xml-i in C++ powered by libxml2


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 9.882      | 261.722           | 6.99         |
| huge.xml                  | 2.937      | 220.075           | 6.99         |
| large.xml                 | 0.608      | 212.801           | 6.97         |
| mid.xml                   | 0.065      | 197.883           | 7.04         |
| small.xml                 | 0.012      | 108.304           | 6.71         |
| tiny.xml                  | 0.004      | 0.117             | 6.84         |

### C++ (pugixml)

xml-i in C++ powered by pugixml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 3.872      | 667.924           | 6,078.44     |
| huge.xml                  | 1.047      | 617.295           | 1,521.77     |
| large.xml                 | 0.251      | 514.732           | 307.29       |
| mid.xml                   | 0.030      | 428.941           | 33.89        |
| small.xml                 | 0.007      | 186.478           | 6.52         |
| tiny.xml                  | 0.004      | 0.103             | 3.60         |

### C++ (rapidxml)

xml-i in C++ powered by rapidxml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 4.443      | 582.078           | 7,594.83     |
| huge.xml                  | 1.369      | 472.098           | 1,900.74     |
| large.xml                 | 0.275      | 471.022           | 382.82       |
| mid.xml                   | 0.034      | 382.579           | 41.32        |
| small.xml                 | 0.006      | 221.174           | 6.87         |
| tiny.xml                  | 0.003      | 0.150             | 3.29         |

### Go - std

xml-i in Go (using standard library encoding/xml)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 50.334     | 51.383            | 8.36         |
| huge.xml                  | 13.067     | 49.469            | 8.36         |
| large.xml                 | 2.634      | 49.114            | 8.33         |
| mid.xml                   | 0.276      | 47.011            | 8.05         |
| small.xml                 | 0.030      | 42.778            | 7.75         |
| tiny.xml                  | 0.002      | 0.184             | 3.52         |

### Go - xmlquery

xml-i in Go (using antchfx/xmlquery)

```
go version go1.24.3 linux/amd64
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 61.928     | 41.763            | 14,111.95    |
| huge.xml                  | 15.957     | 40.508            | 3,406.91     |
| large.xml                 | 3.234      | 40.005            | 718.23       |
| mid.xml                   | 0.340      | 38.120            | 85.79        |
| small.xml                 | 0.042      | 30.497            | 17.79        |
| tiny.xml                  | 0.004      | 0.117             | 6.95         |

### java-11 - SAX

xml-i in pure Java (java-11-openjdk), using org.xml.sax

```
openjdk 11.0.27 2025-04-15
OpenJDK Runtime Environment (build 11.0.27+6)
OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 7.810      | 331.166           | 277.48       |
| huge.xml                  | 2.654      | 243.567           | 103.24       |
| large.xml                 | 0.713      | 181.405           | 76.96        |
| mid.xml                   | 0.241      | 53.677            | 71.75        |
| small.xml                 | 0.181      | 7.004             | 58.57        |
| tiny.xml                  | 0.144      | 0.003             | 45.85        |

### java-11 - StAX

xml-i in pure Java (java-11-openjdk), using javax.xml.stream

```
openjdk 11.0.27 2025-04-15
OpenJDK Runtime Environment (build 11.0.27+6)
OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 8.685      | 297.783           | 298.51       |
| huge.xml                  | 2.792      | 231.513           | 125.44       |
| large.xml                 | 0.768      | 168.522           | 101.68       |
| mid.xml                   | 0.277      | 46.835            | 89.77        |
| small.xml                 | 0.208      | 6.102             | 76.10        |
| tiny.xml                  | 0.143      | 0.003             | 55.93        |

### java-21 - SAX

xml-i in pure Java (java-21-openjdk), using org.xml.sax

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 6.800      | 380.328           | 201.39       |
| huge.xml                  | 2.408      | 268.484           | 107.56       |
| large.xml                 | 0.600      | 215.700           | 80.04        |
| mid.xml                   | 0.184      | 70.427            | 70.30        |
| small.xml                 | 0.119      | 10.618            | 64.71        |
| tiny.xml                  | 0.080      | 0.005             | 48.96        |

### java-21 - StAX

xml-i in pure Java (java-21-openjdk), using javax.xml.stream

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 8.229      | 314.279           | 198.80       |
| huge.xml                  | 2.659      | 243.101           | 129.71       |
| large.xml                 | 0.688      | 188.169           | 103.79       |
| mid.xml                   | 0.206      | 62.830            | 92.34        |
| small.xml                 | 0.122      | 10.394            | 79.55        |
| tiny.xml                  | 0.077      | 0.006             | 60.40        |

### java-24 - SAX

xml-i in pure Java (java-24-openjdk), using org.xml.sax

```
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1)
OpenJDK 64-Bit Server VM (build 24.0.1, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 6.709      | 385.508           | 263.45       |
| huge.xml                  | 2.413      | 267.881           | 118.40       |
| large.xml                 | 0.615      | 210.295           | 85.16        |
| mid.xml                   | 0.196      | 66.159            | 71.62        |
| small.xml                 | 0.131      | 9.716             | 65.57        |
| tiny.xml                  | 0.092      | 0.005             | 52.25        |

### java-24 - StAX

xml-i in pure Java (java-24-openjdk), using javax.xml.stream

```
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1)
OpenJDK 64-Bit Server VM (build 24.0.1, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 8.335      | 310.302           | 274.91       |
| huge.xml                  | 2.619      | 246.796           | 138.05       |
| large.xml                 | 0.675      | 191.746           | 102.04       |
| mid.xml                   | 0.195      | 66.386            | 89.21        |
| small.xml                 | 0.131      | 9.658             | 75.16        |
| tiny.xml                  | 0.095      | 0.004             | 65.80        |

### Node.js

xml-i in Node.js

```
v22.15.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 78.848     | 32.801            | 86.46        |
| huge.xml                  | 20.123     | 32.123            | 69.38        |
| large.xml                 | 4.190      | 30.882            | 61.19        |
| mid.xml                   | 0.480      | 26.983            | 57.80        |
| small.xml                 | 0.105      | 12.084            | 57.66        |
| tiny.xml                  | 0.039      | 0.011             | 45.12        |

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
| giant.xml                 | 11.951     | 216.416           | 137.63       |
| huge.xml                  | 4.339      | 148.974           | 138.46       |
| large.xml                 | 1.538      | 84.097            | 138.88       |
| mid.xml                   | 0.464      | 27.909            | 137.09       |
| small.xml                 | 0.294      | 4.310             | 133.58       |
| tiny.xml                  | 0.271      | 0.002             | 126.93       |

### Python 3

xml-i in Python 3

```
Python 3.13.3
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 60.150     | 42.997            | 10,091.75    |
| huge.xml                  | 15.429     | 41.895            | 2,532.43     |
| large.xml                 | 2.884      | 44.864            | 516.71       |
| mid.xml                   | 0.268      | 48.360            | 63.29        |
| small.xml                 | 0.052      | 24.584            | 17.71        |
| tiny.xml                  | 0.030      | 0.014             | 12.78        |

### Rust (quick-xml)

xml-i in Rust with quick-xml

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 2.549      | 1,014.595         | 1.96         |
| huge.xml                  | 0.627      | 1,031.549         | 1.97         |
| large.xml                 | 0.136      | 952.900           | 1.86         |
| mid.xml                   | 0.018      | 708.018           | 1.96         |
| small.xml                 | 0.004      | 302.658           | 2.16         |
| tiny.xml                  | 0.002      | 0.245             | 1.82         |

### Rust (xml-rs)

xml-i in Rust with xml-rs

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 66.104     | 39.125            | 1.96         |
| huge.xml                  | 17.791     | 36.333            | 2.01         |
| large.xml                 | 3.504      | 36.923            | 2.03         |
| mid.xml                   | 0.356      | 36.414            | 2.04         |
| small.xml                 | 0.042      | 29.915            | 1.98         |
| tiny.xml                  | 0.002      | 0.172             | 1.99         |

### Saxon HE 12

xml-i in xslt powered by Saxon HE 12

```
SaxonHE12-7J.zip
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 37.809     | 68.404            | 8,429.43     |
| huge.xml                  | 9.282      | 69.644            | 2,660.73     |
| large.xml                 | 2.543      | 50.879            | 914.61       |
| mid.xml                   | 1.313      | 9.867             | 269.04       |
| small.xml                 | 0.909      | 1.395             | 170.06       |
| tiny.xml                  | 0.832      | 0.001             | 141.71       |

### Scala

xml-i in Scala

```
Scala code runner version: 1.8.0
Scala version (default): 3.7.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 11.698     | 221.096           | 5.30         |
| huge.xml                  | 3.270      | 197.681           | 5.29         |
| large.xml                 | 1.282      | 100.932           | 5.29         |
| mid.xml                   | 0.792      | 16.364            | 5.17         |
| small.xml                 | 0.757      | 1.676             | 5.27         |
| tiny.xml                  | 0.679      | 0.001             | 5.42         |
