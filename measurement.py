from codecarbon import EmissionsTracker
import os

if os.path.exists("emissions.csv"):
     os.remove("emissions.csv")

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