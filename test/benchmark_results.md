# Benchmark Results 06/08/2025 21:46:59

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
| 1    | Rust (quick-xml)          | 2.702      | 957.015           | 1.78         |
| 2    | C++ (pugixml)             | 3.909      | 661.650           | 6,078.41     |
| 3    | C++ (rapidxml)            | 4.353      | 594.201           | 7,594.78     |
| 4    | .NET                      | 4.390      | 589.132           | 46.18        |
| 5    | java-24 - SAX             | 7.083      | 365.159           | 255.26       |
| 6    | java-21 - SAX             | 7.124      | 363.049           | 196.69       |
| 7    | java-11 - SAX             | 7.166      | 360.937           | 277.48       |
| 8    | java-21 - StAX            | 8.107      | 319.019           | 207.66       |
| 9    | java-24 - StAX            | 8.203      | 315.292           | 275.68       |
| 10   | java-11 - StAX            | 8.650      | 298.999           | 303.21       |
| 11   | C++ (libxml2)             | 10.045     | 257.475           | 7.08         |
| 12   | Scala                     | 10.748     | 240.627           | 5.37         |
| 13   | PowerShell Core           | 12.652     | 204.413           | 150.25       |
| 14   | C++ (libxml2 XMLReader)   | 17.498     | 147.808           | 7.31         |
| 15   | C++ (Apache Xerces)       | 32.346     | 79.956            | 15.45        |
| 16   | Saxon HE 12               | 37.677     | 68.644            | 8,430.75     |
| 17   | Python 3                  | 60.576     | 42.695            | 10,091.93    |
| 18   | Node.js                   | 78.539     | 32.930            | 86.93        |
| 19   | Rust (xml-rs)             | 80.351     | 32.188            | 2.16         |


### huge.xml (646.40 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.641      | 1,008.756         | 1.87         |
| 2    | C++ (pugixml)             | 1.149      | 562.525           | 1,522.07     |
| 3    | C++ (rapidxml)            | 1.316      | 491.008           | 1,900.85     |
| 4    | .NET                      | 1.776      | 363.927           | 46.12        |
| 5    | java-21 - SAX             | 2.407      | 268.547           | 107.82       |
| 6    | java-24 - SAX             | 2.419      | 267.200           | 116.52       |
| 7    | java-11 - SAX             | 2.522      | 256.295           | 111.27       |
| 8    | java-24 - StAX            | 2.628      | 245.948           | 133.94       |
| 9    | java-21 - StAX            | 2.705      | 238.953           | 129.29       |
| 10   | java-11 - StAX            | 2.861      | 225.920           | 126.23       |
| 11   | C++ (libxml2)             | 2.955      | 218.720           | 7.00         |
| 12   | Scala                     | 3.222      | 200.635           | 5.35         |
| 13   | PowerShell Core           | 4.124      | 156.752           | 152.94       |
| 14   | C++ (libxml2 XMLReader)   | 4.796      | 134.786           | 7.17         |
| 15   | C++ (Apache Xerces)       | 8.536      | 75.729            | 15.37        |
| 16   | Saxon HE 12               | 8.836      | 73.157            | 2,661.07     |
| 17   | Python 3                  | 15.562     | 41.537            | 2,532.23     |
| 18   | Node.js                   | 20.459     | 31.595            | 69.15        |
| 19   | Rust (xml-rs)             | 21.120     | 30.607            | 2.03         |


