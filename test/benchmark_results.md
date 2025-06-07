# Benchmark Results 06/07/2025 23:12:55

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


### giant.xml (2,586.31 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 2.163      | 1,195.499         | 1.97         |
| 2    | .NET                      | 4.098      | 631.158           | 45.91        |
| 3    | C++ (pugixml)             | 4.183      | 618.298           | 6,078.32     |
| 4    | C++ (rapidxml)            | 4.639      | 557.526           | 7,594.90     |
| 5    | Java                      | 9.471      | 273.073           | 301.96       |
| 6    | Scala                     | 9.657      | 267.826           | 5.27         |
| 7    | C++ (libxml2)             | 10.857     | 238.225           | 6.83         |
| 8    | PowerShell Core           | 12.838     | 201.454           | 149.49       |
| 9    | C++ (libxml2 XMLReader)   | 18.114     | 142.783           | 7.29         |
| 10   | C++ (Apache Xerces)       | 32.425     | 79.762            | 15.35        |
| 11   | Saxon HE 12               | 38.509     | 67.162            | 8,437.02     |
| 12   | Python 3                  | 59.670     | 43.344            | 10,092.25    |
| 13   | Node.js                   | 78.443     | 32.971            | 86.64        |


### huge.xml (646.40 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.514      | 1,256.495         | 1.93         |
| 2    | C++ (pugixml)             | 1.105      | 584.789           | 1,522.08     |
| 3    | C++ (rapidxml)            | 1.204      | 537.080           | 1,900.86     |
| 4    | .NET                      | 1.243      | 519.960           | 46.29        |
| 5    | Java                      | 2.556      | 252.890           | 122.02       |
| 6    | C++ (libxml2)             | 2.698      | 239.611           | 6.79         |
| 7    | Scala                     | 3.020      | 214.069           | 5.37         |
| 8    | PowerShell Core           | 3.863      | 167.339           | 149.70       |
| 9    | C++ (libxml2 XMLReader)   | 4.455      | 145.110           | 7.16         |
| 10   | C++ (Apache Xerces)       | 8.106      | 79.748            | 15.35        |
| 11   | Saxon HE 12               | 8.264      | 78.219            | 2,703.62     |
| 12   | Python 3                  | 15.416     | 41.932            | 2,531.69     |
| 13   | Node.js                   | 19.746     | 32.736            | 69.60        |


### large.xml (129.38 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.106      | 1,226.017         | 2.05         |
| 2    | C++ (pugixml)             | 0.227      | 569.990           | 307.22       |
| 3    | C++ (rapidxml)            | 0.257      | 503.037           | 382.96       |
| 4    | .NET                      | 0.475      | 272.308           | 43.48        |
| 5    | C++ (libxml2)             | 0.560      | 231.187           | 6.44         |
| 6    | Java                      | 0.713      | 181.460           | 100.58       |
| 7    | C++ (libxml2 XMLReader)   | 0.905      | 142.911           | 7.04         |
| 8    | Scala                     | 1.224      | 105.731           | 5.29         |
| 9    | PowerShell Core           | 1.501      | 86.197            | 149.79       |
| 10   | C++ (Apache Xerces)       | 1.643      | 78.761            | 15.52        |
| 11   | Saxon HE 12               | 2.442      | 52.972            | 910.09       |
| 12   | Python 3                  | 2.818      | 45.914            | 516.81       |
| 13   | Node.js                   | 4.000      | 32.348            | 61.11        |


### mid.xml (12.95 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.014      | 935.282           | 1.88         |
| 2    | C++ (pugixml)             | 0.027      | 475.593           | 33.89        |
| 3    | C++ (rapidxml)            | 0.027      | 473.718           | 41.29        |
| 4    | C++ (libxml2)             | 0.064      | 201.240           | 6.78         |
| 5    | C++ (libxml2 XMLReader)   | 0.095      | 136.260           | 7.35         |
| 6    | .NET                      | 0.110      | 117.305           | 35.50        |
| 7    | C++ (Apache Xerces)       | 0.175      | 74.185            | 15.43        |
| 8    | Java                      | 0.239      | 54.300            | 87.34        |
| 9    | Python 3                  | 0.262      | 49.423            | 63.31        |
| 10   | PowerShell Core           | 0.460      | 28.171            | 148.58       |
| 11   | Node.js                   | 0.478      | 27.084            | 57.79        |
| 12   | Scala                     | 0.752      | 17.223            | 5.27         |
| 13   | Saxon HE 12               | 1.234      | 10.499            | 254.98       |


