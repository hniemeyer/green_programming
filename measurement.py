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

os.system("cargo build --manifest-path=./rust/dhondt/Cargo.toml --release")
with EmissionsTracker(project_name="rust") as tracker:
     os.system("cargo run --manifest-path=./rust/dhondt/Cargo.toml --release")