### large.xml (129.38 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.136      | 954.130           | 2.02         |
| 2    | C++ (pugixml)             | 0.253      | 510.989           | 307.32       |
| 3    | C++ (rapidxml)            | 0.287      | 451.572           | 382.97       |
| 4    | java-21 - SAX             | 0.604      | 214.175           | 80.01        |
| 5    | C++ (libxml2)             | 0.605      | 213.761           | 6.77         |
| 6    | .NET                      | 0.617      | 209.666           | 43.61        |
| 7    | java-24 - SAX             | 0.620      | 208.570           | 85.70        |
| 8    | java-21 - StAX            | 0.675      | 191.730           | 104.62       |
| 9    | java-24 - StAX            | 0.685      | 188.841           | 100.22       |
| 10   | java-11 - SAX             | 0.704      | 183.726           | 76.19        |
| 11   | java-11 - StAX            | 0.778      | 166.306           | 100.98       |
| 12   | C++ (libxml2 XMLReader)   | 0.969      | 133.582           | 7.31         |
| 13   | Scala                     | 1.281      | 100.968           | 5.29         |
| 14   | PowerShell Core           | 1.606      | 80.571            | 150.65       |
| 15   | C++ (Apache Xerces)       | 1.715      | 75.420            | 15.41        |
| 16   | Saxon HE 12               | 2.553      | 50.687            | 920.08       |
| 17   | Python 3                  | 2.906      | 44.521            | 516.59       |
| 18   | Rust (xml-rs)             | 4.159      | 31.107            | 2.06         |
| 19   | Node.js                   | 4.161      | 31.094            | 61.17        |


### mid.xml (12.95 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.017      | 755.614           | 1.98         |
| 2    | C++ (pugixml)             | 0.030      | 425.206           | 33.90        |
| 3    | C++ (rapidxml)            | 0.033      | 391.171           | 41.23        |
| 4    | C++ (libxml2)             | 0.065      | 200.695           | 7.08         |
| 5    | C++ (libxml2 XMLReader)   | 0.101      | 127.645           | 7.16         |
| 6    | .NET                      | 0.175      | 73.908            | 35.32        |
| 7    | C++ (Apache Xerces)       | 0.183      | 70.810            | 14.61        |
| 8    | java-21 - SAX             | 0.183      | 70.714            | 74.52        |
| 9    | java-21 - StAX            | 0.189      | 68.703            | 90.72        |
| 10   | java-24 - StAX            | 0.194      | 66.782            | 89.86        |
| 11   | java-24 - SAX             | 0.194      | 66.599            | 73.94        |
| 12   | java-11 - SAX             | 0.247      | 52.486            | 68.93        |
| 13   | java-11 - StAX            | 0.255      | 50.782            | 89.33        |
| 14   | Python 3                  | 0.269      | 48.221            | 63.22        |
| 15   | Rust (xml-rs)             | 0.425      | 30.474            | 2.05         |
| 16   | PowerShell Core           | 0.468      | 27.651            | 149.54       |
| 17   | Node.js                   | 0.488      | 26.562            | 57.71        |
| 18   | Scala                     | 0.793      | 16.333            | 5.20         |
| 19   | Saxon HE 12               | 1.228      | 10.549            | 273.39       |


### small.xml (1.27 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.004      | 292.472           | 2.04         |
| 2    | C++ (rapidxml)            | 0.006      | 218.828           | 6.97         |
| 3    | C++ (pugixml)             | 0.006      | 205.094           | 6.21         |
| 4    | C++ (libxml2)             | 0.013      | 94.933            | 7.12         |
| 5    | C++ (libxml2 XMLReader)   | 0.015      | 85.796            | 6.63         |
| 6    | C++ (Apache Xerces)       | 0.027      | 46.453            | 15.45        |
| 7    | Rust (xml-rs)             | 0.046      | 27.678            | 2.12         |
| 8    | Python 3                  | 0.055      | 23.108            | 17.71        |
| 9    | .NET                      | 0.066      | 19.267            | 34.78        |
| 10   | Node.js                   | 0.110      | 11.507            | 57.47        |
| 11   | java-21 - SAX             | 0.129      | 9.858             | 63.75        |
| 12   | java-21 - StAX            | 0.130      | 9.783             | 78.08        |
| 13   | java-24 - StAX            | 0.139      | 9.151             | 76.02        |
| 14   | java-24 - SAX             | 0.145      | 8.748             | 62.46        |
| 15   | java-11 - SAX             | 0.181      | 7.020             | 62.34        |
| 16   | java-11 - StAX            | 0.187      | 6.790             | 74.17        |
| 17   | PowerShell Core           | 0.310      | 4.092             | 146.38       |
| 18   | Scala                     | 0.761      | 1.667             | 5.32         |
| 19   | Saxon HE 12               | 1.000      | 1.269             | 182.77       |


