from codecarbon import EmissionsTracker
import os

if os.path.exists("emissions.csv"):
     os.remove("emissions.csv")

os.system("gcc-12 c/dhondt.c -std=c2x -o c/dhondt")
with EmissionsTracker(project_name="c") as tracker:
     os.system("./c/dhondt")

os.system("g++-14 ./cpp/ranges.cpp -std=c++23 -O3 -o ./cpp/ranges")
with EmissionsTracker(project_name="cpp ranges") as tracker:
     os.system("./cpp/ranges")

os.system("g++-12 ./cpp/nostl.cpp -O3 -o ./cpp/nostl")
with EmissionsTracker(project_name="cpp nostl") as tracker:
     os.system("./cpp/nostl")

os.system("g++-12 ./cpp/stl.cpp -O3 -std=c++23 -o ./cpp/stl")
with EmissionsTracker(project_name="cpp stl") as tracker:
     os.system("./cpp/stl")

with EmissionsTracker(project_name="ruby") as tracker:
     os.system("ruby ./ruby/dhondt.rb")

with EmissionsTracker(project_name="lua") as tracker:
     os.system("lua ./lua/dhondt.lua")

with EmissionsTracker(project_name="lisp") as tracker:
     os.system("clisp ./lisp/dhondt.lisp")

with EmissionsTracker(project_name="elixir") as tracker:
     os.system("elixir ./elixir/dhondt.ex")

with EmissionsTracker(project_name="java") as tracker:
     os.system("java ./java/DHondt.java")

os.system("cargo build --manifest-path=./rust/dhondt/Cargo.toml --release")
with EmissionsTracker(project_name="rust") as tracker:
     os.system("cargo run --manifest-path=./rust/dhondt/Cargo.toml --release")

os.system("kotlinc ./kotlin/dhondt.kt -include-runtime -d ./kotlin/example.jar")
with EmissionsTracker(project_name="kotlin") as tracker:
     os.system("java -jar ./kotlin/example.jar")

with EmissionsTracker(project_name="swift") as tracker:
     os.system("~/swift-5.10.1-RELEASE-ubuntu22.04/usr/bin/swift ./swift/dhondt.swift")

os.system("tsc ./typescript/dhondt.ts")
with EmissionsTracker(project_name="typescript") as tracker:
     os.system("node ./typescript/dhondt.js")

with EmissionsTracker(project_name="python") as tracker:
     os.system("python3 python/dhondt.py")