### small.xml (1.27 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.004      | 354.403           | 1.95         |
| 2    | C++ (rapidxml)            | 0.006      | 218.459           | 7.04         |
| 3    | C++ (pugixml)             | 0.006      | 200.771           | 6.43         |
| 4    | C++ (libxml2)             | 0.009      | 145.848           | 6.84         |
| 5    | C++ (libxml2 XMLReader)   | 0.012      | 106.388           | 6.66         |
| 6    | C++ (Apache Xerces)       | 0.026      | 49.405            | 15.23        |
| 7    | .NET                      | 0.046      | 27.863            | 34.68        |
| 8    | Python 3                  | 0.050      | 25.632            | 17.73        |
| 9    | Node.js                   | 0.104      | 12.202            | 58.69        |
| 10   | Java                      | 0.182      | 6.985             | 75.34        |
| 11   | PowerShell Core           | 0.298      | 4.254             | 145.02       |
| 12   | Scala                     | 0.723      | 1.755             | 5.34         |
| 13   | Saxon HE 12               | 0.908      | 1.397             | 176.88       |


### tiny.xml (0.00 MB)

| Rank | Variant                   | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|------|---------------------------|------------|-------------------|--------------|
| 1    | Rust (quick-xml)          | 0.001      | 0.370             | 2.03         |
| 2    | C++ (rapidxml)            | 0.002      | 0.206             | 3.35         |
| 3    | C++ (pugixml)             | 0.002      | 0.177             | 3.41         |
| 4    | C++ (libxml2)             | 0.003      | 0.158             | 7.16         |
| 5    | C++ (libxml2 XMLReader)   | 0.003      | 0.150             | 6.96         |
| 6    | C++ (Apache Xerces)       | 0.009      | 0.049             | 15.41        |
| 7    | Python 3                  | 0.026      | 0.016             | 12.86        |
| 8    | Node.js                   | 0.036      | 0.012             | 45.37        |
| 9    | .NET                      | 0.038      | 0.011             | 33.78        |
| 10   | Java                      | 0.124      | 0.003             | 55.77        |
| 11   | PowerShell Core           | 0.268      | 0.002             | 138.71       |
| 12   | Scala                     | 0.646      | 0.001             | 5.37         |
| 13   | Saxon HE 12               | 0.822      | 0.001             | 138.41       |


## App - Results


### .NET

xml-i in .NET

```
9.0.105
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 4.098      | 631.158           | 45.91        |
| huge.xml                  | 1.243      | 519.960           | 46.29        |
| large.xml                 | 0.475      | 272.308           | 43.48        |
| mid.xml                   | 0.110      | 117.305           | 35.50        |
| small.xml                 | 0.046      | 27.863            | 34.68        |
| tiny.xml                  | 0.038      | 0.011             | 33.78        |

### C++ (Apache Xerces)

xml-i in C++ powered by Apache Xerces


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 32.425     | 79.762            | 15.35        |
| huge.xml                  | 8.106      | 79.748            | 15.35        |
| large.xml                 | 1.643      | 78.761            | 15.52        |
| mid.xml                   | 0.175      | 74.185            | 15.43        |
| small.xml                 | 0.026      | 49.405            | 15.23        |
| tiny.xml                  | 0.009      | 0.049             | 15.41        |

### C++ (libxml2 XMLReader)

xml-i in C++ powered by libxml2 XMLReader


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 18.114     | 142.783           | 7.29         |
| huge.xml                  | 4.455      | 145.110           | 7.16         |
| large.xml                 | 0.905      | 142.911           | 7.04         |
| mid.xml                   | 0.095      | 136.260           | 7.35         |
| small.xml                 | 0.012      | 106.388           | 6.66         |
| tiny.xml                  | 0.003      | 0.150             | 6.96         |

### C++ (libxml2)

xml-i in C++ powered by libxml2


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 10.857     | 238.225           | 6.83         |
| huge.xml                  | 2.698      | 239.611           | 6.79         |
| large.xml                 | 0.560      | 231.187           | 6.44         |
| mid.xml                   | 0.064      | 201.240           | 6.78         |
| small.xml                 | 0.009      | 145.848           | 6.84         |
| tiny.xml                  | 0.003      | 0.158             | 7.16         |

### C++ (pugixml)

xml-i in C++ powered by pugixml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 4.183      | 618.298           | 6,078.32     |
| huge.xml                  | 1.105      | 584.789           | 1,522.08     |
| large.xml                 | 0.227      | 569.990           | 307.22       |
| mid.xml                   | 0.027      | 475.593           | 33.89        |
| small.xml                 | 0.006      | 200.771           | 6.43         |
| tiny.xml                  | 0.002      | 0.177             | 3.41         |

### C++ (rapidxml)

xml-i in C++ powered by rapidxml


| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 4.639      | 557.526           | 7,594.90     |
| huge.xml                  | 1.204      | 537.080           | 1,900.86     |
| large.xml                 | 0.257      | 503.037           | 382.96       |
| mid.xml                   | 0.027      | 473.718           | 41.29        |
| small.xml                 | 0.006      | 218.459           | 7.04         |
| tiny.xml                  | 0.002      | 0.206             | 3.35         |

### Java

xml-i in pure Java

```
openjdk 11.0.27 2025-04-15
OpenJDK Runtime Environment (build 11.0.27+6)
OpenJDK 64-Bit Server VM (build 11.0.27+6, mixed mode)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 9.471      | 273.073           | 301.96       |
| huge.xml                  | 2.556      | 252.890           | 122.02       |
| large.xml                 | 0.713      | 181.460           | 100.58       |
| mid.xml                   | 0.239      | 54.300            | 87.34        |
| small.xml                 | 0.182      | 6.985             | 75.34        |
| tiny.xml                  | 0.124      | 0.003             | 55.77        |

