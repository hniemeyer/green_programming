from codecarbon import EmissionsTracker
import os
import subprocess

if os.path.exists("emissions.csv"):
     os.remove("emissions.csv")

os.system("dotnet build -c Release ./csharp/MonteCarloPi")
with EmissionsTracker(project_name="csharp", log_level="error") as tracker:
     os.system("dotnet run -c Release  --project ./csharp/MonteCarloPi/")

os.system("dotnet build -c Release ./csharp/MonteCarloPiLinq")
with EmissionsTracker(project_name="csharp linq", log_level="error") as tracker:
     os.system("dotnet run -c Release  --project ./csharp/MonteCarloPiLinq/")

os.system("dmd -O dlang/montecarlopi.d -of=./dlang/montecarlopi -od=./dlang")
with EmissionsTracker(project_name="d", log_level="error") as tracker:
     os.system("./dlang/montecarlopi")

os.system("gcc clang/montecarlopi.c -std=c2x -O3 -o clang/montecarlopiopt")
with EmissionsTracker(project_name="c", log_level="error") as tracker:
      os.system("./clang/montecarlopiopt")

os.system("g++-14 ./cpp/montecarlopi_ranges.cpp -std=c++23 -O3 -o ./cpp/rangesopt")
with EmissionsTracker(project_name="cpp ranges", log_level="error") as tracker:
     os.system("./cpp/rangesopt")

os.system("g++-14 ./cpp/montecarlopi.cpp -O3 -std=c++23 -o ./cpp/stlopt")
with EmissionsTracker(project_name="cpp stl", log_level="error") as tracker:
     os.system("./cpp/stlopt")

with EmissionsTracker(project_name="ruby", log_level="error") as tracker:
     os.system("ruby ./ruby/montecarlopi.rb")

with EmissionsTracker(project_name="lua", log_level="error") as tracker:
     os.system("lua ./lua/monte_carlo_pi.lua")

with EmissionsTracker(project_name="elixir", log_level="error") as tracker:
     os.system("elixir ./elixir/montecarlopi.ex")

with EmissionsTracker(project_name="java", log_level="error") as tracker:
     os.system("java ./java/MonteCarloPi.java")

os.system("cargo build --manifest-path=./rust/pi_calculation/Cargo.toml --release")
with EmissionsTracker(project_name="rust", log_level="error") as tracker:
     os.system("cargo run --manifest-path=./rust/pi_calculation/Cargo.toml --release")

os.system("kotlinc ./kotlin/montecarlopi.kt -include-runtime -d ./kotlin/montecarlopi.jar")
with EmissionsTracker(project_name="kotlin", log_level="error") as tracker:
     os.system("java -jar ./kotlin/montecarlopi.jar")

os.system("swift build -c release --package-path swift/montecarlopi")
with EmissionsTracker(project_name="swift", log_level="error") as tracker:
     os.system("./swift/montecarlopi/.build/release/montecarlopi")

os.system("tsc ./typescript/montecarlopi.ts")
with EmissionsTracker(project_name="typescript", log_level="error") as tracker:
     os.system("node ./typescript/montecarlopi.js")

with EmissionsTracker(project_name="python", log_level="error") as tracker:
     os.system("python3 python/montecarlopi.py")