### tiny.xml (0.00 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.002      | 0.216             | 1.97         |
| 2    | Rust (xml-rs)             | 0.002      | 0.186             | 2.10         |
| 3    | C++ (pugixml)             | 0.003      | 0.136             | 3.78         |
| 4    | C++ (rapidxml)            | 0.003      | 0.135             | 3.61         |
| 5    | C++ (libxml2)             | 0.004      | 0.115             | 7.36         |
| 6    | C++ (libxml2 XMLReader)   | 0.004      | 0.109             | 7.12         |
| 7    | C++ (Apache Xerces)       | 0.010      | 0.042             | 15.54        |
| 8    | Python 3                  | 0.029      | 0.015             | 12.62        |
| 9    | Node.js                   | 0.037      | 0.012             | 45.13        |
| 10   | .NET                      | 0.054      | 0.008             | 33.71        |
| 11   | java-21 - SAX             | 0.079      | 0.005             | 49.78        |
| 12   | java-21 - StAX            | 0.082      | 0.005             | 61.12        |
| 13   | java-24 - SAX             | 0.089      | 0.005             | 54.62        |
| 14   | java-24 - StAX            | 0.096      | 0.004             | 64.59        |
| 15   | java-11 - SAX             | 0.128      | 0.003             | 45.48        |
| 16   | java-11 - StAX            | 0.133      | 0.003             | 57.09        |
| 17   | PowerShell Core           | 0.280      | 0.002             | 139.54       |
| 18   | Scala                     | 0.686      | 0.001             | 5.29         |
| 19   | Saxon HE 12               | 0.834      | 0.001             | 138.65       |


## App - Results


### .NET

xml-i in .NET

```
9.0.105
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 4.390      | 589.132           | 46.18        |
| huge.xml                  | 1.776      | 363.927           | 46.12        |
| large.xml                 | 0.617      | 209.666           | 43.61        |
| mid.xml                   | 0.175      | 73.908            | 35.32        |
| small.xml                 | 0.066      | 19.267            | 34.78        |
| tiny.xml                  | 0.054      | 0.008             | 33.71        |

### C++ (Apache Xerces)

xml-i in C++ powered by Apache Xerces


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 32.346     | 79.956            | 15.45        |
| huge.xml                  | 8.536      | 75.729            | 15.37        |
| large.xml                 | 1.715      | 75.420            | 15.41        |
| mid.xml                   | 0.183      | 70.810            | 14.61        |
| small.xml                 | 0.027      | 46.453            | 15.45        |
| tiny.xml                  | 0.010      | 0.042             | 15.54        |

### C++ (libxml2 XMLReader)

xml-i in C++ powered by libxml2 XMLReader


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 17.498     | 147.808           | 7.31         |
| huge.xml                  | 4.796      | 134.786           | 7.17         |
| large.xml                 | 0.969      | 133.582           | 7.31         |
| mid.xml                   | 0.101      | 127.645           | 7.16         |
| small.xml                 | 0.015      | 85.796            | 6.63         |
| tiny.xml                  | 0.004      | 0.109             | 7.12         |

### C++ (libxml2)

xml-i in C++ powered by libxml2


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 10.045     | 257.475           | 7.08         |
| huge.xml                  | 2.955      | 218.720           | 7.00         |
| large.xml                 | 0.605      | 213.761           | 6.77         |
| mid.xml                   | 0.065      | 200.695           | 7.08         |
| small.xml                 | 0.013      | 94.933            | 7.12         |
| tiny.xml                  | 0.004      | 0.115             | 7.36         |

### C++ (pugixml)

xml-i in C++ powered by pugixml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 3.909      | 661.650           | 6,078.41     |
| huge.xml                  | 1.149      | 562.525           | 1,522.07     |
| large.xml                 | 0.253      | 510.989           | 307.32       |
| mid.xml                   | 0.030      | 425.206           | 33.90        |
| small.xml                 | 0.006      | 205.094           | 6.21         |
| tiny.xml                  | 0.003      | 0.136             | 3.78         |

### C++ (rapidxml)

xml-i in C++ powered by rapidxml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 4.353      | 594.201           | 7,594.78     |
| huge.xml                  | 1.316      | 491.008           | 1,900.85     |
| large.xml                 | 0.287      | 451.572           | 382.97       |
| mid.xml                   | 0.033      | 391.171           | 41.23        |
| small.xml                 | 0.006      | 218.828           | 6.97         |
| tiny.xml                  | 0.003      | 0.135             | 3.61         |

### java-11 - SAX

xml-i in pure Java (java-11-openjdk), using org.xml.sax

```
openjdk 11.0.27 2025-04-15
OpenJDK Runtime Environment (build 11.0.27+6)
OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 7.166      | 360.937           | 277.48       |
| huge.xml                  | 2.522      | 256.295           | 111.27       |
| large.xml                 | 0.704      | 183.726           | 76.19        |
| mid.xml                   | 0.247      | 52.486            | 68.93        |
| small.xml                 | 0.181      | 7.020             | 62.34        |
| tiny.xml                  | 0.128      | 0.003             | 45.48        |