### Node.js

xml-i in Node.js

```
v22.15.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 78.443     | 32.971            | 86.64        |
| huge.xml                  | 19.746     | 32.736            | 69.60        |
| large.xml                 | 4.000      | 32.348            | 61.11        |
| mid.xml                   | 0.478      | 27.084            | 57.79        |
| small.xml                 | 0.104      | 12.202            | 58.69        |
| tiny.xml                  | 0.036      | 0.012             | 45.37        |

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
| giant.xml                 | 12.838     | 201.454           | 149.49       |
| huge.xml                  | 3.863      | 167.339           | 149.70       |
| large.xml                 | 1.501      | 86.197            | 149.79       |
| mid.xml                   | 0.460      | 28.171            | 148.58       |
| small.xml                 | 0.298      | 4.254             | 145.02       |
| tiny.xml                  | 0.268      | 0.002             | 138.71       |

### Python 3

xml-i in Python 3

```
Python 3.13.3
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 59.670     | 43.344            | 10,092.25    |
| huge.xml                  | 15.416     | 41.932            | 2,531.69     |
| large.xml                 | 2.818      | 45.914            | 516.81       |
| mid.xml                   | 0.262      | 49.423            | 63.31        |
| small.xml                 | 0.050      | 25.632            | 17.73        |
| tiny.xml                  | 0.026      | 0.016             | 12.86        |

### Rust (quick-xml)

xml-i in Rust with quick-xml

```
cargo 1.86.0 (adf9b6ad1 2025-02-28)
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 2.163      | 1,195.499         | 1.97         |
| huge.xml                  | 0.514      | 1,256.495         | 1.93         |
| large.xml                 | 0.106      | 1,226.017         | 2.05         |
| mid.xml                   | 0.014      | 935.282           | 1.88         |
| small.xml                 | 0.004      | 354.403           | 1.95         |
| tiny.xml                  | 0.001      | 0.370             | 2.03         |

### Saxon HE 12

xml-i in xslt powered by Saxon HE 12

```
SaxonHE12-7J.zip
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 38.509     | 67.162            | 8,437.02     |
| huge.xml                  | 8.264      | 78.219            | 2,703.62     |
| large.xml                 | 2.442      | 52.972            | 910.09       |
| mid.xml                   | 1.234      | 10.499            | 254.98       |
| small.xml                 | 0.908      | 1.397             | 176.88       |
| tiny.xml                  | 0.822      | 0.001             | 138.41       |

### Scala

xml-i in Scala

```
Scala code runner version: 1.8.0
Scala version (default): 3.7.1
```

| File                      | Time (s)   | Throughput (MB/s) | Max Mem (MB) |
|---------------------------|------------|-------------------|--------------|
| giant.xml                 | 9.657      | 267.826           | 5.27         |
| huge.xml                  | 3.020      | 214.069           | 5.37         |
| large.xml                 | 1.224      | 105.731           | 5.29         |
| mid.xml                   | 0.752      | 17.223            | 5.27         |
| small.xml                 | 0.723      | 1.755             | 5.34         |
| tiny.xml                  | 0.646      | 0.001             | 5.37         |
