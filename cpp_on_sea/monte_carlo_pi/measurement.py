from codecarbon import EmissionsTracker
import os
import subprocess

if os.path.exists("emissions.csv"):
     os.remove("emissions.csv")

os.system("dotnet build -c Release ./csharp/MonteCarloPi")
with EmissionsTracker(project_name="csharp") as tracker:
     os.system("dotnet run -c Release  --project ./csharp/MonteCarloPi/")

os.system("dotnet build -c Release ./csharp/MonteCarloPiLinq")
with EmissionsTracker(project_name="csharp linq") as tracker:
     os.system("dotnet run -c Release  --project ./csharp/MonteCarloPiLinq/")

os.system("dmd -O dlang/montecarlopi.d -of=./dlang/montecarlopi -od=./dlang")
with EmissionsTracker(project_name="d") as tracker:
     os.system("./dlang/montecarlopi")

os.system("gcc clang/montecarlopi.c -std=c2x -o clang/montecarlopi")
with EmissionsTracker(project_name="c") as tracker:
      os.system("./clang/montecarlopi")

os.system("gcc clang/montecarlopi.c -std=c2x -O3 -o clang/montecarlopiopt")
with EmissionsTracker(project_name="c optimized") as tracker:
      os.system("./clang/montecarlopiopt")

os.system("g++-14 ./cpp/montecarlopi_ranges.cpp -std=c++23 -O3 -o ./cpp/rangesopt")
with EmissionsTracker(project_name="cpp ranges optimized") as tracker:
     os.system("./cpp/rangesopt")

os.system("g++-14 ./cpp/montecarlopi_ranges.cpp -std=c++23 -o ./cpp/ranges")
with EmissionsTracker(project_name="cpp ranges") as tracker:
     os.system("./cpp/ranges")

os.system("g++-14 ./cpp/montecarlopi.cpp -O3 -std=c++23 -o ./cpp/stlopt")
with EmissionsTracker(project_name="cpp stl optimized") as tracker:
     os.system("./cpp/stlopt")

os.system("g++-14 ./cpp/montecarlopi.cpp -std=c++23 -o ./cpp/stl")
with EmissionsTracker(project_name="cpp stl") as tracker:
     os.system("./cpp/stl")

with EmissionsTracker(project_name="ruby") as tracker:
     os.system("ruby ./ruby/montecarlopi.rb")

with EmissionsTracker(project_name="lua") as tracker:
     os.system("lua ./lua/monte_carlo_pi.lua")

with EmissionsTracker(project_name="elixir") as tracker:
     os.system("elixir ./elixir/montecarlopi.ex")

with EmissionsTracker(project_name="java") as tracker:
     os.system("java ./java/MonteCarloPi.java")

os.system("cargo build --manifest-path=./rust/pi_calculation/Cargo.toml --release")
with EmissionsTracker(project_name="rust optimized") as tracker:
     os.system("cargo run --manifest-path=./rust/pi_calculation/Cargo.toml --release")

os.system("cargo build --manifest-path=./rust/pi_calculation/Cargo.toml")
with EmissionsTracker(project_name="rust optimized") as tracker:
     os.system("cargo run --manifest-path=./rust/pi_calculation/Cargo.toml")

os.system("kotlinc ./kotlin/dhondt.kt -include-runtime -d ./kotlin/montecarlopi.jar")
with EmissionsTracker(project_name="kotlin") as tracker:
     os.system("java -jar ./kotlin/montecarlopi.jar")

with EmissionsTracker(project_name="swift") as tracker:
     os.system("swift ./swift/monte_carlo_pi.swift")

os.system("tsc ./typescript/montecarlopi.ts")
with EmissionsTracker(project_name="typescript") as tracker:
     os.system("node ./typescript/montecarlopi.js")

with EmissionsTracker(project_name="python") as tracker:
     os.system("python3 python/montecarlopi.py")