### java-11 - StAX

xml-i in pure Java (java-11-openjdk), using javax.xml.stream

```
openjdk 11.0.27 2025-04-15
OpenJDK Runtime Environment (build 11.0.27+6)
OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 8.650      | 298.999           | 303.21       |
| huge.xml                  | 2.861      | 225.920           | 126.23       |
| large.xml                 | 0.778      | 166.306           | 100.98       |
| mid.xml                   | 0.255      | 50.782            | 89.33        |
| small.xml                 | 0.187      | 6.790             | 74.17        |
| tiny.xml                  | 0.133      | 0.003             | 57.09        |

### java-21 - SAX

xml-i in pure Java (java-21-openjdk), using org.xml.sax

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 7.124      | 363.049           | 196.69       |
| huge.xml                  | 2.407      | 268.547           | 107.82       |
| large.xml                 | 0.604      | 214.175           | 80.01        |
| mid.xml                   | 0.183      | 70.714            | 74.52        |
| small.xml                 | 0.129      | 9.858             | 63.75        |
| tiny.xml                  | 0.079      | 0.005             | 49.78        |

### java-21 - StAX

xml-i in pure Java (java-21-openjdk), using javax.xml.stream

```
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6)
OpenJDK 64-Bit Server VM (build 21.0.7+6, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 8.107      | 319.019           | 207.66       |
| huge.xml                  | 2.705      | 238.953           | 129.29       |
| large.xml                 | 0.675      | 191.730           | 104.62       |
| mid.xml                   | 0.189      | 68.703            | 90.72        |
| small.xml                 | 0.130      | 9.783             | 78.08        |
| tiny.xml                  | 0.082      | 0.005             | 61.12        |

### java-24 - SAX

xml-i in pure Java (java-24-openjdk), using org.xml.sax

```
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1)
OpenJDK 64-Bit Server VM (build 24.0.1, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 7.083      | 365.159           | 255.26       |
| huge.xml                  | 2.419      | 267.200           | 116.52       |
| large.xml                 | 0.620      | 208.570           | 85.70        |
| mid.xml                   | 0.194      | 66.599            | 73.94        |
| small.xml                 | 0.145      | 8.748             | 62.46        |
| tiny.xml                  | 0.089      | 0.005             | 54.62        |

### java-24 - StAX

xml-i in pure Java (java-24-openjdk), using javax.xml.stream

```
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1)
OpenJDK 64-Bit Server VM (build 24.0.1, mixed mode, sharing)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 8.203      | 315.292           | 275.68       |
| huge.xml                  | 2.628      | 245.948           | 133.94       |
| large.xml                 | 0.685      | 188.841           | 100.22       |
| mid.xml                   | 0.194      | 66.782            | 89.86        |
| small.xml                 | 0.139      | 9.151             | 76.02        |
| tiny.xml                  | 0.096      | 0.004             | 64.59        |

