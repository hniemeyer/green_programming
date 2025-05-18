from codecarbon import EmissionsTracker
import os
import subprocess

if os.path.exists("emissions.csv"):
     os.remove("emissions.csv")

os.system("dotnet build -c Release ./csharp/Adler32")
with EmissionsTracker(project_name="csharp", log_level="error") as tracker:
     os.system("dotnet run -c Release  --project ./csharp/Adler32/")

os.system("dotnet build -c Release ./csharp/Adler32Linq")
with EmissionsTracker(project_name="csharp linq", log_level="error") as tracker:
     os.system("dotnet run -c Release  --project ./csharp/Adler32Linq/")

os.system("dmd -O dlang/adler32.d -of=./dlang/adler32 -od=./dlang")
with EmissionsTracker(project_name="d", log_level="error") as tracker:
     os.system("./dlang/adler32")

os.system("gcc clang/adler32.c -std=c2x -o clang/adler32")
with EmissionsTracker(project_name="c", log_level="error") as tracker:
      os.system("./clang/adler32")

os.system("gcc clang/adler32.c -std=c2x -O3 -o clang/adler32opt")
with EmissionsTracker(project_name="c optimized", log_level="error") as tracker:
      os.system("./clang/adler32opt")

os.system("g++-14 ./cpp/adler32_ranges.cpp -std=c++23 -O3 -o ./cpp/rangesopt")
with EmissionsTracker(project_name="cpp ranges optimized", log_level="error") as tracker:
     os.system("./cpp/rangesopt")

os.system("g++-14 ./cpp/adler32_ranges.cpp -std=c++23 -o ./cpp/ranges")
with EmissionsTracker(project_name="cpp ranges", log_level="error") as tracker:
     os.system("./cpp/ranges")

os.system("g++-14 ./cpp/adler32.cpp -O3 -std=c++23 -o ./cpp/stlopt")
with EmissionsTracker(project_name="cpp stl optimized", log_level="error") as tracker:
     os.system("./cpp/stlopt")

os.system("g++-14 ./cpp/adler32.cpp -std=c++23 -o ./cpp/stl")
with EmissionsTracker(project_name="cpp stl", log_level="error") as tracker:
     os.system("./cpp/stl")

with EmissionsTracker(project_name="ruby", log_level="error") as tracker:
     os.system("ruby ./ruby/adler32.rb")

with EmissionsTracker(project_name="lua", log_level="error") as tracker:
     os.system("lua ./lua/adler32.lua")

with EmissionsTracker(project_name="elixir", log_level="error") as tracker:
     os.system("elixir ./elixir/adler32.ex")

with EmissionsTracker(project_name="java", log_level="error") as tracker:
     os.system("java ./java/Adler32Checksum.java")

os.system("cargo build --manifest-path=./rust/adler_checksum/Cargo.toml --release")
with EmissionsTracker(project_name="rust optimized", log_level="error") as tracker:
     os.system("cargo run --manifest-path=./rust/adler_checksum/Cargo.toml --release")

os.system("cargo build --manifest-path=./rust/adler_checksum/Cargo.toml")
with EmissionsTracker(project_name="rust optimized", log_level="error") as tracker:
     os.system("cargo run --manifest-path=./rust/adler_checksum/Cargo.toml")

os.system("kotlinc ./kotlin/adler32.kt -include-runtime -d ./kotlin/adler32.jar")
with EmissionsTracker(project_name="kotlin", log_level="error") as tracker:
     os.system("java -jar ./kotlin/adler32.jar")

os.system("swift build -c release --package-path swift/adler32")
with EmissionsTracker(project_name="swift", log_level="error") as tracker:
     os.system("./swift/adler32/.build/release/adler32")

os.system("tsc ./typescript/adler32.ts")
with EmissionsTracker(project_name="typescript", log_level="error") as tracker:
     os.system("node ./typescript/adler32.js")

with EmissionsTracker(project_name="python", log_level="error") as tracker:
     os.system("python3 python/adler32.py")