### Node.js

xml-i in Node.js

```
v22.15.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 78.539     | 32.930            | 86.93        |
| huge.xml                  | 20.459     | 31.595            | 69.15        |
| large.xml                 | 4.161      | 31.094            | 61.17        |
| mid.xml                   | 0.488      | 26.562            | 57.71        |
| small.xml                 | 0.110      | 11.507            | 57.47        |
| tiny.xml                  | 0.037      | 0.012             | 45.13        |

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
| giant.xml                 | 12.652     | 204.413           | 150.25       |
| huge.xml                  | 4.124      | 156.752           | 152.94       |
| large.xml                 | 1.606      | 80.571            | 150.65       |
| mid.xml                   | 0.468      | 27.651            | 149.54       |
| small.xml                 | 0.310      | 4.092             | 146.38       |
| tiny.xml                  | 0.280      | 0.002             | 139.54       |

### Python 3

xml-i in Python 3

```
Python 3.13.3
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 60.576     | 42.695            | 10,091.93    |
| huge.xml                  | 15.562     | 41.537            | 2,532.23     |
| large.xml                 | 2.906      | 44.521            | 516.59       |
| mid.xml                   | 0.269      | 48.221            | 63.22        |
| small.xml                 | 0.055      | 23.108            | 17.71        |
| tiny.xml                  | 0.029      | 0.015             | 12.62        |

### Rust (quick-xml)

xml-i in Rust with quick-xml

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 2.702      | 957.015           | 1.78         |
| huge.xml                  | 0.641      | 1,008.756         | 1.87         |
| large.xml                 | 0.136      | 954.130           | 2.02         |
| mid.xml                   | 0.017      | 755.614           | 1.98         |
| small.xml                 | 0.004      | 292.472           | 2.04         |
| tiny.xml                  | 0.002      | 0.216             | 1.97         |

### Rust (xml-rs)

xml-i in Rust with xml-rs

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 80.351     | 32.188            | 2.16         |
| huge.xml                  | 21.120     | 30.607            | 2.03         |
| large.xml                 | 4.159      | 31.107            | 2.06         |
| mid.xml                   | 0.425      | 30.474            | 2.05         |
| small.xml                 | 0.046      | 27.678            | 2.12         |
| tiny.xml                  | 0.002      | 0.186             | 2.10         |

### Saxon HE 12

xml-i in xslt powered by Saxon HE 12

```
SaxonHE12-7J.zip
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 37.677     | 68.644            | 8,430.75     |
| huge.xml                  | 8.836      | 73.157            | 2,661.07     |
| large.xml                 | 2.553      | 50.687            | 920.08       |
| mid.xml                   | 1.228      | 10.549            | 273.39       |
| small.xml                 | 1.000      | 1.269             | 182.77       |
| tiny.xml                  | 0.834      | 0.001             | 138.65       |

### Scala

xml-i in Scala

```
Scala code runner version: 1.8.0
Scala version (default): 3.7.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 10.748     | 240.627           | 5.37         |
| huge.xml                  | 3.222      | 200.635           | 5.35         |
| large.xml                 | 1.281      | 100.968           | 5.29         |
| mid.xml                   | 0.793      | 16.333            | 5.20         |
| small.xml                 | 0.761      | 1.667             | 5.32         |
| tiny.xml                  | 0.686      | 0.001             | 5.29         |
